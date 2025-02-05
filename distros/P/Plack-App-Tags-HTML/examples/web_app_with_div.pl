#!/usr/bin/env perl

use strict;
use warnings;

package App;

use base qw(Tags::HTML);

sub _process {
        my ($self, $value_hr) = @_;

        $self->{'tags'}->put(
                ['b', 'div'],
                ['a', 'class', 'my-class'],
                ['d', join ',', @{$value_hr->{'foo'}}],
                ['e', 'div'],
        );

        return;
}

sub _process_css {
        my $self = shift;

        $self->{'css'}->put(
                ['s', '.my-class'],
                ['d', 'border', '1px solid black'],
                ['e'],
        );

        return;
}

package main;

use Plack::App::Tags::HTML;
use Plack::Runner;

# Run application.
my $app = Plack::App::Tags::HTML->new(
        'component' => 'App',
        'data' => [{
                'foo' => [1, 2],
        }],
)->to_app;
Plack::Runner->new->run($app);

# Output:
# HTTP::Server::PSGI: Accepting connections at http://0:5000/

# > curl http://localhost:5000/
# <!DOCTYPE html>
# <html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><style type="text/css">.my-class{border:1px solid black;}
# </style></head><body><div class="my-class">1,2</div></body></html>