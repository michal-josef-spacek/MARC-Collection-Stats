use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Field008::Map;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::Field008::Map->new;
is($obj->name, 'field008_map', 'Get name of plugin (field008_map).');
