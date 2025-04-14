use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('MARC::Collection::Stats::Plugin::LargestPublishersSince2000', 'MARC::Collection::Stats::Plugin::LargestPublishersSince2000 is covered.');
