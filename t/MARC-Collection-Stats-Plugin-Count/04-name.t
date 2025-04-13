use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Count;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::Count->new;
is($obj->name, 'count', 'Get name of plugin (count).');
