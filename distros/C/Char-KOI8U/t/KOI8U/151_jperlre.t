# encoding: KOI8U
# This file is encoded in KOI8-U.
die "This file is not encoded in KOI8-U.\n" if q{��} ne "\x82\xa0";

use KOI8U;
print "1..1\n";

my $__FILE__ = __FILE__;

eval q< '-' =~ /(��[)/ >;
if ($@) {
    print "ok - 1 $^X $__FILE__ die ('-' =~ /��[/).\n";
}
else {
    print "not ok - 1 $^X $__FILE__ die ('-' =~ /��[/).\n";
}

__END__
