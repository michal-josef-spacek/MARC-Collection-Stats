use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Multiplicity;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::Multiplicity->new;
is($obj->name, 'multiplicity', 'Get plugin name (cataloging_agency).');
