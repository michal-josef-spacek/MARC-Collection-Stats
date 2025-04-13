use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('MARC::Collection::Stats::Plugin::Count');
}

# Test.
require_ok('MARC::Collection::Stats::Plugin::Count');
