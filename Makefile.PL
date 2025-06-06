use lib '.';
use strict;
use warnings;

use inc::Module::Install;

# Definition.
abstract 'MARC collection statistics plugins.';
author 'Michal Josef Spacek <skim@cpan.org>';
author_requires 'English' => 0;
author_requires 'File::Object' => 0.05;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
license 'bsd';
name 'MARC-Collection-Stats';
perl_version 5.006002;
readme_from 'Stats.pm';
recursive_author_tests('xt');
requires 'Class::Utils' => 0.03;
requires 'DateTime' => 0;
requires 'English' => 0;
requires 'Error::Pure' => 0;
requires 'Error::Pure::Utils' => 0;
requires 'List::Util' => 1.33;
requires 'MARC::Field008' => 0;
requires 'MARC::Leader' => 0.04;
requires 'MARC::Leader::Utils' => 0;
requires 'Mo::utils' => 0.06;
requires 'Module::Pluggable' => 0;
requires 'Readonly' => 0;
resources 'bugtracker' => 'https://github.com/michal-josef-spacek/MARC-Collection-Stats/issues',
resources 'homepage' => 'https://github.com/michal-josef-spacek/MARC-Collection-Stats';
resources 'repository' => 'git://github.com/michal-josef-spacek/MARC-Collection-Stats';
test_requires 'English' => 0;
test_requires 'Error::Pure::Utils' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
