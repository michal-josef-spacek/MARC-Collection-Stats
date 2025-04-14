use strict;
use warnings;

use MARC::Collection::Stats::Plugin::LargestPublishersSince;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::LargestPublishersSince->new;
is($obj->name, 'largest_publishers_since', 'Get plugin name (largest_publishers_since).');
