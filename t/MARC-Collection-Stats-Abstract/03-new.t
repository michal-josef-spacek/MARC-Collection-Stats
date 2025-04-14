use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use MARC::Collection::Stats::Abstract;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Abstract->new;
isa_ok($obj, 'MARC::Collection::Stats::Abstract');

# Test.
eval {
	MARC::Collection::Stats::Abstract->new(
		'debug' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'debug' must be a bool (0/1).\n",
	"Parameter 'debug' must be a bool (0/1) (bad).");
clean();

# Test.
eval {
	MARC::Collection::Stats::Abstract->new(
		'verbose' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'verbose' must be a bool (0/1).\n",
	"Parameter 'verbose' must be a bool (0/1) (bad).");
clean();
