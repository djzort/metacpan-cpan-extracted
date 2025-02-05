#! /usr/bin/env perl

use 5.024; use warnings;
use lib qw< dlib ../dlib >;

use Perl6::Loops;

loop {
    say 'tick';
    last if rand() < 0.2;
}
say 'BOOM!';

while (readline) -> $input {
    print "Got: $input";
    last;
}

while (my $input = readline) {
    print "Got: $input";
    last;
}

my $x;

$x = 0;
repeat until ($x >= 10) {
    print '> ';
    $x = readline;
    last if $x == 0;
}

say "Got: $x";


$x = 0;
repeat while ($x < 10) {
    print '> ';
    $x = readline;
    last if $x == 0;
}

say "Got: $x";


$x = 0;
repeat {
    print '> ';
    $x = readline;
    last if $x == 0;
} while $x < 10;

say "Got: $x";


$x = 0;
repeat {
    print '> ';
    $x = readline;
    last if $x == 0;
} until $x >= 10;

say "Got: $x";

for       (^10) { say;    }
for my $n (^10) { say $n; }

for (^10) -> $x, $y, $z {
    $y //= 'undef';
    $z //= 'undef';
    say "$x -> $y : $z";
}

my %collective_of = (
    cats     => 'clowder',
    dogs     => 'pack',
    dolphins => 'pod',
    crows    => 'murder',
);


for (%collective_of) -> $animal, $group {
    FIRST { say 'Did you know that...' }
    say "\tA group of $animal is a $group";
    LAST  { say '[END OF LIST]'; }
}

my @errors = (
    'Missing loop body at line 7',
    'Unknown keyword ("hwile") at line 12',
    'Undeclared monkey typing at line 23',
);

for my $error_msg (@errors) {
    FIRST { say 'Errors detected: ' . @errors; }
    say "\t$error_msg";
    LAST  { warn "Compilation failed\n"; }
}

warn 'Done at line 85';


