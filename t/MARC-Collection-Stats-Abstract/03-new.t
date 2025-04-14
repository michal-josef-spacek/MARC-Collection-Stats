use strict;
use warnings;

use MARC::Collection::Stats::Abstract;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Abstract->new;
isa_ok($obj, 'MARC::Collection::Stats::Abstract');
