use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Languages;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Plugin::Languages::VERSION, 0.01, 'Version.');
