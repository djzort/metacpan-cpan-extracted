#!/usr/bin/env perl

package Prty::Fibu::Bankbuchung::Test;
use base qw/Prty::Test::Class/;

use strict;
use warnings;
use v5.10.0;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Prty::Fibu::Bankbuchung');
}

# -----------------------------------------------------------------------------

package main;
Prty::Fibu::Bankbuchung::Test->runTests;

# eof
