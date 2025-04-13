use strict;
use warnings;

use MARC::Collection::Stats::Abstract;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Abstract::VERSION, 0.01, 'Version.');
