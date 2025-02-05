
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    print qq{1..0 # SKIP these tests are for testing by the author\n};
    exit
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'bin/cpandb',
    'lib/CPAN/SQLite.pm',
    'lib/CPAN/SQLite/DBI.pm',
    'lib/CPAN/SQLite/DBI/Index.pm',
    'lib/CPAN/SQLite/DBI/Search.pm',
    'lib/CPAN/SQLite/Index.pm',
    'lib/CPAN/SQLite/Info.pm',
    'lib/CPAN/SQLite/META.pm',
    'lib/CPAN/SQLite/Populate.pm',
    'lib/CPAN/SQLite/Search.pm',
    'lib/CPAN/SQLite/State.pm',
    'lib/CPAN/SQLite/Util.pm',
    't/00-all_prereqs.t',
    't/00-compile.t',
    't/00-compile/lib_CPAN_SQLite_DBI_Index_pm.t',
    't/00-compile/lib_CPAN_SQLite_DBI_Search_pm.t',
    't/00-compile/lib_CPAN_SQLite_DBI_pm.t',
    't/00-compile/lib_CPAN_SQLite_Index_pm.t',
    't/00-compile/lib_CPAN_SQLite_Info_pm.t',
    't/00-compile/lib_CPAN_SQLite_META_pm.t',
    't/00-compile/lib_CPAN_SQLite_Populate_pm.t',
    't/00-compile/lib_CPAN_SQLite_Search_pm.t',
    't/00-compile/lib_CPAN_SQLite_State_pm.t',
    't/00-compile/lib_CPAN_SQLite_Util_pm.t',
    't/00-compile/lib_CPAN_SQLite_pm.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/000-report-versions.t',
    't/01basic.t',
    't/02drop.t',
    't/03info.t',
    't/04search.t',
    't/04search_everything.t',
    't/05meta_new.t',
    't/05meta_update.t',
    't/06retrieve.t',
    't/07download.t',
    't/08circular_references.t',
    't/author-critic.t',
    't/author-distmeta.t',
    't/author-eol.t',
    't/author-minimum-version.t',
    't/author-no-tabs.t',
    't/author-pod-syntax.t',
    't/lib/TestSQL.pm',
    't/lib/TestShell.pm',
    't/lib/TestShellDiag.pm',
    't/release-changes_has_content.t',
    't/release-fixme.t',
    't/release-has-version.t',
    't/release-kwalitee.t',
    't/release-meta-json.t',
    't/release-pause-permissions.t',
    't/testrules.yml'
);

notabs_ok($_) foreach @files;
done_testing;
