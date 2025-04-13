use strict;
use warnings;

use MARC::Collection::Stats;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::VERSION, 0.01, 'Version.');
