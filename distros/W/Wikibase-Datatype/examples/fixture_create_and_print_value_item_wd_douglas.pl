#!/usr/bin/env perl

use strict;
use warnings;

use Test::Shared::Fixture::Wikibase::Datatype::Value::Item::Wikidata::Douglas;
use Wikibase::Datatype::Print::Value::Item;

# Object.
my $obj = Test::Shared::Fixture::Wikibase::Datatype::Value::Item::Wikidata::Douglas->new;

# Print out.
print scalar Wikibase::Datatype::Print::Value::Item::print($obj);

# Output:
# Q463035