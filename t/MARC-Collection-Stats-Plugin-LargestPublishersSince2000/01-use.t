use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('MARC::Collection::Stats::Plugin::LargestPublishersSince2000');
}

# Test.
require_ok('MARC::Collection::Stats::Plugin::LargestPublishersSince2000');
