use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Date;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Plugin::Date::VERSION, 0.01, 'Version.');
