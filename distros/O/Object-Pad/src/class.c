/* vi: set ft=xs : */
#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "object_pad.h"
#include "class.h"
#include "field.h"

#undef register_class_attribute

#ifdef HAVE_DMD_HELPER
#  define WANT_DMD_API_044
#  include "DMD_helper.h"
#endif

#include "perl-backcompat.c.inc"
#include "sv_setrv.c.inc"

#include "perl-additions.c.inc"
#include "force_list_keeping_pushmark.c.inc"
#include "optree-additions.c.inc"
#include "newOP_CUSTOM.c.inc"
#include "cv_copy_flags.c.inc"

#ifdef DEBUGGING
#  define DEBUG_OVERRIDE_PLCURCOP
#  define DEBUG_SET_CURCOP_LINE(line)    CopLINE_set(PL_curcop, line)
#else
#  undef  DEBUG_OVERRIDE_PLCURCOP
#  define DEBUG_SET_CURCOP_LINE(line)
#endif

#define need_PLparser()  ObjectPad__need_PLparser(aTHX)
void ObjectPad__need_PLparser(pTHX); /* in Object/Pad.xs */

/* Empty MGVTBL simply for locating instance backing AV */
static MGVTBL vtbl_backingav = {};

RoleEmbedding ObjectPad__embedding_standalone = {};

typedef struct ClassAttributeRegistration ClassAttributeRegistration;

struct ClassAttributeRegistration {
  ClassAttributeRegistration *next;

  const char *name;
  STRLEN permit_hintkeylen;

  const struct ClassHookFuncs *funcs;
  void *funcdata;
};

static ClassAttributeRegistration *classattrs = NULL;

static void register_class_attribute(const char *name, const struct ClassHookFuncs *funcs, void *funcdata)
{
  ClassAttributeRegistration *reg;
  Newx(reg, 1, struct ClassAttributeRegistration);

  *reg = (struct ClassAttributeRegistration){
    .name     = name,
    .funcs    = funcs,
    .funcdata = funcdata,
  };

  if(funcs->permit_hintkey)
    reg->permit_hintkeylen = strlen(funcs->permit_hintkey);
  else
    reg->permit_hintkeylen = 0;

  reg->next  = classattrs;
  classattrs = reg;
}

struct ClassHookFuncs_v57 {
  U32 ver;
  U32 flags;
  const char *permit_hintkey;
  bool (*apply)(pTHX_ ClassMeta *classmeta, SV *value, SV **hookdata_ptr, void *funcdata);
  /* No pre- or post-seal */
  void (*post_add_field)(pTHX_ ClassMeta *classmeta, SV *hookdata, void *funcdata, FieldMeta *fieldmeta);
};

void ObjectPad_register_class_attribute(pTHX_ const char *name, const struct ClassHookFuncs *funcs, void *funcdata)
{
  if(funcs->ver < 57)
    croak("Mismatch in third-party class attribute ABI version field: module wants %d, we require >= 57\n",
        funcs->ver);
  if(funcs->ver > OBJECTPAD_ABIVERSION)
    croak("Mismatch in third-party class attribute ABI version field: attribute supplies %d, module wants %d\n",
        funcs->ver, OBJECTPAD_ABIVERSION);

  if(!name || !(name[0] >= 'A' && name[0] <= 'Z'))
    croak("Third-party class attribute names must begin with a capital letter");

  if(!funcs->permit_hintkey)
    croak("Third-party class attributes require a permit hinthash key");

  if(funcs->ver < OBJECTPAD_ABIVERSION) {
    const struct ClassHookFuncs_v57 *funcs_v57 = (const struct ClassHookFuncs_v57 *)funcs;

    struct ClassHookFuncs *funcs_v76;
    Newx(funcs_v76, 1, struct ClassHookFuncs);

    *funcs_v76 = (struct ClassHookFuncs){
      .ver            = OBJECTPAD_ABIVERSION,
      .flags          = funcs_v57->flags,
      .permit_hintkey = funcs_v57->permit_hintkey,
      .apply          = funcs_v57->apply,
      .post_add_field = funcs_v57->post_add_field,
    };

    funcs = funcs_v76;
  }

  register_class_attribute(name, funcs, funcdata);
}

void ObjectPad_mop_class_apply_attribute(pTHX_ ClassMeta *classmeta, const char *name, SV *value)
{
  HV *hints = GvHV(PL_hintgv);

  if(value && (!SvPOK(value) || !SvCUR(value)))
    value = NULL;

  ClassAttributeRegistration *reg;
  for(reg = classattrs; reg; reg = reg->next) {
    if(!strEQ(name, reg->name))
      continue;

    if(reg->funcs->permit_hintkey &&
        (!hints || !hv_fetch(hints, reg->funcs->permit_hintkey, reg->permit_hintkeylen, 0)))
      continue;

    if((reg->funcs->flags & OBJECTPAD_FLAG_ATTR_NO_VALUE) && value)
      croak("Attribute :%s does not permit a value", name);
    if((reg->funcs->flags & OBJECTPAD_FLAG_ATTR_MUST_VALUE) && !value)
      croak("Attribute :%s requires a value", name);

    SV *hookdata = value;

    if(reg->funcs->apply) {
      if(!(*reg->funcs->apply)(aTHX_ classmeta, value, &hookdata, reg->funcdata))
        return;
    }

    if(!classmeta->hooks)
      classmeta->hooks = newAV();

    struct ClassHook *hook;
    Newx(hook, 1, struct ClassHook);

    *hook = (struct ClassHook){
      .funcs    = reg->funcs,
      .funcdata = reg->funcdata,
      .hookdata = hookdata,
    };

    av_push(classmeta->hooks, (SV *)hook);

    if(value && value != hookdata)
      SvREFCNT_dec(value);

    return;
  }

  croak("Unrecognised class attribute :%s", name);
}

/* TODO: get attribute */

ClassMeta *ObjectPad_mop_get_class_for_stash(pTHX_ HV *stash)
{
  GV **gvp = (GV **)hv_fetchs(stash, "META", 0);
  if(!gvp)
    croak("Unable to find ClassMeta for %" HEKf, HEKfARG(HvNAME_HEK(stash)));

  return NUM2PTR(ClassMeta *, SvUV(SvRV(GvSV(*gvp))));
}

SV *ObjectPad_mop_class_get_name(pTHX_ ClassMeta *class)
{
  return class->name;
}

#define make_instance_fields(classmeta, backingav, roleoffset)  S_make_instance_fields(aTHX_ classmeta, backingav, roleoffset)
static void S_make_instance_fields(pTHX_ const ClassMeta *classmeta, AV *backingav, FIELDOFFSET roleoffset)
{
  assert(classmeta->type == METATYPE_ROLE || roleoffset == 0);

  if(classmeta->start_fieldix) {
    /* Superclass actually has some fields */
    assert(classmeta->type == METATYPE_CLASS);
    assert(classmeta->cls.supermeta->sealed);

    make_instance_fields(classmeta->cls.supermeta, backingav, 0);
  }

  AV *fields = classmeta->direct_fields;
  I32 nfields = av_count(fields);

  av_extend(backingav, classmeta->next_fieldix - 1 + roleoffset);

  I32 i;
  for(i = 0; i < nfields; i++) {
    FieldMeta *fieldmeta = (FieldMeta *)AvARRAY(fields)[i];
    char sigil = SvPV_nolen(fieldmeta->name)[0];

    assert(av_count(backingav) == fieldmeta->fieldix + roleoffset);

    switch(sigil) {
      case '$':
        av_push(backingav, newSV(0));
        break;

      case '@':
        av_push(backingav, newRV_noinc((SV *)newAV()));
        break;

      case '%':
        av_push(backingav, newRV_noinc((SV *)newHV()));
        break;

      default:
        croak("ARGH: not sure how to handle a slot sigil %c\n", sigil);
    }
  }

  if(classmeta->type == METATYPE_CLASS) {
    U32 nroles;
    RoleEmbedding **embeddings = mop_class_get_direct_roles(classmeta, &nroles);

    assert(classmeta->type == METATYPE_CLASS || nroles == 0);

    for(i = 0; i < nroles; i++) {
      RoleEmbedding *embedding = embeddings[i];
      ClassMeta *rolemeta = embedding->rolemeta;

      assert(rolemeta->sealed);

      make_instance_fields(rolemeta, backingav, embedding->offset);
    }
  }
}

SV *ObjectPad_get_obj_backingav(pTHX_ SV *self, enum ReprType repr, bool create)
{
  SV *rv = SvRV(self);

  switch(repr) {
    case REPR_NATIVE:
      if(SvTYPE(rv) != SVt_PVAV)
        croak("Not an ARRAY reference");

      return rv;

    case REPR_HASH:
    case_REPR_HASH:
    {
      if(SvTYPE(rv) != SVt_PVHV)
        croak("Not a HASH reference");
      SV **backingsvp = hv_fetchs((HV *)rv, "Object::Pad/slots", create);
      if(create && !SvOK(*backingsvp))
        sv_setrv_noinc(*backingsvp, (SV *)newAV());

      /* A method invoked during a superclass constructor of a classic perl
       * class might encounter $self without fields. If this is the case we'll
       * have to create the fields now
       *   https://rt.cpan.org/Ticket/Display.html?id=132263
       */
      if(!backingsvp) {
        struct ClassMeta *classmeta = mop_get_class_for_stash(SvSTASH(rv));
        AV *backingav = newAV();

        make_instance_fields(classmeta, backingav, 0);

        backingsvp = hv_fetchs((HV *)rv, "Object::Pad/slots", TRUE);
        sv_setrv_noinc(*backingsvp, (SV *)backingav);
      }
      if(!SvROK(*backingsvp) || SvTYPE(SvRV(*backingsvp)) != SVt_PVAV)
        croak("Expected $self->{\"Object::Pad/slots\"} to be an ARRAY reference");
      return SvRV(*backingsvp);
    }

    case REPR_MAGIC:
    case_REPR_MAGIC:
    {
      MAGIC *mg = mg_findext(rv, PERL_MAGIC_ext, &vtbl_backingav);
      if(!mg && create)
        mg = sv_magicext(rv, (SV *)newAV(), PERL_MAGIC_ext, &vtbl_backingav, NULL, 0);
      if(!mg)
        croak("Expected to find backing AV magic extension");
      return mg->mg_obj;
    }

    case REPR_AUTOSELECT:
      if(SvTYPE(rv) == SVt_PVHV)
        goto case_REPR_HASH;
      goto case_REPR_MAGIC;
  }

  croak("ARGH unhandled repr type");
}

#define embed_cv(cv, embedding)  S_embed_cv(aTHX_ cv, embedding)
static CV *S_embed_cv(pTHX_ CV *cv, RoleEmbedding *embedding)
{
  assert(cv);
  assert(CvOUTSIDE(cv));

  /* Perl core's cv_clone() would break in some situation here; see
   *   https://rt.cpan.org/Ticket/Display.html?id=141483
   */
  CV *embedded_cv = cv_copy_flags(cv, 0);
  SV *embeddingsv = embedding->embeddingsv;

  assert(SvTYPE(embeddingsv) == SVt_PV && SvLEN(embeddingsv) >= sizeof(RoleEmbedding));

  PAD *pad1 = PadlistARRAY(CvPADLIST(embedded_cv))[1];
  PadARRAY(pad1)[PADIX_EMBEDDING] = SvREFCNT_inc(embeddingsv);

  return embedded_cv;
}

RoleEmbedding **ObjectPad_mop_class_get_direct_roles(pTHX_ const ClassMeta *meta, U32 *nroles)
{
  assert(meta->type == METATYPE_CLASS);
  AV *roles = meta->cls.direct_roles;
  *nroles = av_count(roles);
  return (RoleEmbedding **)AvARRAY(roles);
}

RoleEmbedding **ObjectPad_mop_class_get_all_roles(pTHX_ const ClassMeta *meta, U32 *nroles)
{
  assert(meta->type == METATYPE_CLASS);
  AV *roles = meta->cls.embedded_roles;
  *nroles = av_count(roles);
  return (RoleEmbedding **)AvARRAY(roles);
}

void ObjectPad__prepare_method_parse(pTHX_ ClassMeta *meta)
{
  /* Save the methodscope for this subparse, in case of nested methods
   *   (RT132321)
   */
  SAVESPTR(meta->methodscope);

  /* While creating the new scope CV we need to ENTER a block so as not to
   * break any interpvars
   */
  ENTER;
  SAVESPTR(PL_comppad);
  SAVESPTR(PL_comppad_name);
  SAVESPTR(PL_curpad);

  CV *methodscope = meta->methodscope = MUTABLE_CV(newSV_type(SVt_PVCV));
  CvPADLIST(methodscope) = pad_new(padnew_SAVE);

  PL_comppad = PadlistARRAY(CvPADLIST(methodscope))[1];
  PL_comppad_name = PadlistNAMES(CvPADLIST(methodscope));
  PL_curpad  = AvARRAY(PL_comppad);

  AV *fields = meta->direct_fields;
  U32 nfields = av_count(fields);

  U32 i;
  for(i = 0; i < nfields; i++) {
    FieldMeta *fieldmeta = (FieldMeta *)AvARRAY(fields)[i];

    /* Skip the anonymous ones */
    if(SvCUR(fieldmeta->name) < 2)
      continue;

    /* Claim these are all STATE variables just to quiet the "will not stay
     * shared" warning */
    pad_add_name_sv(fieldmeta->name, padadd_STATE, NULL, NULL);
  }

  intro_my();

  LEAVE;
}

void ObjectPad__start_method_parse(pTHX_ ClassMeta *meta, bool is_common)
{
  /* Splice in the field scope CV in */
  CV *methodscope = meta->methodscope;

  if(CvANON(PL_compcv))
    CvANON_on(methodscope);

  CvOUTSIDE    (methodscope) = CvOUTSIDE    (PL_compcv);
  CvOUTSIDE_SEQ(methodscope) = CvOUTSIDE_SEQ(PL_compcv);

  CvOUTSIDE(PL_compcv) = methodscope;

  if(!is_common)
    /* instance method */
    extend_pad_vars(meta);
  else {
    /* :common method */
    PADOFFSET padix;

    padix = pad_add_name_pvs("$class", 0, NULL, NULL);
    if(padix != PADIX_SELF)
      croak("ARGH: Expected that padix[$class] = 1");
  }

  if(meta->type == METATYPE_ROLE) {
    PAD *pad1 = PadlistARRAY(CvPADLIST(PL_compcv))[1];

    if(meta->role_is_invokable) {
      SV *sv = PadARRAY(pad1)[PADIX_EMBEDDING];
      sv_setpvn(sv, "", 0);
      SvPVX(sv) = (void *)&ObjectPad__embedding_standalone;
    }
    else {
      SvREFCNT_dec(PadARRAY(pad1)[PADIX_EMBEDDING]);
      PadARRAY(pad1)[PADIX_EMBEDDING] = &PL_sv_undef;
    }
  }

  intro_my();
}

#define find_padix_for_field(fieldmeta)  S_find_padix_for_field(aTHX_ fieldmeta)
static PADOFFSET S_find_padix_for_field(pTHX_ FieldMeta *fieldmeta)
{
  const char *fieldname = SvPVX(fieldmeta->name);
#if HAVE_PERL_VERSION(5, 20, 0)
  const PADNAMELIST *nl = PadlistNAMES(CvPADLIST(PL_compcv));
  PADNAME **names = PadnamelistARRAY(nl);
  PADOFFSET padix;

  for(padix = 1; padix <= PadnamelistMAXNAMED(nl); padix++) {
    PADNAME *name = names[padix];

    if(!name || !PadnameLEN(name))
      continue;

    const char *pv = PadnamePV(name);
    if(!pv)
      continue;

    /* field names are all OUTER vars. This is necessary so we don't get
     * confused by signatures params of the same name
     *   https://rt.cpan.org/Ticket/Display.html?id=134456
     */
    if(!PadnameOUTER(name))
      continue;
    if(!strEQ(pv, fieldname))
      continue;

    /* TODO: for extra robustness we could compare the SV * in the pad itself */

    return padix;
  }

  return NOT_IN_PAD;
#else
  /* Before the new pad API, the best we can do is call pad_findmy_pv()
   * It won't get confused about signatures params because these perls are too
   * old for signatures anyway
   */
  return pad_findmy_pv(fieldname, 0);
#endif
}

OP *ObjectPad__finish_method_parse(pTHX_ ClassMeta *meta, bool is_common, OP *body)
{
  PADNAMELIST *fieldnames = PadlistNAMES(CvPADLIST(meta->methodscope));
  I32 nfields = av_count(meta->direct_fields);
  PADNAME **snames = PadnamelistARRAY(fieldnames);
  PADNAME **padnames = PadnamelistARRAY(PadlistNAMES(CvPADLIST(PL_compcv)));

  /* If we have no body that means this was a bodyless method
   * declaration; a required method for a role
   */
  if(body && !is_common) {
    OP *fieldops = NULL, *methstartop;
#if HAVE_PERL_VERSION(5, 22, 0)
    U32 cop_seq_low = COP_SEQ_RANGE_LOW(padnames[PADIX_SELF]);
#endif

#ifdef METHSTART_CONTAINS_FIELD_BINDINGS
    AV *fieldmap = newAV();
    U32 fieldcount = 0, max_fieldix = 0;

    SAVEFREESV((SV *)fieldmap);
#endif

    {
      ENTER;
      SAVEVPTR(PL_curcop);

      /* See https://rt.cpan.org/Ticket/Display.html?id=132428
       *   https://github.com/Perl/perl5/issues/17754
       */
      PADOFFSET padix;
      for(padix = PADIX_SELF + 1; padix <= PadnamelistMAX(PadlistNAMES(CvPADLIST(PL_compcv))); padix++) {
        PADNAME *pn = padnames[padix];

        if(PadnameIsNULL(pn) || !PadnameLEN(pn))
          continue;

        const char *pv = PadnamePV(pn);
        if(!pv || !strEQ(pv, "$self"))
          continue;

        COP *padcop = NULL;
        if(find_cop_for_lvintro(padix, body, &padcop))
          PL_curcop = padcop;
        warn("\"my\" variable $self masks earlier declaration in same scope");
      }

      LEAVE;
    }

    fieldops = op_append_list(OP_LINESEQ, fieldops,
      newSTATEOP(0, NULL, NULL));
    fieldops = op_append_list(OP_LINESEQ, fieldops,
      (methstartop = newMETHSTARTOP(0 |
        (meta->type == METATYPE_ROLE ? OPf_SPECIAL : 0) |
        (meta->repr << 8))));

    int i;
    for(i = 0; i < nfields; i++) {
      FieldMeta *fieldmeta = (FieldMeta *)AvARRAY(meta->direct_fields)[i];
      PADNAME *fieldname = snames[i + 1];

      if(!fieldname
#if HAVE_PERL_VERSION(5, 22, 0)
        /* On perl 5.22 and above we can use PadnameREFCNT to detect which pad
         * slots are actually being used
         */
         || PadnameREFCNT(fieldname) < 2
#endif
        )
          continue;

      FIELDOFFSET fieldix = fieldmeta->fieldix;
      PADOFFSET padix = find_padix_for_field(fieldmeta);

      if(padix == NOT_IN_PAD)
        continue;

      U8 private = 0;
      switch(SvPV_nolen(fieldmeta->name)[0]) {
        case '$': private = OPpFIELDPAD_SV; break;
        case '@': private = OPpFIELDPAD_AV; break;
        case '%': private = OPpFIELDPAD_HV; break;
      }

#ifdef METHSTART_CONTAINS_FIELD_BINDINGS
      assert((fieldix & ~FIELDIX_MASK) == 0);
      av_store(fieldmap, padix, newSVuv(((UV)private << FIELDIX_TYPE_SHIFT) | fieldix));
      fieldcount++;
      if(fieldix > max_fieldix)
        max_fieldix = fieldix;
#else
      fieldops = op_append_list(OP_LINESEQ, fieldops,
        /* alias the padix from the field */
        newFIELDPADOP(private << 8, padix, fieldix));
#endif

#if HAVE_PERL_VERSION(5, 22, 0)
      /* Unshare the padname so the one in the methodscope pad returns to refcount 1 */
      PADNAME *newpadname = newPADNAMEpvn(PadnamePV(fieldname), PadnameLEN(fieldname));
      PadnameREFCNT_dec(padnames[padix]);
      padnames[padix] = newpadname;

      /* Turn off OUTER and set a valid COP sequence range, so the lexical is
       * visible to eval(), PadWalker, perldb, etc.. */
      PadnameOUTER_off(newpadname);
      COP_SEQ_RANGE_LOW(newpadname) = cop_seq_low;
      COP_SEQ_RANGE_HIGH(newpadname) = PL_cop_seqmax;
#endif
    }

#ifdef METHSTART_CONTAINS_FIELD_BINDINGS
    if(fieldcount) {
      UNOP_AUX_item *aux;
      Newx(aux, 2 + fieldcount*2, UNOP_AUX_item);
      cUNOP_AUXx(methstartop)->op_aux = aux;

      (aux++)->uv = fieldcount;
      (aux++)->uv = max_fieldix;

      for(Size_t i = 0; i < av_count(fieldmap); i++) {
        if(!AvARRAY(fieldmap)[i] || !SvOK(AvARRAY(fieldmap)[i]))
          continue;

        (aux++)->uv = i;
        (aux++)->uv = SvUV(AvARRAY(fieldmap)[i]);
      }
    }
#endif
    body = op_append_list(OP_LINESEQ, fieldops, body);
  }
  else if(body && is_common) {
    body = op_append_list(OP_LINESEQ,
      newCOMMONMETHSTARTOP(0 | (meta->repr << 8)),
      body);
  }

  meta->methodscope = NULL;

  /* Restore CvOUTSIDE(PL_compcv) back to where it should be */
  {
    CV *outside = CvOUTSIDE(PL_compcv);
    PADNAMELIST *pnl = PadlistNAMES(CvPADLIST(PL_compcv));
    PADNAMELIST *outside_pnl = PadlistNAMES(CvPADLIST(outside));

    /* Lexical captures will need their parent pad index fixing
     * Technically these only matter for CvANON because they're only used when
     * reconstructing the parent pad captures by OP_ANONCODE. But we might as
     * well be polite and fix them for all CVs
     */
    PADOFFSET padix;
    for(padix = 1; padix <= PadnamelistMAX(pnl); padix++) {
      PADNAME *pn = PadnamelistARRAY(pnl)[padix];
      if(PadnameIsNULL(pn) ||
         !PadnameOUTER(pn) ||
         !PARENT_PAD_INDEX(pn))
        continue;

      PADNAME *outside_pn = PadnamelistARRAY(outside_pnl)[PARENT_PAD_INDEX(pn)];

      PARENT_PAD_INDEX_set(pn, PARENT_PAD_INDEX(outside_pn));
      if(!PadnameOUTER(outside_pn))
        PadnameOUTER_off(pn);
    }

    CvOUTSIDE(PL_compcv)     = CvOUTSIDE(outside);
    CvOUTSIDE_SEQ(PL_compcv) = CvOUTSIDE_SEQ(outside);
  }

  return body;
}

MethodMeta *ObjectPad_mop_class_add_method(pTHX_ ClassMeta *meta, SV *methodname)
{
  AV *methods = meta->direct_methods;

  if(meta->sealed)
    croak("Cannot add a new method to an already-sealed class");

  if(!methodname || !SvOK(methodname) || !SvCUR(methodname))
    croak("methodname must not be undefined or empty");

  U32 i;
  for(i = 0; i < av_count(methods); i++) {
    MethodMeta *methodmeta = (MethodMeta *)AvARRAY(methods)[i];
    if(sv_eq(methodmeta->name, methodname)) {
      if(methodmeta->role)
        croak("Method '%" SVf "' clashes with the one provided by role %" SVf,
          SVfARG(methodname), SVfARG(methodmeta->role->name));
      else
        croak("Cannot add another method named %" SVf, methodname);
    }
  }

  MethodMeta *methodmeta;
  Newx(methodmeta, 1, MethodMeta);

  *methodmeta = (MethodMeta){
    .name  = SvREFCNT_inc(methodname),
    .class = meta,
  };

  av_push(methods, (SV *)methodmeta);

  return methodmeta;
}

MethodMeta *ObjectPad_mop_class_add_method_cv(pTHX_ ClassMeta *meta, SV *methodname, CV *cv)
{
  MethodMeta *methodmeta = mop_class_add_method(meta, methodname);

  I32 klen = SvCUR(methodname);
  if(SvUTF8(methodname))
    klen = -klen;
  GV **gvp = (GV **)hv_fetch(meta->stash, SvPVX(methodname), klen, GV_ADD);
  gv_init_sv(*gvp, meta->stash, methodname, 0);
  GvMULTI_on(*gvp);

  GvCV_set(*gvp, cv);
  CvGV_set(cv, *gvp);

  return methodmeta;
}

FieldMeta *ObjectPad_mop_class_add_field(pTHX_ ClassMeta *meta, SV *fieldname)
{
  AV *fields = meta->direct_fields;

  if(meta->next_fieldix == -1)
    croak("Cannot add a new field to a class that is not yet begun");
  if(meta->sealed)
    croak("Cannot add a new field to an already-sealed class");

  if(!fieldname || !SvOK(fieldname) || !SvCUR(fieldname))
    croak("fieldname must not be undefined or empty");

  switch(SvPV_nolen(fieldname)[0]) {
    case '$':
    case '@':
    case '%':
      break;

    default:
      croak("fieldname must begin with a sigil");
  }

  U32 i;
  for(i = 0; i < av_count(fields); i++) {
    FieldMeta *fieldmeta = (FieldMeta *)AvARRAY(fields)[i];
    if(SvCUR(fieldmeta->name) < 2)
      continue;

    if(sv_eq(fieldmeta->name, fieldname))
      croak("Cannot add another field named %" SVf, fieldname);
  }

  FieldMeta *fieldmeta = mop_create_field(fieldname, meta);

  av_push(fields, (SV *)fieldmeta);
  meta->next_fieldix++;

  MOP_CLASS_RUN_HOOKS(meta, post_add_field, fieldmeta);

  return fieldmeta;
}

void ObjectPad_mop_class_add_BUILD(pTHX_ ClassMeta *meta, CV *cv)
{
  if(meta->sealed)
    croak("Cannot add a BUILD block to an already-sealed class");
  if(meta->strict_params)
    croak("Cannot add a BUILD block to a class with :strict(params)");

  if(!meta->buildblocks)
    meta->buildblocks = newAV();

  av_push(meta->buildblocks, (SV *)cv);
}

void ObjectPad_mop_class_add_ADJUST(pTHX_ ClassMeta *meta, CV *cv)
{
  if(meta->sealed)
    croak("Cannot add an ADJUST(PARAMS) block to an already-sealed class");
  if(!meta->adjustblocks)
    meta->adjustblocks = newAV();

  AdjustBlock *block;
  Newx(block, 1, struct AdjustBlock);

  *block = (struct AdjustBlock){
    .cv = cv,
  };

  meta->has_adjust = true;

  av_push(meta->adjustblocks, (SV *)block);
}

void ObjectPad_mop_class_add_required_method(pTHX_ ClassMeta *meta, SV *methodname)
{
  if(meta->type != METATYPE_ROLE)
    croak("Can only add a required method to a role");
  if(meta->sealed)
    croak("Cannot add a new required method to an already-sealed class");

  av_push(meta->requiremethods, SvREFCNT_inc(methodname));
}

#define mop_class_implements_role(meta, rolemeta)  S_mop_class_implements_role(aTHX_ meta, rolemeta)
static bool S_mop_class_implements_role(pTHX_ ClassMeta *meta, ClassMeta *rolemeta)
{
  U32 i, n;
  switch(meta->type) {
    case METATYPE_CLASS: {
      RoleEmbedding **embeddings = mop_class_get_all_roles(meta, &n);
      for(i = 0; i < n; i++)
        if(embeddings[i]->rolemeta == rolemeta)
          return true;

      break;
    }

    case METATYPE_ROLE: {
      ClassMeta **roles = (ClassMeta **)AvARRAY(meta->role.superroles);
      U32 n = av_count(meta->role.superroles);
      /* TODO: this isn't super-efficient in deep cross-linked heirarchies */
      for(i = 0; i < n; i++) {
        if(roles[i] == rolemeta)
          return true;
        if(mop_class_implements_role(roles[i], rolemeta))
          return true;
      }
      break;
    }
  }

  return false;
}

#define embed_role(class, role)  S_embed_role(aTHX_ class, role)
static RoleEmbedding *S_embed_role(pTHX_ ClassMeta *classmeta, ClassMeta *rolemeta)
{
  U32 i;

  if(classmeta->type != METATYPE_CLASS)
    croak("Can only apply to a class");
  if(rolemeta->type != METATYPE_ROLE)
    croak("Can only apply a role to a class");

  HV *srcstash = rolemeta->stash;
  HV *dststash = classmeta->stash;

  SV *embeddingsv = newSV(sizeof(RoleEmbedding));
  assert(SvTYPE(embeddingsv) == SVt_PV && SvLEN(embeddingsv) >= sizeof(RoleEmbedding));

  RoleEmbedding *embedding = (RoleEmbedding *)SvPVX(embeddingsv);

  embedding->embeddingsv = embeddingsv;
  embedding->rolemeta    = rolemeta;
  embedding->classmeta   = classmeta;
  embedding->offset      = -1;

  av_push(classmeta->cls.embedded_roles, (SV *)embedding);
  hv_store_ent(rolemeta->role.applied_classes, classmeta->name, (SV *)embedding, 0);

  U32 nbuilds = rolemeta->buildblocks ? av_count(rolemeta->buildblocks) : 0;
  for(i = 0; i < nbuilds; i++) {
    CV *buildblock = (CV *)AvARRAY(rolemeta->buildblocks)[i];

    CV *embedded_buildblock = embed_cv(buildblock, embedding);

    if(!classmeta->buildblocks)
      classmeta->buildblocks = newAV();

    av_push(classmeta->buildblocks, (SV *)embedded_buildblock);
  }

  U32 nadjusts = rolemeta->adjustblocks ? av_count(rolemeta->adjustblocks) : 0;
  for(i = 0; i < nadjusts; i++) {
    AdjustBlock *block = (AdjustBlock *)AvARRAY(rolemeta->adjustblocks)[i];

    CV *embedded_cv = embed_cv(block->cv, embedding);

    mop_class_add_ADJUST(classmeta, embedded_cv);
  }

  if(rolemeta->has_adjust)
    classmeta->has_adjust = true;

  U32 nmethods = av_count(rolemeta->direct_methods);
  for(i = 0; i < nmethods; i++) {
    MethodMeta *methodmeta = (MethodMeta *)AvARRAY(rolemeta->direct_methods)[i];
    SV *mname = methodmeta->name;

    HE *he = hv_fetch_ent(srcstash, mname, 0, 0);
    if(!he || !HeVAL(he) || !GvCV((GV *)HeVAL(he)))
      croak("ARGH expected to find CODE called %" SVf " in package %" SVf,
        SVfARG(mname), SVfARG(rolemeta->name));

    {
      MethodMeta *dstmethodmeta = mop_class_add_method(classmeta, mname);
      dstmethodmeta->role = rolemeta;
      dstmethodmeta->is_common = methodmeta->is_common;
    }

    GV **gvp = (GV **)hv_fetch(dststash, SvPVX(mname), SvCUR(mname), GV_ADD);
    gv_init_sv(*gvp, dststash, mname, 0);
    GvMULTI_on(*gvp);

    if(GvCV(*gvp))
      croak("Method '%" SVf "' clashes with the one provided by role %" SVf,
        SVfARG(mname), SVfARG(rolemeta->name));

    CV *newcv;
    GvCV_set(*gvp, newcv = embed_cv(GvCV((GV *)HeVAL(he)), embedding));
    CvGV_set(newcv, *gvp);
  }

  nmethods = av_count(rolemeta->requiremethods);
  for(i = 0; i < nmethods; i++) {
    av_push(classmeta->requiremethods, SvREFCNT_inc(AvARRAY(rolemeta->requiremethods)[i]));
  }

  return embedding;
}

void ObjectPad_mop_class_add_role(pTHX_ ClassMeta *dstmeta, ClassMeta *rolemeta)
{
  if(dstmeta->sealed)
    croak("Cannot add a role to an already-sealed class");
  /* Can't currently do this as it breaks t/77mop-create-role.t
  if(!rolemeta->sealed)
    croak("Cannot add a role that is not yet sealed");
   */

  if(mop_class_implements_role(dstmeta, rolemeta))
    return;

  switch(dstmeta->type) {
    case METATYPE_CLASS: {
      U32 nroles;
      if((nroles = av_count(rolemeta->role.superroles)) > 0) {
        ClassMeta **roles = (ClassMeta **)AvARRAY(rolemeta->role.superroles);
        U32 i;
        for(i = 0; i < nroles; i++)
          mop_class_add_role(dstmeta, roles[i]);
      }

      RoleEmbedding *embedding = embed_role(dstmeta, rolemeta);
      av_push(dstmeta->cls.direct_roles, (SV *)embedding);
      return;
    }

    case METATYPE_ROLE:
      av_push(dstmeta->role.superroles, (SV *)rolemeta);
      return;
  }
}

void ObjectPad_mop_class_load_and_add_role(pTHX_ ClassMeta *meta, SV *rolename, SV *rolever)
{
  HV *rolestash = gv_stashsv(rolename, 0);
  if(!rolestash || !hv_fetchs(rolestash, "META", 0)) {
    /* Try to`require` the module then attempt a second time */
    load_module(PERL_LOADMOD_NOIMPORT, newSVsv(rolename), NULL, NULL);
    rolestash = gv_stashsv(rolename, 0);
  }

  if(!rolestash)
    croak("Role %" SVf " does not exist", SVfARG(rolename));

  if(rolever && SvOK(rolever))
    ensure_module_version(rolename, rolever);

  GV **metagvp = (GV **)hv_fetchs(rolestash, "META", 0);
  ClassMeta *rolemeta = NULL;
  if(metagvp)
    rolemeta = NUM2PTR(ClassMeta *, SvUV(SvRV(GvSV(*metagvp))));

  if(!rolemeta || rolemeta->type != METATYPE_ROLE)
    croak("%" SVf " is not a role", SVfARG(rolename));

  mop_class_add_role(meta, rolemeta);
}

#define embed_fieldhook(roleh, offset)  S_embed_fieldhook(aTHX_ roleh, offset)
static struct FieldHook *S_embed_fieldhook(pTHX_ struct FieldHook *roleh, FIELDOFFSET offset)
{
  struct FieldHook *classh;
  Newx(classh, 1, struct FieldHook);

  *classh = (struct FieldHook){
    .fieldix   = roleh->fieldix + offset,
    .fieldmeta = roleh->fieldmeta,
    .funcs     = roleh->funcs,
    .hookdata  = roleh->hookdata,
  };

  return classh;
}

#define mop_class_apply_role(embedding)  S_mop_class_apply_role(aTHX_ embedding)
static void S_mop_class_apply_role(pTHX_ RoleEmbedding *embedding)
{
  ClassMeta *classmeta = embedding->classmeta;
  ClassMeta *rolemeta  = embedding->rolemeta;

  if(classmeta->type != METATYPE_CLASS)
    croak("Can only apply to a class");
  if(rolemeta->type != METATYPE_ROLE)
    croak("Can only apply a role to a class");

  assert(embedding->offset == -1);
  embedding->offset = classmeta->next_fieldix;

  if(rolemeta->parammap) {
    HV *src = rolemeta->parammap;

    if(!classmeta->parammap)
      classmeta->parammap = newHV();

    HV *dst = classmeta->parammap;

    hv_iterinit(src);

    HE *iter;
    while((iter = hv_iternext(src))) {
      STRLEN klen = HeKLEN(iter);
      void *key = HeKEY(iter);

      if(klen < 0 ? hv_exists_ent(dst, (SV *)key, HeHASH(iter))
                  : hv_exists(dst, (char *)key, klen))
        croak("Named parameter '%" SVf "' clashes with the one provided by role %" SVf,
          SVfARG(HeSVKEY_force(iter)), SVfARG(rolemeta->name));

      ParamMeta *roleparammeta = (ParamMeta *)HeVAL(iter);
      ParamMeta *classparammeta;
      Newx(classparammeta, 1, struct ParamMeta);

      *classparammeta = (struct ParamMeta){
        .name  = SvREFCNT_inc(roleparammeta->name),
        .class = roleparammeta->class,
        .type  = roleparammeta->type,
      };

      switch(roleparammeta->type) {
        case PARAM_FIELD:
          classparammeta->field.fieldmeta = roleparammeta->field.fieldmeta;
          classparammeta->field.fieldix   = roleparammeta->field.fieldix + embedding->offset;
          break;

        case PARAM_ADJUST:
          classparammeta->adjust.padix   = roleparammeta->adjust.padix;
          classparammeta->adjust.defexpr = roleparammeta->adjust.defexpr; /* no refcnt on optrees */
          break;
      }

      if(klen < 0)
        hv_store_ent(dst, HeSVKEY(iter), (SV *)classparammeta, HeHASH(iter));
      else
        hv_store(dst, HeKEY(iter), klen, (SV *)classparammeta, HeHASH(iter));
    }
  }

  if(rolemeta->fieldhooks_initfield) {
    if(!classmeta->fieldhooks_initfield)
      classmeta->fieldhooks_initfield = newAV();

    U32 i;
    for(i = 0; i < av_count(rolemeta->fieldhooks_initfield); i++) {
      struct FieldHook *roleh = (struct FieldHook *)AvARRAY(rolemeta->fieldhooks_initfield)[i];
      av_push(classmeta->fieldhooks_initfield, (SV *)embed_fieldhook(roleh, embedding->offset));
    }
  }

  if(rolemeta->fieldhooks_construct) {
    if(!classmeta->fieldhooks_construct)
      classmeta->fieldhooks_construct = newAV();

    U32 i;
    for(i = 0; i < av_count(rolemeta->fieldhooks_construct); i++) {
      struct FieldHook *roleh = (struct FieldHook *)AvARRAY(rolemeta->fieldhooks_construct)[i];
      av_push(classmeta->fieldhooks_construct, (SV *)embed_fieldhook(roleh, embedding->offset));
    }
  }

  classmeta->next_fieldix += av_count(rolemeta->direct_fields);

  /* TODO: Run an APPLY block if the role has one */
}

static void S_apply_roles(pTHX_ ClassMeta *dstmeta, ClassMeta *srcmeta)
{
  U32 nroles;
  RoleEmbedding **arr = mop_class_get_direct_roles(srcmeta, &nroles);
  U32 i;
  for(i = 0; i < nroles; i++) {
    mop_class_apply_role(arr[i]);
  }
}

void ObjectPad__check_colliding_param(pTHX_ ClassMeta *classmeta, SV *paramname)
{
  HV *parammap = classmeta->parammap;
  assert(parammap);

  HE *he = hv_fetch_ent(parammap, paramname, 0, 0);
  if(!he)
    return;

  ParamMeta *colliding_parammeta = (ParamMeta *)HeVAL(he);
  ClassMeta *origclassmeta = colliding_parammeta->class;

  if(origclassmeta != classmeta)
    croak("Already have a named constructor parameter called '%" SVf "' inherited from %" SVf,
        SVfARG(paramname), SVfARG(origclassmeta->name));
  else
    croak("Already have a named constructor parameter called '%" SVf "'", SVfARG(paramname));
}

static OP *pp_alias_params(pTHX)
{
  dSP;
  PADOFFSET padix = PADIX_PARAMS;

  SV *params = POPs;

  if(SvTYPE(params) != SVt_PVHV)
    RETURN;

  SAVESPTR(PAD_SVl(padix));
  PAD_SVl(padix) = SvREFCNT_inc(params);
  save_freesv(params);

  RETURN;
}

static void S_generate_initfields_method(pTHX_ ClassMeta *meta)
{
  OP *ops = NULL;
  int i;

  ENTER;

  need_PLparser();

  I32 floor_ix = PL_savestack_ix;
  {
    SAVEI32(PL_subline);
    save_item(PL_subname);

    resume_compcv(&meta->initfields_compcv);
  }

  SAVEFREESV(PL_compcv);

  I32 save_ix = block_start(TRUE);

#ifdef DEBUG_OVERRIDE_PLCURCOP
  SAVESPTR(PL_curcop);
  PL_curcop = meta->tmpcop;
  CopLINE_set(PL_curcop, __LINE__);
#endif

  ops = op_append_list(OP_LINESEQ, ops,
    newSTATEOP(0, NULL, NULL));

  /* A more optimised implementation of this method would be able to generate
   * a @self lexical and OP_REFASSIGN it, but that would only work on newer
   * perls. For now we'll take the small performance hit of RV2AV every time
   */

  enum ReprType repr = meta->repr;

  ops = op_append_list(OP_LINESEQ, ops,
    newMETHSTARTOP(0 |
      (meta->type == METATYPE_ROLE ? OPf_SPECIAL : 0) |
      (repr << 8))
  );

  ops = op_append_list(OP_LINESEQ, ops,
    newUNOP_CUSTOM(&pp_alias_params, 0,
      newOP(OP_SHIFT, OPf_SPECIAL)));

  /* TODO: Icky horrible implementation; if our fieldoffset > 0 then
   * we must be a subclass
   */
  if(meta->start_fieldix) {
    struct ClassMeta *supermeta = meta->cls.supermeta;

    assert(supermeta->sealed);
    assert(supermeta->initfields);

    DEBUG_SET_CURCOP_LINE(__LINE__);

    ops = op_append_list(OP_LINESEQ, ops,
      newSTATEOP(0, NULL, NULL));

    /* Build an OP_ENTERSUB for supermeta's initfields */
    OP *op = NULL;
    op = op_append_list(OP_LIST, op,
      newPADxVOP(OP_PADSV, 0, PADIX_SELF));
    op = op_append_list(OP_LIST, op,
      newPADxVOP(OP_PADHV, OPf_REF, PADIX_PARAMS));
    op = op_append_list(OP_LIST, op,
      newSVOP(OP_CONST, 0, (SV *)supermeta->initfields));

    ops = op_append_list(OP_LINESEQ, ops,
      op_convert_list(OP_ENTERSUB, OPf_WANT_VOID|OPf_STACKED, op));
  }

  if(meta->initfields_lines) {
    ops = op_append_list(OP_LINESEQ, ops,
      meta->initfields_lines);
  }

  if(meta->type == METATYPE_CLASS) {
    U32 nroles;
    RoleEmbedding **embeddings = mop_class_get_direct_roles(meta, &nroles);

    for(i = 0; i < nroles; i++) {
      RoleEmbedding *embedding = embeddings[i];
      ClassMeta *rolemeta = embedding->rolemeta;

      if(!rolemeta->sealed)
        mop_class_seal(rolemeta);

      assert(rolemeta->sealed);
      assert(rolemeta->initfields);

      DEBUG_SET_CURCOP_LINE(__LINE__);

      ops = op_append_list(OP_LINESEQ, ops,
        newSTATEOP(0, NULL, NULL));

      OP *op = NULL;
      op = op_append_list(OP_LIST, op,
        newPADxVOP(OP_PADSV, 0, PADIX_SELF));
      op = op_append_list(OP_LIST, op,
        newPADxVOP(OP_PADHV, OPf_REF, PADIX_PARAMS));
      op = op_append_list(OP_LIST, op,
        newSVOP(OP_CONST, 0, (SV *)embed_cv(rolemeta->initfields, embedding)));

      ops = op_append_list(OP_LINESEQ, ops,
        op_convert_list(OP_ENTERSUB, OPf_WANT_VOID|OPf_STACKED, op));
    }
  }

  SvREFCNT_inc(PL_compcv);
  ops = block_end(save_ix, ops);

  /* newATTRSUB will capture PL_curstash */
  SAVESPTR(PL_curstash);
  PL_curstash = meta->stash;

  meta->initfields = newATTRSUB(floor_ix, NULL, NULL, NULL, ops);

  assert(meta->initfields);
  assert(CvOUTSIDE(meta->initfields));

  LEAVE;
}

void ObjectPad_mop_class_seal(pTHX_ ClassMeta *meta)
{
  if(meta->sealed) /* idempotent */
    return;

  MOP_CLASS_RUN_HOOKS_NOARGS(meta, pre_seal);

  if(meta->type == METATYPE_CLASS &&
      meta->cls.supermeta && !meta->cls.supermeta->sealed) {
    /* Must defer sealing until superclass is sealed first
     * (RT133190)
     */
    ClassMeta *supermeta = meta->cls.supermeta;
    if(!supermeta->pending_submeta)
      supermeta->pending_submeta = newAV();
    av_push(supermeta->pending_submeta, (SV *)meta);
    return;
  }

  if(meta->type == METATYPE_CLASS)
    S_apply_roles(aTHX_ meta, meta);

  if(meta->type == METATYPE_CLASS) {
    U32 nmethods = av_count(meta->requiremethods);
    U32 i;
    for(i = 0; i < nmethods; i++) {
      SV *mname = AvARRAY(meta->requiremethods)[i];

      GV *gv = gv_fetchmeth_sv(meta->stash, mname, 0, 0);
      if(gv && GvCV(gv))
        continue;

      croak("Class %" SVf " does not provide a required method named '%" SVf "'",
        SVfARG(meta->name), SVfARG(mname));
    }
  }

  if(meta->strict_params && meta->buildblocks)
    croak("Class %" SVf " cannot be :strict(params) because it has BUILD blocks",
      SVfARG(meta->name));

  {
    U32 i;
    for(i = 0; i < av_count(meta->direct_fields); i++) {
      FieldMeta *fieldmeta = (FieldMeta *)AvARRAY(meta->direct_fields)[i];

      U32 hooki;
      for(hooki = 0; fieldmeta->hooks && hooki < av_count(fieldmeta->hooks); hooki++) {
        struct FieldHook *h = (struct FieldHook *)AvARRAY(fieldmeta->hooks)[hooki];

        if(*h->funcs->post_initfield) {
          if(!meta->fieldhooks_initfield)
            meta->fieldhooks_initfield = newAV();

          struct FieldHook *fasth;
          Newx(fasth, 1, struct FieldHook);

          *fasth = (struct FieldHook){
            .fieldix   = fieldmeta->fieldix,
            .fieldmeta = fieldmeta,
            .funcs     = h->funcs,
            .funcdata  = h->funcdata,
            .hookdata  = h->hookdata,
          };

          av_push(meta->fieldhooks_initfield, (SV *)fasth);
        }

        if(*h->funcs->post_construct) {
          if(!meta->fieldhooks_construct)
            meta->fieldhooks_construct = newAV();

          struct FieldHook *fasth;
          Newx(fasth, 1, struct FieldHook);

          *fasth = (struct FieldHook){
            .fieldix   = fieldmeta->fieldix,
            .fieldmeta = fieldmeta,
            .funcs     = h->funcs,
            .funcdata  = h->funcdata,
            .hookdata  = h->hookdata,
          };

          av_push(meta->fieldhooks_construct, (SV *)fasth);
        }
      }
    }
  }

  S_generate_initfields_method(aTHX_ meta);

  meta->sealed = true;

  MOP_CLASS_RUN_HOOKS_NOARGS(meta, post_seal);

  if(meta->pending_submeta) {
    int i;
    SV **arr = AvARRAY(meta->pending_submeta);
    for(i = 0; i < av_count(meta->pending_submeta); i++) {
      ClassMeta *submeta = (ClassMeta *)arr[i];
      arr[i] = &PL_sv_undef;

      mop_class_seal(submeta);
    }

    SvREFCNT_dec(meta->pending_submeta);
    meta->pending_submeta = NULL;
  }
}

XS_INTERNAL(injected_constructor);
XS_INTERNAL(injected_constructor)
{
  dXSARGS;
  const ClassMeta *meta = XSANY.any_ptr;
  SV *class = ST(0);
  SV *self = NULL;

  assert(meta->type == METATYPE_CLASS);
  if(!meta->sealed)
    croak("Cannot yet invoke '%" SVf "' constructor before the class is complete", SVfARG(class));

#ifdef DEBUG_OVERRIDE_PLCURCOP
  COP *prevcop = PL_curcop;
  PL_curcop = meta->tmpcop;
  CopLINE_set(PL_curcop, __LINE__);
#endif

  /* An AV storing the @_ args to pass to foreign constructor and all the
   * build blocks
   * This does not include $self
   */
  AV *args = newAV();
  SAVEFREESV(args);

  {
    /* @args = $class->BUILDARGS(@_) */
    ENTER;
    SAVETMPS;

#ifdef DEBUG_OVERRIDE_PLCURCOP
    SAVEVPTR(PL_curcop);
    PL_curcop = prevcop;
#endif

    /* Splice in an extra copy of `class` so we get one there for the foreign
     * constructor */
    EXTEND(SP, 1);

    SV **argstart = SP - items + 2;
    PUSHMARK(argstart - 1);

    SV **svp;
    for(svp = SP; svp >= argstart; svp--)
      *(svp+1) = *svp;
    *argstart = class;
    SP++;
    PUTBACK;

    I32 nargs = call_method("BUILDARGS", G_ARRAY);

    SPAGAIN;

    for(svp = SP - nargs + 1; svp <= SP; svp++)
      av_push(args, SvREFCNT_inc(*svp));

    FREETMPS;
    LEAVE;
  }

  bool need_makefields = true;

  if(!meta->cls.foreign_new) {
    HV *stash = gv_stashsv(class, 0);
    if(!stash)
      croak("Unable to find stash for class %" SVf, class);

    switch(meta->repr) {
      case REPR_NATIVE:
      case REPR_AUTOSELECT:
        DEBUG_SET_CURCOP_LINE(__LINE__);
        self = sv_2mortal(newRV_noinc((SV *)newAV()));
        sv_bless(self, stash);
        break;

      case REPR_HASH:
        DEBUG_SET_CURCOP_LINE(__LINE__);
        self = sv_2mortal(newRV_noinc((SV *)newHV()));
        sv_bless(self, stash);
        break;

      case REPR_MAGIC:
        croak("ARGH cannot use :repr(magic) without a foreign superconstructor");
        break;
    }
  }
  else {
    DEBUG_SET_CURCOP_LINE(__LINE__);

    {
      ENTER;
      SAVETMPS;

      PUSHMARK(SP);
      EXTEND(SP, 1 + AvFILL(args));

      SV **argstart = SP - AvFILL(args) - 1;
      SV **argtop = SP;
      SV **svp;

      mPUSHs(newSVsv(class));

      /* Push a copy of the args in case the (foreign) constructor mutates
       * them. We still need them for BUILDALL */
      for(svp = argstart + 1; svp <= argtop; svp++)
        PUSHs(*svp);
      PUTBACK;

      assert(meta->cls.foreign_new);
      call_sv((SV *)meta->cls.foreign_new, G_SCALAR);
      SPAGAIN;

      self = SvREFCNT_inc(POPs);

      PUTBACK;
      FREETMPS;
      LEAVE;
    }

    if(!SvROK(self) || !SvOBJECT(SvRV(self))) {
#ifdef DEBUG_OVERRIDE_PLCURCOP
      PL_curcop = prevcop;
#endif
      croak("Expected %" SVf "->SUPER::new to return a blessed reference", class);
    }
    SV *rv = SvRV(self);

    /* It's possible a foreign superclass constructor invoked a `method` and
     * thus initfields has already been called. Check here and set
     * need_makefields false if so.
     */

    switch(meta->repr) {
      case REPR_NATIVE:
        croak("ARGH shouldn't ever have REPR_NATIVE with foreign_new");

      case REPR_HASH:
      case_REPR_HASH:
        if(SvTYPE(rv) != SVt_PVHV) {
#ifdef DEBUG_OVERRIDE_PLCURCOP
          PL_curcop = prevcop;
#endif
          croak("Expected %" SVf "->SUPER::new to return a blessed HASH reference", class);
        }

        need_makefields = !hv_exists(MUTABLE_HV(rv), "Object::Pad/slots", 17);
        break;

      case REPR_MAGIC:
      case_REPR_MAGIC:
        /* Anything goes */

        need_makefields = !mg_findext(rv, PERL_MAGIC_ext, &vtbl_backingav);
        break;

      case REPR_AUTOSELECT:
        if(SvTYPE(rv) == SVt_PVHV)
          goto case_REPR_HASH;
        goto case_REPR_MAGIC;
    }

    sv_2mortal(self);
  }

  AV *backingav;

  if(need_makefields) {
    backingav = (AV *)get_obj_backingav(self, meta->repr, TRUE);
    make_instance_fields(meta, backingav, 0);
  }
  else {
    backingav = (AV *)get_obj_backingav(self, meta->repr, FALSE);
  }

  SV **fieldsvs = AvARRAY(backingav);

  if(meta->fieldhooks_initfield || meta->fieldhooks_construct) {
    /* We need to set up a fake pad so these hooks can still get PADIX_SELF / PADIX_SLOTS */

    /* This MVP is just sufficient enough to let PAD_SVl(PADIX_SELF) work */
    SAVEVPTR(PL_curpad);
    Newx(PL_curpad, 3, SV *);
    SAVEFREEPV(PL_curpad);

    PAD_SVl(PADIX_SELF)  = self;
    PAD_SVl(PADIX_SLOTS) = (SV *)backingav;
  }

  if(meta->fieldhooks_initfield) {
    DEBUG_SET_CURCOP_LINE(__LINE__);

    AV *fieldhooks = meta->fieldhooks_initfield;

    U32 i;
    for(i = 0; i < av_count(fieldhooks); i++) {
      struct FieldHook *h = (struct FieldHook *)AvARRAY(fieldhooks)[i];
      FIELDOFFSET fieldix = h->fieldix;

      (*h->funcs->post_initfield)(aTHX_ h->fieldmeta, h->hookdata, h->funcdata, fieldsvs[fieldix]);
    }
  }

  HV *paramhv = NULL;
  if(meta->parammap || meta->has_adjust || meta->strict_params) {
    paramhv = newHV();
    SAVEFREESV((SV *)paramhv);

    if(av_count(args) % 2)
      warn("Odd-length list passed to %" SVf " constructor", class);

    /* TODO: I'm sure there's an newHV_from_AV() around somewhere */
    SV **argsv = AvARRAY(args);

    IV idx;
    for(idx = 0; idx < av_count(args); idx += 2) {
      SV *name  = argsv[idx];
      SV *value = idx < av_count(args)-1 ? argsv[idx+1] : &PL_sv_undef;

      hv_store_ent(paramhv, name, SvREFCNT_inc(value), 0);
    }
  }

  {
    /* Run initfields */
    ENTER;
#ifdef DEBUG_OVERRIDE_PLCURCOP
    SAVEVPTR(PL_curcop);
    PL_curcop = prevcop;
#endif

    EXTEND(SP, 2);
    PUSHMARK(SP);
    PUSHs(self);
    if(paramhv)
      PUSHs((SV *)paramhv);
    else
      PUSHs(&PL_sv_undef);
    PUTBACK;

    assert(meta->initfields);
    call_sv((SV *)meta->initfields, G_VOID);

    LEAVE;
  }

  if(meta->buildblocks) {
    DEBUG_SET_CURCOP_LINE(__LINE__);

    AV *buildblocks = meta->buildblocks;
    SV **argsvs = AvARRAY(args);
    int i;
    for(i = 0; i < av_count(buildblocks); i++) {
      CV *buildblock = (CV *)AvARRAY(buildblocks)[i];

      ENTER;
      SAVETMPS;
      SPAGAIN;

      EXTEND(SP, 1 + AvFILL(args));

      PUSHMARK(SP);

      PUSHs(self);

      int argi;
      for(argi = 0; argi <= AvFILL(args); argi++)
        PUSHs(argsvs[argi]);
      PUTBACK;

      assert(buildblock);
      call_sv((SV *)buildblock, G_VOID);

      FREETMPS;
      LEAVE;
    }
  }

  if(meta->adjustblocks) {
    DEBUG_SET_CURCOP_LINE(__LINE__);

    AV *adjustblocks = meta->adjustblocks;
    U32 i;
    for(i = 0; i < av_count(adjustblocks); i++) {
      AdjustBlock *block = (AdjustBlock *)AvARRAY(adjustblocks)[i];

      ENTER;
      SAVETMPS;
      SPAGAIN;

      EXTEND(SP, 1 + !!paramhv);

      PUSHMARK(SP);
      PUSHs(self);
      if(paramhv)
        mPUSHs(newRV_inc((SV *)paramhv));
      PUTBACK;

      assert(block->cv);
      call_sv((SV *)block->cv, G_VOID);

      FREETMPS;
      LEAVE;
    }
  }

  if(meta->strict_params && hv_iterinit(paramhv) > 0) {
    HE *he = hv_iternext(paramhv);

    /* Concat all the param names, in no particular order
     * TODO: consider sorting them but that's quite expensive and tricky in XS */

    SV *params = newSVpvn("", 0);
    SAVEFREESV(params);
    sv_catpvf(params, "'%" SVf "'", SVfARG(HeSVKEY_force(he)));

    while((he = hv_iternext(paramhv)))
      sv_catpvf(params, ", '%" SVf "'", SVfARG(HeSVKEY_force(he)));

#ifdef DEBUG_OVERRIDE_PLCURCOP
    PL_curcop = prevcop;
#endif
    croak("Unrecognised parameters for %" SVf " constructor: %" SVf,
      SVfARG(meta->name), SVfARG(params));
  }

  if(meta->fieldhooks_construct) {
    DEBUG_SET_CURCOP_LINE(__LINE__);

    AV *fieldhooks = meta->fieldhooks_construct;

    U32 i;
    for(i = 0; i < av_count(fieldhooks); i++) {
      struct FieldHook *h = (struct FieldHook *)AvARRAY(fieldhooks)[i];
      FIELDOFFSET fieldix = h->fieldix;

      (*h->funcs->post_construct)(aTHX_ h->fieldmeta, h->hookdata, h->funcdata, fieldsvs[fieldix]);
    }
  }

#ifdef DEBUG_OVERRIDE_PLCURCOP
  PL_curcop = prevcop;
#endif
  ST(0) = self;
  XSRETURN(1);
}

XS_INTERNAL(injected_DOES)
{
  dXSARGS;
  const ClassMeta *meta = XSANY.any_ptr;
  SV *self = ST(0);
  SV *wantrole = ST(1);

  PERL_UNUSED_ARG(items);

  CV *cv_does = NULL;

  while(meta != NULL) {
    AV *roles = meta->type == METATYPE_CLASS ? meta->cls.direct_roles : NULL;
    I32 nroles = roles ? av_count(roles) : 0;

    if(!cv_does && meta->cls.foreign_does)
      cv_does = meta->cls.foreign_does;

    if(sv_eq(meta->name, wantrole)) {
      XSRETURN_YES;
    }

    int i;
    for(i = 0; i < nroles; i++) {
      RoleEmbedding *embedding = (RoleEmbedding *)AvARRAY(roles)[i];
      if(sv_eq(embedding->rolemeta->name, wantrole)) {
        XSRETURN_YES;
      }
    }

    meta = meta->type == METATYPE_CLASS ? meta->cls.supermeta : NULL;
  }

  if (cv_does) {
    /* return $self->DOES(@_); */
    dSP;

    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    EXTEND(SP, 2);
    PUSHs(self);
    PUSHs(wantrole);
    PUTBACK;

    int count = call_sv((SV*)cv_does, G_SCALAR);

    SPAGAIN;

    bool ret = false;

    if (count)
      ret = POPi;

    FREETMPS;
    LEAVE;

    if(ret)
      XSRETURN_YES;
  }
  else {
    /* We need to also respond to Object::Pad::UNIVERSAL and UNIVERSAL */
    if(sv_derived_from_sv(self, wantrole, 0))
      XSRETURN_YES;
  }

  XSRETURN_NO;
}

static OP *pp_croak_from_constructor(pTHX)
{
  dSP;

  /* Walk up the caller stack to find the COP of the first caller; i.e. the
   * first one that wasn't in src/class.c
   */
  I32 count = 0;
  const PERL_CONTEXT *cx;
  while((cx = caller_cx(count, NULL))) {
    const char *copfile = CopFILE(cx->blk_oldcop);
    if(!copfile|| strNE(copfile, "src/class.c")) {
      PL_curcop = cx->blk_oldcop;
      break;
    }
    count++;
  }

  croak_sv(POPs);
}

OP *ObjectPad__newop_croak_from_constructor(pTHX_ SV *message)
{
  return newUNOP_CUSTOM(&pp_croak_from_constructor, 0,
    newSVOP(OP_CONST, 0, message));
}

ClassMeta *ObjectPad_mop_create_class(pTHX_ enum MetaType type, SV *name)
{
  assert(type == METATYPE_CLASS || type == METATYPE_ROLE);

  HV *stash = gv_stashsv(name, GV_ADD);

  ClassMeta *meta;
  Newx(meta, 1, ClassMeta);

  *meta = (ClassMeta){
    .type = type,
    .repr = REPR_AUTOSELECT,
    .name = SvREFCNT_inc(name),

    .stash = stash,

    .next_fieldix = -1,

    .direct_fields  = newAV(),
    .direct_methods = newAV(),
    .requiremethods = newAV(),
  };

  switch(type) {
    case METATYPE_CLASS:
      meta->cls.direct_roles   = newAV();
      meta->cls.embedded_roles = newAV();
      break;

    case METATYPE_ROLE:
      meta->role.superroles      = newAV();
      meta->role.applied_classes = newHV();
      break;
  }

  need_PLparser();

  /* Prepare meta->initfields for containing a CV parsing operation */
  {
    if(!PL_compcv) {
      /* We require the initfields CV to have a CvOUTSIDE, or else cv_clone()
       * will segv when we compose role fields. Any class dynamically generated
       * by string eval() will likely not get one, because it won't inherit a
       * PL_compcv here. We'll fake it up
       *   See also  https://rt.cpan.org/Ticket/Display.html?id=137952
       */
      SAVEVPTR(PL_compcv);
      PL_compcv = find_runcv(0);

      assert(PL_compcv);
    }

    I32 floor_ix = start_subparse(FALSE, 0);

    extend_pad_vars(meta);

    /* Skip padix==3 so we're aligned again */
    if(meta->type != METATYPE_ROLE)
      pad_add_name_pvs("", 0, NULL, NULL);

    PADOFFSET padix = pad_add_name_pvs("%params", 0, NULL, NULL);
    if(padix != PADIX_PARAMS)
      croak("ARGH: Expected that padix[%%params] = 4");

    intro_my();

    suspend_compcv(&meta->initfields_compcv);

    LEAVE_SCOPE(floor_ix);
  }

  meta->tmpcop = (COP *)newSTATEOP(0, NULL, NULL);
  CopFILE_set(meta->tmpcop, __FILE__);

  meta->methodscope = NULL;

  meta->initfields_lines = NULL;

  {
    /* Inject the constructor */
    SV *newname = newSVpvf("%" SVf "::new", name);
    SAVEFREESV(newname);

    CV *newcv = newXS_flags(SvPV_nolen(newname), injected_constructor, __FILE__, NULL, SvFLAGS(newname) & SVf_UTF8);
    CvXSUBANY(newcv).any_ptr = meta;
  }

  {
    SV *doesname = newSVpvf("%" SVf "::DOES", name);
    SAVEFREESV(doesname);
    CV *doescv = newXS_flags(SvPV_nolen(doesname), injected_DOES, __FILE__, NULL, SvFLAGS(doesname) & SVf_UTF8);
    CvXSUBANY(doescv).any_ptr = meta;
  }

  {
    GV **gvp = (GV **)hv_fetchs(stash, "META", GV_ADD);
    GV *gv = *gvp;
    gv_init_pvn(gv, stash, "META", 4, 0);
    GvMULTI_on(gv);

    SV *sv;
    sv_setref_uv(sv = GvSVn(gv), "Object::Pad::MOP::Class", PTR2UV(meta));

    newCONSTSUB(meta->stash, "META", sv);
  }

  return meta;
}

void ObjectPad_mop_class_set_superclass(pTHX_ ClassMeta *meta, SV *superclassname)
{
  assert(meta->type == METATYPE_CLASS);

  if(meta->has_superclass)
    croak("Class already has a superclass, cannot add another");

  AV *isa;
  {
    SV *isaname = newSVpvf("%" SVf "::ISA", meta->name);
    SAVEFREESV(isaname);

    isa = get_av(SvPV_nolen(isaname), GV_ADD | (SvFLAGS(isaname) & SVf_UTF8));
  }

  av_push(isa, SvREFCNT_inc(superclassname));

  ClassMeta *supermeta = NULL;

  HV *superstash = gv_stashsv(superclassname, 0);
  GV **metagvp = (GV **)hv_fetchs(superstash, "META", 0);
  if(metagvp)
    supermeta = NUM2PTR(ClassMeta *, SvUV(SvRV(GvSV(*metagvp))));

  if(supermeta) {
    /* A subclass of an Object::Pad class */
    if(supermeta->type != METATYPE_CLASS)
      croak("%" SVf " is not a class", SVfARG(superclassname));

    /* If it isn't yet sealed (e.g. because we're an inner class of it),
     * seal it now
     */
    if(!supermeta->sealed)
      mop_class_seal(supermeta);

    meta->start_fieldix = supermeta->next_fieldix;
    meta->repr = supermeta->repr;
    meta->cls.foreign_new = supermeta->cls.foreign_new;

    if(supermeta->buildblocks) {
      if(!meta->buildblocks)
        meta->buildblocks = newAV();

      av_push_from_av_noinc(meta->buildblocks, supermeta->buildblocks);
    }

    if(supermeta->adjustblocks) {
      if(!meta->adjustblocks)
        meta->adjustblocks = newAV();

      av_push_from_av_noinc(meta->adjustblocks, supermeta->adjustblocks);
    }

    if(supermeta->fieldhooks_initfield) {
      if(!meta->fieldhooks_initfield)
        meta->fieldhooks_initfield = newAV();

      av_push_from_av_noinc(meta->fieldhooks_initfield, supermeta->fieldhooks_initfield);
    }

    if(supermeta->fieldhooks_construct) {
      if(!meta->fieldhooks_construct)
        meta->fieldhooks_construct = newAV();

      av_push_from_av_noinc(meta->fieldhooks_construct, supermeta->fieldhooks_construct);
    }

    if(supermeta->parammap) {
      HV *old = supermeta->parammap;
      HV *new = meta->parammap = newHV();

      hv_iterinit(old);

      HE *iter;
      while((iter = hv_iternext(old))) {
        STRLEN klen = HeKLEN(iter);
        /* Don't SvREFCNT_inc() the values because they aren't really SV *s */
        /* Subclasses *DIRECTLY SHARE* their param metas because the
         * information in them is directly compatible
         */
        if(klen < 0)
          hv_store_ent(new, HeSVKEY(iter), HeVAL(iter), HeHASH(iter));
        else
          hv_store(new, HeKEY(iter), klen, HeVAL(iter), HeHASH(iter));
      }
    }

    if(supermeta->has_adjust)
      meta->has_adjust = true;

    U32 nroles;
    RoleEmbedding **embeddings = mop_class_get_all_roles(supermeta, &nroles);
    if(nroles) {
      U32 i;
      for(i = 0; i < nroles; i++) {
        RoleEmbedding *embedding = embeddings[i];
        ClassMeta *rolemeta = embedding->rolemeta;

        av_push(meta->cls.embedded_roles, (SV *)embedding);
        hv_store_ent(rolemeta->role.applied_classes, meta->name, (SV *)embedding, 0);
      }
    }
  }
  else {
    /* A subclass of a foreign class */
    meta->cls.foreign_new = fetch_superclass_method_pv(meta->stash, "new", 3, -1);
    if(!meta->cls.foreign_new)
      croak("Unable to find SUPER::new for %" SVf, superclassname);

    meta->cls.foreign_does = fetch_superclass_method_pv(meta->stash, "DOES", 4, -1);

    av_push(isa, newSVpvs("Object::Pad::UNIVERSAL"));
  }

  meta->has_superclass = true;
  meta->cls.supermeta = supermeta;
}

void ObjectPad_mop_class_begin(pTHX_ ClassMeta *meta)
{
  SV *isaname = newSVpvf("%" SVf "::ISA", meta->name);
  SAVEFREESV(isaname);

  AV *isa = get_av(SvPV_nolen(isaname), GV_ADD | (SvFLAGS(isaname) & SVf_UTF8));
  if(!av_count(isa))
    av_push(isa, newSVpvs("Object::Pad::UNIVERSAL"));

  if(meta->type == METATYPE_CLASS &&
      meta->repr == REPR_AUTOSELECT && !meta->cls.foreign_new)
    meta->repr = REPR_NATIVE;

  meta->next_fieldix = meta->start_fieldix;
}

/*******************
 * Attribute hooks *
 *******************/

#ifndef isSPACE_utf8_safe
   /* this isn't really safe but it's the best we can do */
#  define isSPACE_utf8_safe(p, e)  (PERL_UNUSED_ARG(e), isSPACE_utf8(p))
#endif

#define split_package_ver(value, pkgname, pkgversion)  S_split_package_ver(aTHX_ value, pkgname, pkgversion)
static const char *S_split_package_ver(pTHX_ SV *value, SV *pkgname, SV *pkgversion)
{
  const char *start = SvPVX(value), *p = start, *end = start + SvCUR(value);

  while(*p && !isSPACE_utf8_safe(p, end))
    p += UTF8SKIP(p);

  sv_setpvn(pkgname, start, p - start);
  if(SvUTF8(value))
    SvUTF8_on(pkgname);

  while(*p && isSPACE_utf8_safe(p, end))
    p += UTF8SKIP(p);

  if(*p) {
    /* scan_version() gets upset about trailing content. We need to extract
     * exactly what it wants
     */
    start = p;
    if(*p == 'v')
      p++;
    while(*p && strchr("0123456789._", *p))
      p++;
    SV *tmpsv = newSVpvn(start, p - start);
    SAVEFREESV(tmpsv);

    scan_version(SvPVX(tmpsv), pkgversion, FALSE);
  }

  while(*p && isSPACE_utf8_safe(p, end))
    p += UTF8SKIP(p);

  return p;
}

/* :isa */

static bool classhook_isa_apply(pTHX_ ClassMeta *classmeta, SV *value, SV **hookdata_ptr, void *_funcdata)
{
  SV *superclassname = newSV(0), *superclassver = newSV(0);
  SAVEFREESV(superclassname);
  SAVEFREESV(superclassver);

  const char *end = split_package_ver(value, superclassname, superclassver);

  if(*end)
    croak("Unexpected characters while parsing :isa() attribute: %s", end);

  if(classmeta->type != METATYPE_CLASS)
    croak("Only a class may extend another");

  HV *superstash = gv_stashsv(superclassname, 0);
  if(!superstash || !hv_fetchs(superstash, "new", 0)) {
    /* Try to `require` the module then attempt a second time */
    /* load_module() will modify the name argument and take ownership of it */
    load_module(PERL_LOADMOD_NOIMPORT, newSVsv(superclassname), NULL, NULL);
    superstash = gv_stashsv(superclassname, 0);
  }

  if(!superstash)
    croak("Superclass %" SVf " does not exist", superclassname);

  if(superclassver && SvOK(superclassver))
    ensure_module_version(superclassname, superclassver);

  mop_class_set_superclass(classmeta, superclassname);

  return FALSE;
}

static const struct ClassHookFuncs classhooks_isa = {
  .ver   = OBJECTPAD_ABIVERSION,
  .flags = OBJECTPAD_FLAG_ATTR_MUST_VALUE,
  .apply = &classhook_isa_apply,
};

/* :does */

static bool classhook_does_apply(pTHX_ ClassMeta *classmeta, SV *value, SV **hookdata_ptr, void *_funcdata)
{
  SV *rolename = newSV(0), *rolever = newSV(0);
  SAVEFREESV(rolename);
  SAVEFREESV(rolever);

  const char *end = split_package_ver(value, rolename, rolever);

  if(*end)
    croak("Unexpected characters while parsing :does() attribute: %s", end);

  mop_class_load_and_add_role(classmeta, rolename, rolever);

  return FALSE;
}

static const struct ClassHookFuncs classhooks_does = {
  .ver   = OBJECTPAD_ABIVERSION,
  .flags = OBJECTPAD_FLAG_ATTR_MUST_VALUE,
  .apply = &classhook_does_apply,
};

/* :repr */

static bool classhook_repr_apply(pTHX_ ClassMeta *classmeta, SV *value, SV **hookdata_ptr, void *_funcdata)
{
  char *val = SvPV_nolen(value); /* all comparisons are ASCII */

  if(strEQ(val, "native")) {
    if(classmeta->type == METATYPE_CLASS && classmeta->cls.foreign_new)
      croak("Cannot switch a subclass of a foreign superclass type to :repr(native)");
    classmeta->repr = REPR_NATIVE;
  }
  else if(strEQ(val, "HASH"))
    classmeta->repr = REPR_HASH;
  else if(strEQ(val, "magic")) {
    if(classmeta->type != METATYPE_CLASS || !classmeta->cls.foreign_new)
      croak("Cannot switch to :repr(magic) without a foreign superclass");
    classmeta->repr = REPR_MAGIC;
  }
  else if(strEQ(val, "default") || strEQ(val, "autoselect"))
    classmeta->repr = REPR_AUTOSELECT;
  else
    croak("Unrecognised class representation type %" SVf, SVfARG(value));

  return FALSE;
}

static const struct ClassHookFuncs classhooks_repr = {
  .ver   = OBJECTPAD_ABIVERSION,
  .flags = OBJECTPAD_FLAG_ATTR_MUST_VALUE,
  .apply = &classhook_repr_apply,
};

/* :compat */

static bool classhook_compat_apply(pTHX_ ClassMeta *classmeta, SV *value, SV **hookdata_ptr, void *_funcdata)
{
  if(strEQ(SvPV_nolen(value), "invokable")) {
    if(classmeta->type != METATYPE_ROLE)
      croak(":compat(invokable) only applies to a role");

    classmeta->role_is_invokable = true;
  }
  else
    croak("Unrecognised class compatibility argument %" SVf, SVfARG(value));

  return FALSE;
}

static const struct ClassHookFuncs classhooks_compat = {
  .ver   = OBJECTPAD_ABIVERSION,
  .flags = OBJECTPAD_FLAG_ATTR_MUST_VALUE,
  .apply = &classhook_compat_apply,
};

/* :strict */

static bool classhook_strict_apply(pTHX_ ClassMeta *classmeta, SV *value, SV **hookdata_ptr, void *_funcdata)
{
  if(strEQ(SvPV_nolen(value), "params"))
    classmeta->strict_params = TRUE;
  else
    croak("Unrecognised class strictness type %" SVf, SVfARG(value));

  return FALSE;
}

static const struct ClassHookFuncs classhooks_strict = {
  .ver   = OBJECTPAD_ABIVERSION,
  .flags = OBJECTPAD_FLAG_ATTR_MUST_VALUE,
  .apply = &classhook_strict_apply,
};

void ObjectPad__boot_classes(pTHX)
{
  register_class_attribute("isa",    &classhooks_isa,    NULL);
  register_class_attribute("does",   &classhooks_does,   NULL);
  register_class_attribute("repr",   &classhooks_repr,   NULL);
  register_class_attribute("compat", &classhooks_compat, NULL);
  register_class_attribute("strict", &classhooks_strict, NULL);

#ifdef HAVE_DMD_HELPER
  DMD_ADD_ROOT((SV *)&vtbl_backingav, "the Object::Pad backing AV VTBL");
#endif
}
