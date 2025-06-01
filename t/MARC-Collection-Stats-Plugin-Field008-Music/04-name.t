use strict;
use warnings;

use MARC::Collection::Stats::Plugin::Field008::Music;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = MARC::Collection::Stats::Plugin::Field008::Music->new;
is($obj->name, 'field008_music', 'Get name of plugin (field008_music).');
