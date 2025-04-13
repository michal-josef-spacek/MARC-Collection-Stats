use strict;
use warnings;

use MARC::Collection::Stats::Plugin::MaterialType;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::MaterialType->new;
is($obj->name, 'material_type', 'Get name of plugin (material_type).');
