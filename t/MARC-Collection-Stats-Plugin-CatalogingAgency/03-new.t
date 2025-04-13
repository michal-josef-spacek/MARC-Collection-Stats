use strict;
use warnings;

use MARC::Collection::Stats::Plugin::CatalogingAgency;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::CatalogingAgency->new;
isa_ok($obj, 'MARC::Collection::Stats::Plugin::CatalogingAgency');
