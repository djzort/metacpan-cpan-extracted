# -*- perl -*-
##----------------------------------------------------------------------------
## Database Object Interface - ~/lib/DB/Object/Mysql/Tables.pm
## Version v0.300.1
## Copyright(c) 2019 DEGUEST Pte. Ltd.
## Author: Jacques Deguest <@sitael.tokyo.deguest.jp>
## Created 2017/07/19
## Modified 2020/05/22
## 
##----------------------------------------------------------------------------
## This package's purpose is to separate the object of the tables from the main
## DB::Object package so that when they get DESTROY'ed, it does not interrupt
## the SQL connection
##----------------------------------------------------------------------------
package DB::Object::Mysql::Tables;
BEGIN
{
    use strict;
    use warnings;
    use parent qw( DB::Object::Mysql DB::Object::Tables );
    use vars qw( $VERSION $VERBOSE $DEBUG );
    $VERSION    = 'v0.300.1';
    $VERBOSE    = 0;
    $DEBUG      = 0;
    use Devel::Confess;
    # <https://dev.mysql.com/doc/refman/8.0/en/data-types.html>
};

use strict;
use warnings;

sub init
{
    return( shift->DB::Object::Tables::init( @_ ) );
}

# sub init
# {
#     my $self  = shift( @_ );
#     my $table = '';
#     $table    = shift( @_ ) if( @_ && @_ % 2 );
#     return( $self->error( "You must provide a table name to create a table object." ) ) if( !$table );
#     my %arg   = ( @_ );
#     map{ $self->{ $_ } = $arg{ $_ } } keys( %arg );
#     $self->{ 'table' }        = $table if( $table );
#     $self->{ 'structure' }    ||= {};
#     $self->{ 'fields' }        ||= {};
#     $self->{ 'default' }    ||= {};
#     $self->{ 'null' }        ||= {};
#     $self->{ 'alias' }        = {};
#     $self->{ 'avoid' }        = [];
#     ## Load table default, fields, structure informations
#     my $db = $self->database();
#     $self->structure();
#     return( $self->error( "There is no table by the name of $table" ) ) if( !%$ref );
#     return( $self );
# }

## Inherited from DB::Object::Tables
## sub alter

sub check
{
    my $self = shift( @_ );
    my $table = $self->{table} ||
    return( $self->error( 'No table was provided to check' ) );
    my $opt   = shift( @_ ) if( @_ == 1 );
    my %arg   = ( @_ );
    $opt      = \%arg if( !$opt && %arg );
    my $query = "CHECK TABLE $table";
    $query   .= " TYPE = QUICK" if( $opt->{ 'quick' } );
    my $sth   = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to check table '$table':\n$query\n", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to check table '$table':\n$query\n", $sth->errstr() ) );
    }
    return( $sth );
}

sub create
{
    my $self  = shift( @_ );
    ## $tbl->create( [ 'ROW 1', 'ROW 2'... ], { 'temporary' => 1, 'TYPE' => ISAM }, $obj );
    my $data  = shift( @_ ) || [];
    my $opt   = shift( @_ ) || {};
    my $sth   = shift( @_ );
    my $table = $self->{table};
    ## Set temporary in the object, so we can use it to recreate the table creation info as string:
    ## $table->create( [ ... ], { ... }, $obj )->as_string();
    my $temp  = $self->{temporary} = delete( $opt->{temporary} );
    ## Check possible options
    my $allowed = 
    {
    type            => qr/^(ISAM|MYISAM|HEAP)$/i,
    auto_increment  => qr/^(1|0)$/,
    avg_row_length  => qr/^\d+$/,
    checksum        => qr/^(1|0)$/,
    comment         => qr//,
    max_rows        => qr/^\d+$/,
    min_rows        => qr/^\d+$/,
    pack_keys       => qr/^(1|0)$/,
    password        => qr//,
    delay_key_write => qr/^\d+$/,
    row_format      => qr/^(default|dynamic|static|compressed)$/i,
    raid_type       => qr/^(?:1|STRIPED|RAID0|RAID_CHUNKS\s*=\s*\d+|RAID_CHUNKSIZE\s*=\s*\d+)$/,
    };
    my @options = ();
    my @errors  = ();
    ## Avoid working for nothing, make this condition
    if( %$opt )
    {
        my %lc_opt  = map{ lc( $_ ) => $opt->{ $_ } } keys( %$opt );
        $opt = \%lc_opt;
        foreach my $key ( keys( %$opt ) )
        {
            next if( $opt->{ $key } =~ /^\s*$/ || !exists( $allowed->{ $key } ) );
            if( $opt->{ $key } !~ /$allowed->{ $key }/ )
            {
                push( @errors, $key );
            }
            else
            {
                push( @options, $key );
            }
        }
        $opt->{comment} = "'" . quotemeta( $opt->{comment} ) . "'" if( exists( $opt->{comment} ) );
        $opt->{password} = "'" . $opt->{password} . "'" if( exists( $opt->{password} ) );
    }
    if( @errors )
    {
        warn( "The options '", join( ', ', @errors ), "' were either not recognized or malformed and thus were ignored.\n" );
    }
    ## Check statement
    my $select = '';
    if( $sth && ref( $sth ) && ( $sth->isa( "DB::Object::Statement" ) || $sth->can( 'as_string' ) ) )
    {
        $select = $sth->as_string();
        if( $select !~ /^\s*(?:IGNORE|REPLACE)*\s*\bSELECT\s+/ )
        {
            return( $self->error( "SELECT statement to use to create table is invalid:\n$select" ) );
        }
    }
    if( $self->exists() == 0 )
    {
        my $query = 'CREATE ' . ( $temp ? 'TEMPORARY ' : '' ) . "TABLE $table ";
        ## Structure of table if any - 
        ## structure may very well be provided using a select statement, such as:
        ## CREATE TEMPORARY TABLE ploppy TYPE=HEAP COMMENT='this is kewl' MAX_ROWS=10 SELECT * FROM some_table LIMIT 0,0
        my $def    = "(\n" . CORE::join( ",\n", @$data ) . "\n)" if( $data && ref( $data ) && @$data );
        my $tdef   = CORE::join( ' ', map{ "\U$_\E = $opt->{ $_ }" } @options );
        if( !$def && !$select )
        {
            return( $self->error( "Lacking table '$table' structure information to create it." ) );
        }
        $query .= join( ' ', $def, $tdef, $select );
        my $new = $self->prepare( $query ) ||
        return( $self->error( "Error while preparing query to create table '$table':\n$query", $self->errstr() ) );
        ## Trick so other method may follow, such as as_string(), fetchrow(), rows()
        if( !defined( wantarray() ) )
        {
            # print( STDERR "create(): wantarrays in void context.\n" );
            $new->execute() ||
            return( $self->error( "Error while executing query to create table '$table':\n$query", $new->errstr() ) );
        }
        return( $new );
    }
    else
    {
        return( $self->error( "Table '$table' already exists." ) );
    }
}

sub create_info
{
    my $self    = shift( @_ );
    my $table   = $self->{table};
    $self->structure();
    my $struct  = $self->{structure};
    my $fields  = $self->{fields};
    my $default = $self->{default};
    my $primary = $self->{primary};
    my @output = ();
    foreach my $field ( sort{ $fields->{ $a } <=> $fields->{ $b } } keys( %$fields ) )
    {
        push( @output, "$field $struct->{ $field }" );
    }
    push( @output, "PRIMARY KEY(" . CORE::join( ',', @$primary ) . ")" ) if( $primary && @$primary );
    my $info = $self->stat( $table );
    my @opt  = ();
    push( @opt, "TYPE = $info->{type}" ) if( $info->{type} );
    my $addons = $info->{create_options};
    if( $addons )
    {
        $addons =~ s/(\A|\s+)([\w\_]+)\s*=\s*/$1\U$2\E=/g;
        push( @opt, $addons );
    }
    push( @opt, "COMMENT='" . quotemeta( $info->{ 'comment' } ) . "'" ) if( $info->{comment} );
    my $str = "CREATE TABLE $table (\n\t" . CORE::join( ",\n\t", @output ) . "\n)";
    $str   .= ' ' . CORE::join( ' ', @opt ) if( @opt );
    $str   .= ';';
    return( @output ? $str : undef() );
}

# Inherited from DB::Object::Tables
# sub default

sub drop
{
    my $self  = shift( @_ );
    my $table = $self->{table} || 
    return( $self->error( "No table was provided to drop." ) );
    my $query = "DROP TABLE $table";
    my $sth = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to drop table '$table':\n$query", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to drop table '$table':\n$query", $sth->errstr() ) );
    }
    return( $sth );
}

sub exists
{
    return( shift->table_exists( shift( @_ ) ) );
}

sub lock
{
    my $self = shift( @_ );
    ## There is two arguments, the first one does not look like an exiting table name and the second is a number...
    ## It pretty much looks like a statement lock
    if( @_ == 2 && ( !$self->exists( $_[ 0 ] ) || $_[ 1 ] =~ /^\d+$/ ) )
    {
        return( $self->SUPER::lock( @_ ) );
    }
    my @tables = ();
    my $chk_opt = sub
    {
        my $self  = shift( @_ );
        my $table = shift( @_ );
        my $opt   = shift( @_ );
        my $alias = shift( @_ );
        if( $opt !~ /^(READ|READ\s+LOCAL|(LOW_PRIORITY\s+)?WRITE)$/i )
        {
            return( $self->error( "Bad table '$table' locking option '$opt'." ) );
        }
        if( $alias )
        {
            if( $self->_simple_exist( $alias ) )
            {
                return( $self->error( "Alias '$alias' for table '$table' seems to match an already existing table." ) );
            }
            elsif( $alias !~ /^[\w\_]+$/ )
            {
                return( $self->error( "Illegal characters for table '$table' alias name '$alias'." ) );
            }
        }
        return( 1 );
    };
    ## No parameter, so we default to WRITE for read/write access, but with a low priority
    if( !@_ )
    {
        push( @tables, "$self->{table} LOW_PRIORITY WRITE" );
    }
    elsif( @_ == 1 )
    {
        my $arg   = shift( @_ );
        my $alias = '';
        my $opt   = '';
        ## Array reference means 'table alias', 'access mode'
        if( $self->_is_array( $arg ) )
        {
            ( $alias, $opt ) = @$arg;
        }
        ## Otherwise just 'access mode'
        else
        {
            $opt = $arg;
        }
        $opt ||= 'LOW_PRIORITY WRITE';
        $chk_opt->( $self, $self->{table}, $opt, $alias ) || return;
        my @lck = ( $self->{table} );
        push( @lck, "AS $alias" ) if( $alias );
        push( @lck, uc( $opt ) );
        push( @tables, CORE::join( ' ', @lck ) );
    }
    else
    {
        my %arg = ( @_ );
        my( $tbl, $value );
        while( ( $tbl, $value ) = each( %arg ) )
        {
            my( $alias, $opt );
            if( !$value )
            {
                $opt = 'LOW_PRIORITY WRITE';
            }
            elsif( ref( $value ) )
            {
                ( $alias, $opt ) = @$value;
            }
            else
            {
                $opt = $value;
            }
            $opt ||= 'LOW_PRIORITY WRITE';
            $chk_opt->( $self, $tbl, $opt, $alias ) || return;
            my @lck = ( $tbl );
            push( @lck, "AS $alias" ) if( $alias );
            push( @lck, uc( $opt ) );
            push( @tables, CORE::join( ' ', @lck ) );
        }
    }
    my $query = 'LOCK TABLES ' . CORE::join( ', ', @tables );
    my $sth   = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to do tables locking:\n$query", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to do tables locking:\n$query", $sth->errstr() ) );
    }
    return( $sth );
}

# Inherited from DB::Object::Tables
# sub name

# Inherited from DB::Object::Tables
# sub null

sub optimize
{
    my $self  = shift( @_ );
    my $table = $self->{table} ||
    return( $self->error( 'No table was provided to optmize' ) );
    return( $self->error( "Table '$table' does not exist." ) ) if( !$self->exists( $table ) );
    my $query = "OPTIMIZE TABLE $table";
    my $sth = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to optimize table '$table':\n$query\n", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to optimize table '$table':\n$query\n", $sth->errstr() ) );
    }
    return( $sth );
}

# Inherited from DB::Object::Tables
# sub primary

sub qualified_name
{
    my $self = shift( @_ );
    my @val = ();
    CORE::push( @val, $self->database_object->database ) if( $self->{prefixed} > 2 );
    CORE::push( @val, $self->name );
    return( CORE::join( '.', @val ) );
}

sub rename
{
    my $self  = shift( @_ );
    my $table = $self->{table} ||
    return( $self->error( 'No table was provided to rename' ) );
    my $new   = shift( @_ ) ||
    return( $self->error( "No new table name was provided to rename table '$table'." ) );
    if( $new !~ /^[\w\_]+$/ )
    {
        return( $self->error( "Bad new table name '$new'." ) );
    }
    my $query = "ALTER TABLE $table RENAME TO $new";
    my $sth   = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to rename table '$table' into '$new':\n$query", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to rename table '$table' into '$new':\n$query", $sth->errstr() ) );
    }
    return( $sth );
}

sub repair
{
    my $self = shift( @_ );
    my $table = $self->{table} ||
    return( $self->error( 'No table was provided to repair' ) );
    return( $self->error( "Table '$table' does not exist." ) ) if( !$self->exists( $table ) );
    my $opts  = $self->_get_args_as_hash( @_ );
    my $query = "REPAIR TABLE $table";
    $query   .= ' TYPE = QUICK' if( $opts->{quick} );
    my $sth   = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to repair table '$table':\n$query\n", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to repair table '$table':\n$query\n", $sth->errstr() ) );
    }
    return( $sth );
}

sub stat
{
    my $self  = shift( @_ );
    # If no $table argument is provided, we will stat all tables
    my $table = shift( @_ );
    my $db    = $self->{database};
    my $query = $table ? "SHOW TABLE STATUS FROM $db LIKE '$table'" : "SHOW TABLE STATUS FROM $db";
    my $sth   = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to get the status of table", ( $table ? " '$table'" : 's' ), ":\n$query", $self->errstr() ) );
    $sth->execute() ||
    return( $self->error( "Error while executing query to get the status of table", ( $table ? " '$table'" : 's' ), ":\n$query", $sth->errstr() ) );
    my $tables = {};
    my $ref    = '';
    while( $ref = $sth->fetchrow_hashref() )
    {
        my %data = map{ lc( $_ ) => $ref->{ $_ } } keys( %$ref );
        my $name = $data{name};
        # map{ $tables->{ $name }->{ $_ } = $data{ $_ } } keys( %data );
        $tables->{ $name } = \%data;
    }
    $sth->finish();
    return( wantarray() ? () : undef() ) if( !%$tables );
    return( wantarray() ? %{ $tables->{ $table } } : $tables->{ $table } ) if( $table && exists( $tables->{ $table } ) );
    return( wantarray() ? %$tables : $tables );
}

sub structure
{
    my $self    = shift( @_ );
    my $table   = shift( @_ ) || $self->{table} ||
    do
    {
        $self->error( "No table provided to get its structure." );
        return( wantarray() ? () : undef() );
    };
    my $sth1 = $self->prepare_cached( "SELECT * FROM information_schema.tables WHERE table_name = ?" ) ||
    return( $self->error( "An error occured while preparing the sql query to get the details of table \"$table\": ", $self->errstr() ) );
    $sth1->execute( $table ) || return( $self->error( "An erro occured while executing the sql query to get the details of table \"$table\": ", $sth1->errstr() ) );
    my $def = $sth1->fetchrow_hashref;
    $sth1->finish;
    $self->{type} = lc( $def->{table_type} );
    $self->{type} = 'table' if( $self->{type} eq 'base table' );
    # $self->_reset_query();
    # delete( $self->{ 'query_reset' } );
    # my $struct  = $self->{ '_structure_real' } || $self->{ 'struct' }->{ $table };
    my $struct  = $self->{structure};
    my $fields  = $self->{fields};
    my $default = $self->{default};
    my $null    = $self->{null};
    my $types   = $self->{types};
    if( !%$fields || !%$struct || !%$default )
    {
        my $sth = $self->prepare( "SHOW COLUMNS FROM $table" ) ||
        return( $self->error( "Error while preparing query to get table '$table' columns specification: ", $self->errstr() ) );
        $sth->execute() ||
        return( $self->error( "Error while executing query to get table '$table' columns specification: ", $sth->errstr() ) );
## Returns:
## +-----------+---------------------+------+-----+---------+----------------+
## | Field     | Type                | Null | Key | Default | Extra          |
## +-----------+---------------------+------+-----+---------+----------------+
        my @primary = ();
        my $ref = '';
        my $c   = 0;
        while( $ref = $sth->fetchrow_hashref() )
        {
            my %data = map{ lc( $_ ) => $ref->{ $_ } } keys( %$ref );
            $data{default} = '' if( !defined( $data{default} ) );
            ## push( @order, $data{ 'field' } );
            $fields->{ $data{field} }  = ++$c;
            $types->{ $data{field} } = $data{type};
            $default->{ $data{field} } = '';
            $default->{ $data{field} } = $data{default} if( $data{default} ne '' && !$data{null} );
            $null->{ $data{field} } = $data{null} ? 1 : 0;
            my @define = ( $data{type} );
            push( @define, "DEFAULT '$data{default}'" ) if( $data{default} ne '' || !$data{null} );
            push( @define, "NOT NULL" ) if( !$data{null} );
            push( @primary, $data{field} ) if( $data{key} );
            $struct->{ $data{field} } = CORE::join( ' ', @define );
        }
        $sth->finish();
        if( @primary )
        {
            ## $struct->{ '_primary' } = \@primary;
            $self->{primary} = \@primary;
        }
        ## $self->{ '_structure_real' } = $struct;
        $self->{default}   = $default;
        $self->{fields}    = $fields;
        $self->{structure} = $struct;
        $self->{types}     = $types;
    }
    return( wantarray() ? () : undef() ) if( !%$struct );
    return( wantarray() ? %$struct : \%$struct );
}

sub unlock
{
    my $self = shift( @_ );
    if( @_ )
    {
        return( $self->CORE::unlock( @_ ) );
    }
    my $query = 'UNLOCK TABLES';
    my $sth   = $self->prepare( $query ) ||
    return( $self->error( "Error while preparing query to unlock tables:\n$query", $self->errstr() ) );
    if( !defined( wantarray() ) )
    {
        $sth->execute() ||
        return( $self->error( "Error while executing query to unlock tables:\n$query", $sth->errstr() ) );
    }
    return( $sth );
}

DESTROY
{
    # Do nothing
    # DB::Object::Tables are never destroyed.
    # They are just gateway to tables, and they are cached by DB::Object::table()
    # print( STDERR "DESTROY'ing table $self ($self->{ 'table' })\n" );
};

1;

# NOTE: POD

__END__

=encoding utf-8

=head1 NAME

DB::Object::Mysql::Tables - MySQL Table Object

=head1 SYNOPSIS

    use DB::Object::Mysql::Tables;
    my $this = DB::Object::Mysql::Tables->new || die( DB::Object::Mysql::Tables->error, "\n" );

=head1 VERSION

    v0.300.1

=head1 DESCRIPTION

This is a MySQL table object class.

=head1 METHODS

=head2 check

This will prepare the statement to C<check> the table.

Checking table is a query specific to C<MySQL>

If called in void context, the resulting statement handler will be executed immediately.

It returns the newly created statement handler.

=head2 create

This creates a table.

It takes some array reference data containing the columns definitions, some optional parameters and a statement handler.

If a statement handler is provided, then no need to provide an array reference of columns definition. The columns definition will be taken from the statement handler. However, at least either one of them needs to be provided to set the columns definition.

Possible parameters are:

=over 4

=item I<comment>

=item I<inherits>

Takes the name of another table to inherit from

=item I<on commit>

=item I<tablespace>

=item I<temporary>

If provided, this will create a temporary table.

=item I<with oids>

If true, this will enable table oid

=item I<without oids>

If true, this will disable table oid

=back

This will return an error if the table already exists, so best to check beforehand with L</exists>.

Upon success, it will return the new statement to create the table. However, if L</create> is called in void context, then the statement is executed right away and returned.

=head2 create_info

This returns the create info for the current table object as a string representing the sql script necessary to recreate the table.

=head2 drop

This will prepare a drop statement to drop the current table.

If it is called in void context, then the statement is executed immediately and returned, otherwise it is just returned.

It takes no option.

See L<MySQL documentation for more information|https://dev.mysql.com/doc/refman/8.0/en/drop-table.html>

=head2 exists

Returns true if the current table exists, or false otherwise.

=head2 lock

If no parameter is provided, this will issue the following query C<LOCK t LOW_PRIORITY WRITE> where t is the table name.

If one parameter is provided and is an array reference containing the table alias and some lock option, otherwise if the one parameter provided is the lock option. If no lock option is provided this will default to C<LOW_PRIORITY WRITE>.

For example:

    $t->lock([ 'n', 'low_priority write' ]);

This will issue the following query:

    LOCK TABLE t AS n LOW_PRIORITY WRITE

    $t->lock( 'low_priority write' );

This will issue the following query:

    LOCK TABLE t LOW_PRIORITY WRITE

If the parameters provided is an hash of table name-option pairs, such as:

    $t->lock(
        t1  => ['n' => 'low_priority write'], # alias to n with option
        t2  => 'low_priority write', # only option
    );

This will issue the following query:

    LOCK TABLES t1 AS n LOW_PRIORITY WRITE, t2 LOW_PRIORITY WRITE

The option can only be:

=over 4

=item I<read>

=item I<read local>

=item I<write>

=item I<low priority write>

=back

This will prepare the query to lock the table or tables and return the statement handler. If it is called in void context, the statement handler returned is executed immediately.

See L<MyQL documentation for more information|https://dev.mysql.com/doc/refman/5.7/en/lock-tables.html>

=head2 optimize

    my $sth = $t->optimize; # OPTIMIZE TABLE t

This will prepare a query to C<optimize> the table. If it is called in void context, the statement handler returned is executed immediately.

See L<MyQL documentation for more information|https://dev.mysql.com/doc/refman/5.7/en/optimize-table.html>

=head2 qualified_name

This return a fully qualified name to be used as a prefix to columns in queries.

Note that in MySQL there is no meaning of schema like in other modern drivers like PostgreSQL. In MySQL a C<schema> is equivalent to a C<database>. See this L<StackOverflow discussion|https://stackoverflow.com/questions/11618277/difference-between-schema-database-in-mysql>

If L<DB::Object::Tables/prefixed> is greater than 2, the database name will be added.

At minimum, the table name is added.

    $tbl->prefixed(2);
    $tbl->qualified_name;
    # Would return something like: mydb.my_table

    $tbl->prefixed(1);
    $tbl->qualified_name;
    # Would return only: my_table

See L<MyQL documentation for more information|https://dev.mysql.com/doc/refman/5.7/en/identifier-qualifiers.html>

=head2 rename

Provided with a new table name, and this will prepare the necessary query to rename the table and return the statement handler.

If it is called in void context, the statement handler is executed immediately.

    # Get the prefs table object
    my $tbl = $dbh->pref;
    $tbl->rename( 'prefs' );
    # Would issue a statement handler for the query: ALTER TABLE pref RENAME TO prefs

It returns the statement handler created.

See L<PostgreSQL documentation for more information|https://dev.mysql.com/doc/refman/5.7/en/alter-table.html>

=head2 repair

Provided with an optional hash or hash reference of parameter, and this will prepare a query to C<repair> the MySQL table.

    my $tbl = $dbh->my_table || die( $dbh->error );
    my $sth = $tbl->repair || die( $tbl->error );
    $sth->exec || die( $sth->error );

If it is called in void context, the statement handler is executed immediately.

It returns the statement handler created.

See L<PostgreSQL documentation for more information|https://dev.mysql.com/doc/refman/5.7/en/repair-table.html>

=head2 stat

Provided with a table name and this will prepare a C<SHOW TABLE STATUS> MySQL query. If no table explicitly specified, then this will prepare a stat query for all tables in the database.

    $tbl->stat( 'my_table' );
    # SHOW TABLE STATUS FROM my_database LIKE 'my_table'
    $tbl->stat;
    # SHOW TABLE STATUS FROM my_database

The stat statement will be executed and an hash reference of property-value pairs in lower case will be retrieved for each table. Each table hash is stored in another hash reference of table name-properties hash reference pairs.

If only one table was the subject of the stat, in list context, this returns an hash of those table stat properties, and in scalar context its hash reference.

If the stat was done for the entire database, in list context, this returns an hash of all those tables to properties pairs, or an hash reference in scalar context.

=head2 structure

This returns in list context an hash and in scalar context an hash reference of the table structure.

The hash, or hash reference returned contains the column name and its definition.

This method will also set the following object properties:

=over 4

=item L<DB::Object::Tables/type>

The table type.

=item L<DB::Object::Tables/schema>

No such thing in MySQL, so this is unavailable.

=item I<default>

A column name to default value hash reference

=item I<fields>

A column name to field position (integer) hash reference

=item I<null>

A column name to a boolean representing whether the column is nullable or not.

=item L<DB::Object::Tables/primary>

An array reference of column names that are used as primary key for the table.

=item I<structure>

A column name to its sql definition

=item I<types>

A column name to column data type hash reference

=back

=head2 unlock

This will unlock a previously locked table.

If an argument is provided, this calls instead C<CORE::unlock> passing it whatever parameters provided.

Otherwise, it will prepare a query C<UNLOCK TABLES> and returns the statement handler.

If it is called in void context, this will execute the statement handler immediately.

See L<MyQL documentation for more information|https://dev.mysql.com/doc/refman/5.7/en/lock-tables.html>

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Jacques Deguest E<lt>F<jack@deguest.jp>E<gt>

=head1 COPYRIGHT & LICENSE

Copyright (c) 2019-2021 DEGUEST Pte. Ltd.

You can use, copy, modify and redistribute this package and associated
files under the same terms as Perl itself.

=cut
