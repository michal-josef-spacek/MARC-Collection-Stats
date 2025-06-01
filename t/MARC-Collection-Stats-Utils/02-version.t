use strict;
use warnings;

use MARC::Collection::Stats::Utils;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Utils::VERSION, 0.01, 'Version.');
