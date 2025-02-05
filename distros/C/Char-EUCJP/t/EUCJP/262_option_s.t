# encoding: EUCJP
# This file is encoded in EUC-JP.
die "This file is not encoded in EUC-JP.\n" if q{��} ne "\xa4\xa2";

use strict;
use EUCJP;
print "1..6\n";

my $__FILE__ = __FILE__;

$_ = '12%3a34%3a56';
s/%(..)/pack("C",hex($1))/ge;
if ($_ eq '12:34:56') {
    print qq{ok - 1 s/%(..)/pack("C",hex(\$1))/ge; $^X $__FILE__\n};
}
else {
    print qq{not ok - 1 s/%(..)/pack("C",hex(\$1))/ge; $^X $__FILE__\n};
}

$_ = '12%3a34%3a56';
s'%(..)'pack("C",hex($1))'ge;
if ($_ eq '12:34:56') {
    print qq{ok - 2 s'%(..)'pack("C",hex(\$1))'ge; $^X $__FILE__\n};
}
else {
    print qq{not ok - 2 s'%(..)'pack("C",hex(\$1))'ge; $^X $__FILE__\n};
}

$_ = '12%3a34%3a56';
s/%(..)/sprintf("\t")/ge;
if ($_ eq "12\t34\t56") {
    print qq{ok - 3 s/%(..)/sprintf("\\t")/ge; $^X $__FILE__\n};
}
else {
    print qq{not ok - 3 s/%(..)/sprintf("\\t")/ge; $^X $__FILE__\n};
}

$_ = '12%3a34%3a56';
s'%(..)'sprintf("\t")'ge;
if ($_ eq "12\t34\t56") {
    print qq{ok - 4 s'%(..)'sprintf("\\t")'ge; $^X $__FILE__\n};
}
else {
    print qq{not ok - 4 s'%(..)'sprintf("\\t")'ge; $^X $__FILE__\n};
}

$_ = '12%3a34%3a56';
s/%(..)/sprintf('\t')/ge;
if ($_ eq '12\t34\t56') {
    print qq{ok - 5 s/%(..)/sprintf('\\t')/ge; $^X $__FILE__\n};
}
else {
    print qq{not ok - 5 s/%(..)/sprintf('\\t')/ge; $^X $__FILE__\n};
}

$_ = '12%3a34%3a56';
s'%(..)'sprintf(q{\t})'ge;
if ($_ eq '12\t34\t56') {
    print qq{ok - 6 s'%(..)'sprintf(q{\\t})'ge; $^X $__FILE__\n};
}
else {
    print qq{not ok - 6 s'%(..)'sprintf(q{\\t})'ge; $^X $__FILE__\n};
}

__END__
