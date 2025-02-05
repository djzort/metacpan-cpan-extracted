package My::Role::R2;

use Test::Lib;

use Moo::Role;

with 'My::Role::T2';

use namespace::clean -except => 'has';

has r2_1 => (
    is      => 'rw',
    T2_1    => 'r2_1.t2_1',
    T2_2    => 'r2_1.t2_2',
    default => 'r2_1.v'
);

has r2_2 => (
    is      => 'rw',
    T2_1    => 'r2_2.t2_1',
    default => 'r2_2.v'
);

1;
