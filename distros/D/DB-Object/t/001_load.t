# -*- perl -*-
BEGIN
{
    use strict;
    use lib './lib';
    use Test::More qw( no_plan );
#     use File::Find;
#     our @modules;
#     File::Find::find(sub
#     {
#         next unless( /\.pm$/ );
#         print( "Checking file '$_' ($File::Find::name)\n" );
#         $_ = $File::Find::name;
#         s,^./lib/,,;
#         s,\.pm$,,;
#         s,/,::,g;
#         push( @modules, $_ );
#     }, qw( ./lib ) );
};

BEGIN
{
#     for( @modules )
#     {
#         diag( "Checking module $_" );
#         use_ok( $_ );
#     }
# for m in `find ./lib -type f -name "*.pm"`; do echo $m | perl -pe 's,./lib/,,' | perl -pe 's,\.pm$,,' | perl -pe 's/\//::/g' | perl -pe 's,^(.*?)$,use_ok\( ''$1'' \)\;,'; done
    use_ok( 'DB::Object' );
    use_ok( 'DB::Object::Fields' );
    use_ok( 'DB::Object::Query' );
    use_ok( 'DB::Object::Cache::Tables' );
    use_ok( 'DB::Object::Statement' );
    use_ok( 'DB::Object::Tables' );
    use_ok( 'DB::Object::Fields::Field' );
    SKIP:
    {
        eval{ require DBD::SQLite; };
        skip( "SQLite or DBD::SQLite is not installed.", 4 ) if( $@ );
        use_ok( 'DB::Object::SQLite' );
        use_ok( 'DB::Object::SQLite::Query' );
        use_ok( 'DB::Object::SQLite::Statement' );
        use_ok( 'DB::Object::SQLite::Tables' );
    };
    SKIP:
    {
        eval{ require DBD::Pg; };
        skip( "PostgresSQL or DBD::Pg is not installed.", 5 ) if( $@ );
        use_ok( 'DB::Object::Postgres' );
        use_ok( 'DB::Object::Postgres::Query' );
        use_ok( 'DB::Object::Postgres::Statement' );
        use_ok( 'DB::Object::Postgres::Lo' );
        use_ok( 'DB::Object::Postgres::Tables' );
    };
    SKIP:
    {
        eval{ require DBD::mysql; };
        skip( "MySQL or DBD::mysql is not installed.", 4 ) if( $@ );
        use_ok( 'DB::Object::Mysql' );
        use_ok( 'DB::Object::Mysql::Query' );
        use_ok( 'DB::Object::Mysql::Statement' );
        use_ok( 'DB::Object::Mysql::Tables' );
    }
};

done_testing();

