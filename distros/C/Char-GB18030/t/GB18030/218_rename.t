# encoding: GB18030
# This file is encoded in GB18030.
die "This file is not encoded in GB18030.\n" if q{あ} ne "\x82\xa0";

my $__FILE__ = __FILE__;

use GB18030;
print "1..3\n";

my $chcp = '';
if ($^O =~ /\A (?: MSWin32 | NetWare | symbian | dos ) \z/oxms) {
    $chcp = `chcp`;
}
if ($chcp !~ /932|936/oxms) {
    print "ok - 1 # SKIP $^X $0\n";
    print "ok - 2 # SKIP $^X $0\n";
    print "ok - 3 # SKIP $^X $0\n";
    exit;
}

open(FILE,'>F機能') || die "Can't open file: F機能\n";
print FILE "1\n";
close(FILE);

unlink('file');

# rename (1/3)
if (rename('F機能','file')) {
    print "ok - 1 rename (1/3) $^X $__FILE__\n";
}
else {
    print "not ok - 1 rename: $! $^X $__FILE__\n";
}

# rename (2/3)
if (rename('file','F機能')) {
    print "ok - 2 rename (2/3) $^X $__FILE__\n";
}
else {
    print "not ok - 2 rename: $! $^X $__FILE__\n";
}

# rename (3/3)
unlink('F2機能');
if (rename('F機能','F2機能')) {
    print "ok - 3 rename (3/3) $^X $__FILE__\n";
}
else {
    print "not ok - 3 rename: $! $^X $__FILE__\n";
}

unlink('F機能');
unlink('F2機能');

__END__
