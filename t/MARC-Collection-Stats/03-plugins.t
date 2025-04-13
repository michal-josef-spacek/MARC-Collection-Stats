use strict;
use warnings;

use MARC::Collection::Stats;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my @ret = MARC::Collection::Stats::plugins;
ok(scalar @ret > 1, 'Number of plugins (>1).');
