package Devel::AssertOS::HWCapabilities::Int64;

use strict;
use warnings;
no warnings 'redefine';

use Devel::CheckOS;
use Config;

our $VERSION = '1.0';

sub os_is { $Config{ivsize} == 8 }

sub expn { "Your perl was built with support 64 bit integers" }

Devel::CheckOS::die_unsupported() unless(os_is());

=head1 COPYRIGHT and LICENCE

Copyright 2007 - 2022 David Cantrell

This software is free-as-in-speech software, and may be used, distributed, and modified under the terms of either the GNU General Public Licence version 2 or the Artistic Licence. It's up to you which one you use. The full text of the licences can be found in the files GPL2.txt and ARTISTIC.txt, respectively.

=cut

1;
