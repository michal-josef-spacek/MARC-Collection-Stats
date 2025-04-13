use strict;
use warnings;

use MARC::Collection::Stats::Plugin::MaterialType;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::MaterialType->new;
isa_ok($obj, 'MARC::Collection::Stats::Plugin::MaterialType');
