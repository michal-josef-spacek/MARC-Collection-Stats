use strict;
use warnings;

use MARC::Collection::Stats::Utils qw(process_more_characters);
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $struct_hr = {};
process_more_characters($struct_hr, 'key', '||||');
is_deeply(
	$struct_hr,
	{
		'key' => {
			'||||' => 1,
		},
	},
	'Process more characters (||||).',
);

# Test.
$struct_hr = {};
process_more_characters($struct_hr, 'key', 'aab ');
is_deeply(
	$struct_hr,
	{
		'key' => {
			' ' => 1,
			'a' => 2,
			'b' => 1,
		},
	},
	'Process more characters (aab ).',
);
