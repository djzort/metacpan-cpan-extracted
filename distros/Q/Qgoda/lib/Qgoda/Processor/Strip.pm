#! /bin/false

# Copyright (C) 2016-2018 Guido Flohr <guido.flohr@cantanea.com>,
# all rights reserved.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package Qgoda::Processor::Strip;
$Qgoda::Processor::Strip::VERSION = 'v0.9.3';
use strict;

use base qw(Qgoda::Processor);

use Text::Markdown::Hoedown qw(markdown);

sub new {
    my ($class, %options) = @_;

    my $self = $class->SUPER::new(%options);
    $self->{__options} = \%options;

    return $self;
}

sub process {
    my ($self, $content, $asset, $filename) = @_;

    my $trailing_newline = $content =~ /\n$/ ? 1 : undef;
    $content =~ s/^[ \011-\015]+//;
    $content =~ s/[ \011-\015]+$//;
    $content .= "\n" if $trailing_newline;

    return $content;
}

1;

=head1 NAME

Qgoda::Processor::Strip - Qgoda Strip Processor

=head1 DESCRIPTION

Strips leading and trailing whitespace.
