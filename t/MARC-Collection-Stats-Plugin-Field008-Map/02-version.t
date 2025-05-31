use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Field008::Map;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Plugin::Field008::Map::VERSION, 0.01, 'Version.');
