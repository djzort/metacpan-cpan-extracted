/*---------------------------------------------------------------------
 $Header: /Perl/OlleDB/internaldata.h 12    22-05-27 19:04 Sommar $

  This headerfile defines the internaldata struct and structs it uses.
  The internaldata is private to the C++/XS code and not exposed to Perl.

  There are also routines to set it up and tear it down.

  Copyright (c) 2004-2022   Erland Sommarskog

  $History: internaldata.h $
 * 
 * *****************  Version 12  *****************
 * User: Sommar       Date: 22-05-27   Time: 19:04
 * Updated in $/Perl/OlleDB
 * Added propset as a parameter to dump_properties to avoid surprises when
 * properties in different set have the same value.
 * 
 * *****************  Version 11  *****************
 * User: Sommar       Date: 22-05-08   Time: 23:11
 * Updated in $/Perl/OlleDB
 * Changed interface of dump_properties.
 * 
 * *****************  Version 10  *****************
 * User: Sommar       Date: 19-07-19   Time: 22:00
 * Updated in $/Perl/OlleDB
 * Removed the olddbtranslate option from internaldata, and entirely
 * deprecated setting the AutoTranslate option to make sure that it always
 * is false. When clearing options when ProviderString is set, we don't
 * clear AutoTranslate.
 * 
 * *****************  Version 9  *****************
 * User: Sommar       Date: 19-07-08   Time: 22:31
 * Updated in $/Perl/OlleDB
 * New elements in internaldata for SQL version,  currentDB and more for
 * UTF-8 support.
 * 
 * *****************  Version 8  *****************
 * User: Sommar       Date: 16-07-11   Time: 22:24
 * Updated in $/Perl/OlleDB
 * Changed data types of ULONG for no_of_cols and no_of_defaults to avoid
 * compilation warnings.
 * 
 * *****************  Version 7  *****************
 * User: Sommar       Date: 11-08-07   Time: 23:27
 * Updated in $/Perl/OlleDB
 * Suppress warnings about data truncation on x64.
 * 
 * *****************  Version 6  *****************
 * User: Sommar       Date: 09-04-25   Time: 22:29
 * Updated in $/Perl/OlleDB
 * setupinternaldata was incorrectly defined to return int, which botched
 * the pointer once address was > 7FFFFFFF.
 *
 * *****************  Version 5  *****************
 * User: Sommar       Date: 08-03-23   Time: 23:29
 * Updated in $/Perl/OlleDB
 * New field for table parameters: bindix, as we don't bind columns that
 * vae default.
 *
 * *****************  Version 4  *****************
 * User: Sommar       Date: 08-01-06   Time: 18:56
 * Updated in $/Perl/OlleDB
 * All the switch(datatype) for parameters and column in TVPs are now in
 * common code, and not duplicated in senddata and tableparam.
 *
 * *****************  Version 3  *****************
 * User: Sommar       Date: 08-01-05   Time: 20:43
 * Updated in $/Perl/OlleDB
 * Added more fields to the tableparam struct: buffers for saving
 * pointers, and support for defining columns to be sent as default.
 *
 * *****************  Version 2  *****************
 * User: Sommar       Date: 08-01-05   Time: 0:25
 * Updated in $/Perl/OlleDB
 * Added structures to handle table-valued parameters.
 *
 * *****************  Version 1  *****************
 * User: Sommar       Date: 07-12-24   Time: 21:39
 * Created in $/Perl/OlleDB
  ---------------------------------------------------------------------*/


// This struct defines values we store about a table paraemetr.
typedef struct tableparam {
   BSTR             tabletypename;
   ULONG            no_of_cols;
   int              cols_undefined; // How many more columns left to define?
   HV             * colnamemap;     // Keys column names, returns index.
   DBCOLUMNDESC   * columns;        // Fed to CreateTable.
   ITableDefinitionWithConstraints
                  * tabledef_ptr;
   BOOL           * usedefault;     // For which columns are to use defaults.
   ULONG            no_of_usedefault;
   DBBINDING      * colbindings;    // Used to bind data buffer.
   DBBINDSTATUS   * colbindstatus;
   UINT           * bindix;         // The indexes for columns in colbindings.
   IRowsetChange  * rowset_ptr;
   HACCESSOR        rowaccessor;
   IAccessor      * accessor_ptr;
   size_t           size_row_buffer;
   DBPROP           defcolprop;      // Used if there are any usedefault.

   // These buffers are used inserttableparam only, but we allocate once
   // instead of allo/deallocate for every row inserted.
   BYTE           * row_buffer;
   void          ** save_ptrs;      // Pointers to dispose
   BSTR           * save_bstrs;     // BSTRs to free.
} tableparam;


// This struct is mainly a big union that holds the value of a parameter to a
// stored procedure or a column in a TVP.
typedef struct valueunion {
   union {
      BOOL              bit;
      BYTE              tinyint;
      SHORT             smallint;
      LONG32            intval;
      LONG64            bigint;
      FLOAT             real;
      DOUBLE            floatval;
      CY                money;
      void            * byrefptr;
      GUID              guid;
      DB_NUMERIC        decimal;
      DBDATE            date;
      DBTIME2           time;
      DBTIMESTAMP       datetime;
      DBTIMESTAMPOFFSET dtoffset;
      SSVARIANT         sql_variant;
      tableparam      * table;
   };
} valueunion;

// This struct describes a parameter to a stored procedure. The caller
// enters one parameter at a time, and we save the parameter in a linked
// list, which we keep until batch is completed.
typedef struct paramdata {
   DBTYPE            datatype;
   BOOL              isinput;
   BOOL              isoutput;
   BOOL              isnull;
   valueunion        value;
   DBLENGTH          value_len;
   void            * buffer_ptr;   // Copy of varchar/binary pointer, for simple cleanup.
   BSTR              bstr;         // Ditto widechar data, which goes into a different pool.
   DBBINDING         binding;
   DBPARAMBINDINFO   param_info;
   DBOBJECT        * bindobject;
   int               param_props_cnt;
   DBPROP          * param_props;
   paramdata       * next;
} paramdata;

// The main struct, internaldata.
typedef struct {
    // Data source, if non-NULL we are connected.
    IDBInitialize          * init_ptr;
    IDBCreateSession       * datasrc_ptr;

    // Various properties about the connection.
    BOOL                     isautoconnected;  // If connection was through connect() or not.
    BOOL                     isnestedquery;    // If current query was from inside the module.
    SV                     * SQL_version;      // The handle attribute SQL_version.
    int                      majorsqlversion;   
    SV                     * CurrentDB;
    provider_enum            provider;         // SQLOLEDB or SQLNCLI

    // Property sets and properties with initialization properties.
    DBPROPSET                init_propsets[NO_OF_INIT_PROPSETS];
    DBPROP                   init_properties[MAX_INIT_PROPERTIES];

    // A command text, possibly with parameters that are being assembled
    // with initbatch and enterparameter.
    BSTR                     pending_cmd;  // (Parameterised) cmd for which caller is supplying parmeters.
    paramdata              * paramfirst;   // Head of linked list for parameters.
    paramdata              * paramlast;    // Tail of parameter list.
    DBORDINAL                no_of_params; // Length of parameter list.
    DBORDINAL                no_of_out_params;  // And how many that are outparams.
    BOOL                     params_available;  // Not set until all result sets are exhausted.

    // SQLOLEDB parameters that are created by executebatch.
    IDBCreateCommand       * session_ptr;
    ICommandText           * cmdtext_ptr;
    ICommandWithParameters * paramcmd_ptr;
    ISSCommandWithParameters * ss_paramcmd_ptr;
    IAccessor              * paramaccess_ptr;

    // Data with and about parameters.
    BOOL                     all_params_OK;
    DBPARAMBINDINFO        * param_info;     // Information about parameters.
    DBBINDING              * param_bindings; // How parameters are bound in param_buffer.
    BYTE                   * param_buffer;   // Buffer for parameter values.
    size_t                   size_param_buffer;  // Size of that buffer.
    HACCESSOR                param_accessor;
    DBBINDSTATUS           * param_bind_status;
    HV                     * tableparams;    // Key: parameter name, data ptr to table-parameter data.

    // Pointers for result sets.
    IMultipleResults       * results_ptr;
    BOOL                     have_resultset; // Whether we have an active result set.
    IRowset                * rowset_ptr;
    IAccessor              * rowaccess_ptr;
    HACCESSOR                row_accessor;

    // We get a number of rows at a time into a buffer (because Gert
    // suggested to, but it does not seem to make a difference.)
    HROW                   * rowbuffer;      // Buffered rows from SQLOLEDB.
    DBCOUNTITEM              rows_in_buffer; // Size of rowbuffer.
    DBCOUNTITEM              current_rowno;  // Current row in rowbuffer.

    // Data with and about the columns.
    ULONG                    no_of_cols;     // No of columns in current result set.
    DBCOLUMNINFO           * column_info;
    WCHAR                  * colname_buffer; // Memory area for names in *colunm_info.
    DBBINDING              * col_bindings;
    DBBINDSTATUS           * col_bind_status;
    BYTE                   * data_buffer;    // Data buffer for a single row.
    size_t                   size_data_buffer;  // Size of that data buffer.
    SV                    ** column_keys;    // We convert column names for hash keys once and save them.
} internaldata;


extern void dump_properties(DBPROP *dbprops, init_propsets propset, int cProps);

extern void * setupinternaldata();

extern internaldata * get_internaldata(SV *olle_ptr);

extern void dump_internaldata(internaldata * mydata);

extern void free_resultset_data(internaldata *mydata);

extern void free_pending_cmd(internaldata *mydata);

extern void free_batch_data(internaldata *mydata);

extern void free_connection_data(internaldata *mydata);

// Free strings for SQL version and current DB. Called on destroy or
// when the server changes.
extern void free_sqlver_currentdb(internaldata * mydata);