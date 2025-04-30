use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('MARC::Collection::Stats::Plugin::Multiplicity');
}

# Test.
require_ok('MARC::Collection::Stats::Plugin::Multiplicity');
