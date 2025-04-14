use strict;
use warnings;

use MARC::Collection::Stats::Plugin::LargestPublishersSince2000;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($MARC::Collection::Stats::Plugin::LargestPublishersSince2000::VERSION, 0.01, 'Version.');
