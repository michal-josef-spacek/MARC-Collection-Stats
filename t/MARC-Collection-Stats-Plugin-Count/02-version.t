use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Count;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Plugin::Count::VERSION, 0.01, 'Version.');
