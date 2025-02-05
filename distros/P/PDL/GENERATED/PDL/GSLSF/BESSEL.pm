#
# GENERATED WITH PDL::PP! Don't modify!
#
package PDL::GSLSF::BESSEL;

our @EXPORT_OK = qw(gsl_sf_bessel_Jn gsl_sf_bessel_Jn_array gsl_sf_bessel_Yn gsl_sf_bessel_Yn_array gsl_sf_bessel_In gsl_sf_bessel_I_array gsl_sf_bessel_In_scaled gsl_sf_bessel_In_scaled_array gsl_sf_bessel_Kn gsl_sf_bessel_K_array gsl_sf_bessel_Kn_scaled gsl_sf_bessel_Kn_scaled_array gsl_sf_bessel_jl gsl_sf_bessel_jl_array gsl_sf_bessel_yl gsl_sf_bessel_yl_array gsl_sf_bessel_il_scaled gsl_sf_bessel_il_scaled_array gsl_sf_bessel_kl_scaled gsl_sf_bessel_kl_scaled_array gsl_sf_bessel_Jnu gsl_sf_bessel_Ynu gsl_sf_bessel_Inu_scaled gsl_sf_bessel_Inu gsl_sf_bessel_Knu_scaled gsl_sf_bessel_Knu gsl_sf_bessel_lnKnu );
our %EXPORT_TAGS = (Func=>\@EXPORT_OK);

use PDL::Core;
use PDL::Exporter;
use DynaLoader;


   
   our @ISA = ( 'PDL::Exporter','DynaLoader' );
   push @PDL::Core::PP, __PACKAGE__;
   bootstrap PDL::GSLSF::BESSEL ;






#line 4 "gsl_sf_bessel.pd"

use strict;
use warnings;

=head1 NAME

PDL::GSLSF::BESSEL - PDL interface to GSL Special Functions

=head1 DESCRIPTION

This is an interface to the Special Function package present in the GNU Scientific Library. 

=cut
#line 39 "BESSEL.pm"






=head1 FUNCTIONS

=cut




#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Jn

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Regular Bessel Function J_n(x).

=for bad

gsl_sf_bessel_Jn does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 74 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Jn = \&PDL::gsl_sf_bessel_Jn;
#line 81 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Jn_array

=for sig

  Signature: (double x(); double [o]y(num); int s; int n=>num)

=for ref

Array of Regular Bessel Functions J_{s}(x) to J_{s+n-1}(x).

=for bad

gsl_sf_bessel_Jn_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 106 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Jn_array = \&PDL::gsl_sf_bessel_Jn_array;
#line 113 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Yn

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

IrRegular Bessel Function Y_n(x).

=for bad

gsl_sf_bessel_Yn does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 138 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Yn = \&PDL::gsl_sf_bessel_Yn;
#line 145 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Yn_array

=for sig

  Signature: (double x(); double [o]y(num); int s; int n=>num)

=for ref

Array of Regular Bessel Functions Y_{s}(x) to Y_{s+n-1}(x).

=for bad

gsl_sf_bessel_Yn_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 170 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Yn_array = \&PDL::gsl_sf_bessel_Yn_array;
#line 177 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_In

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Regular Modified Bessel Function I_n(x).

=for bad

gsl_sf_bessel_In does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 202 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_In = \&PDL::gsl_sf_bessel_In;
#line 209 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_I_array

=for sig

  Signature: (double x(); double [o]y(num); int s; int n=>num)

=for ref

Array of Regular Modified Bessel Functions I_{s}(x) to I_{s+n-1}(x).

=for bad

gsl_sf_bessel_I_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 234 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_I_array = \&PDL::gsl_sf_bessel_I_array;
#line 241 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_In_scaled

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Scaled Regular Modified Bessel Function exp(-|x|) I_n(x).

=for bad

gsl_sf_bessel_In_scaled does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 266 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_In_scaled = \&PDL::gsl_sf_bessel_In_scaled;
#line 273 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_In_scaled_array

=for sig

  Signature: (double x(); double [o]y(num); int s; int n=>num)

=for ref

Array of Scaled Regular Modified Bessel Functions exp(-|x|) I_{s}(x) to exp(-|x|) I_{s+n-1}(x).

=for bad

gsl_sf_bessel_In_scaled_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 298 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_In_scaled_array = \&PDL::gsl_sf_bessel_In_scaled_array;
#line 305 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Kn

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

IrRegular Modified Bessel Function K_n(x).

=for bad

gsl_sf_bessel_Kn does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 330 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Kn = \&PDL::gsl_sf_bessel_Kn;
#line 337 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_K_array

=for sig

  Signature: (double x(); double [o]y(num); int s; int n=>num)

=for ref

Array of IrRegular Modified Bessel Functions K_{s}(x) to K_{s+n-1}(x).

=for bad

gsl_sf_bessel_K_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 362 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_K_array = \&PDL::gsl_sf_bessel_K_array;
#line 369 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Kn_scaled

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Scaled IrRegular Modified Bessel Function exp(-|x|) K_n(x).

=for bad

gsl_sf_bessel_Kn_scaled does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 394 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Kn_scaled = \&PDL::gsl_sf_bessel_Kn_scaled;
#line 401 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Kn_scaled_array

=for sig

  Signature: (double x(); double [o]y(num); int s; int n=>num)

=for ref

Array of Scaled IrRegular Modified Bessel Functions exp(-|x|) K_{s}(x) to exp(-|x|) K_{s+n-1}(x).

=for bad

gsl_sf_bessel_Kn_scaled_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 426 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Kn_scaled_array = \&PDL::gsl_sf_bessel_Kn_scaled_array;
#line 433 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_jl

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Regular Sphericl Bessel Function J_n(x).

=for bad

gsl_sf_bessel_jl does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 458 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_jl = \&PDL::gsl_sf_bessel_jl;
#line 465 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_jl_array

=for sig

  Signature: (double x(); double [o]y(num); int n=>num)

=for ref

Array of Spherical Regular Bessel Functions J_{0}(x) to J_{n-1}(x).

=for bad

gsl_sf_bessel_jl_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 490 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_jl_array = \&PDL::gsl_sf_bessel_jl_array;
#line 497 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_yl

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

IrRegular Spherical Bessel Function y_n(x).

=for bad

gsl_sf_bessel_yl does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 522 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_yl = \&PDL::gsl_sf_bessel_yl;
#line 529 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_yl_array

=for sig

  Signature: (double x(); double [o]y(num); int n=>num)

=for ref

Array of Regular Spherical Bessel Functions y_{0}(x) to y_{n-1}(x).

=for bad

gsl_sf_bessel_yl_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 554 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_yl_array = \&PDL::gsl_sf_bessel_yl_array;
#line 561 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_il_scaled

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Scaled Regular Modified Spherical Bessel Function exp(-|x|) i_n(x).

=for bad

gsl_sf_bessel_il_scaled does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 586 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_il_scaled = \&PDL::gsl_sf_bessel_il_scaled;
#line 593 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_il_scaled_array

=for sig

  Signature: (double x(); double [o]y(num); int n=>num)

=for ref

Array of Scaled Regular Modified Spherical Bessel Functions exp(-|x|) i_{0}(x) to exp(-|x|) i_{n-1}(x).

=for bad

gsl_sf_bessel_il_scaled_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 618 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_il_scaled_array = \&PDL::gsl_sf_bessel_il_scaled_array;
#line 625 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_kl_scaled

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); int n)

=for ref

Scaled IrRegular Modified Spherical Bessel Function exp(-|x|) k_n(x).

=for bad

gsl_sf_bessel_kl_scaled does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 650 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_kl_scaled = \&PDL::gsl_sf_bessel_kl_scaled;
#line 657 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_kl_scaled_array

=for sig

  Signature: (double x(); double [o]y(num); int n=>num)

=for ref

Array of Scaled IrRegular Modified Spherical Bessel Functions exp(-|x|) k_{s}(x) to exp(-|x|) k_{s+n-1}(x).

=for bad

gsl_sf_bessel_kl_scaled_array does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 682 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_kl_scaled_array = \&PDL::gsl_sf_bessel_kl_scaled_array;
#line 689 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Jnu

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

Regular Cylindrical Bessel Function J_nu(x).

=for bad

gsl_sf_bessel_Jnu does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 714 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Jnu = \&PDL::gsl_sf_bessel_Jnu;
#line 721 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Ynu

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

IrRegular Cylindrical Bessel Function J_nu(x).

=for bad

gsl_sf_bessel_Ynu does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 746 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Ynu = \&PDL::gsl_sf_bessel_Ynu;
#line 753 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Inu_scaled

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

Scaled Modified Cylindrical Bessel Function exp(-|x|) I_nu(x).

=for bad

gsl_sf_bessel_Inu_scaled does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 778 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Inu_scaled = \&PDL::gsl_sf_bessel_Inu_scaled;
#line 785 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Inu

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

Modified Cylindrical Bessel Function I_nu(x).

=for bad

gsl_sf_bessel_Inu does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 810 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Inu = \&PDL::gsl_sf_bessel_Inu;
#line 817 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Knu_scaled

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

Scaled Modified Cylindrical Bessel Function exp(-|x|) K_nu(x).

=for bad

gsl_sf_bessel_Knu_scaled does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 842 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Knu_scaled = \&PDL::gsl_sf_bessel_Knu_scaled;
#line 849 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_Knu

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

Modified Cylindrical Bessel Function K_nu(x).

=for bad

gsl_sf_bessel_Knu does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 874 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_Knu = \&PDL::gsl_sf_bessel_Knu;
#line 881 "BESSEL.pm"



#line 949 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"



=head2 gsl_sf_bessel_lnKnu

=for sig

  Signature: (double x(); double [o]y(); double [o]e(); double n)

=for ref

Logarithm of Modified Cylindrical Bessel Function K_nu(x).

=for bad

gsl_sf_bessel_lnKnu does not process bad values.
It will set the bad-value flag of all output ndarrays if the flag is set for any of the input ndarrays.


=cut
#line 906 "BESSEL.pm"



#line 951 "/home/osboxes/pdl-code/blib/lib/PDL/PP.pm"

*gsl_sf_bessel_lnKnu = \&PDL::gsl_sf_bessel_lnKnu;
#line 913 "BESSEL.pm"





#line 349 "gsl_sf_bessel.pd"


=head1 AUTHOR

This file copyright (C) 1999 Christian Pellegrin <chri@infis.univ.trieste.it>
All rights reserved. There
is no warranty. You are allowed to redistribute this software /
documentation under certain conditions. For details, see the file
COPYING in the PDL distribution. If this file is separated from the
PDL distribution, the copyright notice should be included in the file.

The GSL SF modules were written by G. Jungman.

=cut
#line 934 "BESSEL.pm"




# Exit with OK status

1;
