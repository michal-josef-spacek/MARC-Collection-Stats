use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use MARC::Collection::Stats::Abstract;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
eval {
	MARC::Collection::Stats::Abstract->new;
};
is($EVAL_ERROR, "MARC::Collection::Stats::Abstract is abstract class,\n",
	"MARC::Collection::Stats::Abstract is abstract class,");
clean();
