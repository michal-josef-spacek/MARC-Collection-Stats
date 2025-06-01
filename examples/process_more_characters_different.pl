#!/usr/bin/env perl

use strict;
use warnings;

use Data::Printer;
use MARC::Collection::Stats::Utils qw(process_more_characters);

# Value.
my $value = 'ab  ';

# Structure.
my $struct_hr = {
        'key' => {
                '||||' => 4,
                'a' => 1,
        },
};

# Process value.
process_more_characters($struct_hr, 'key', $value);

# Print out.
p $struct_hr;

# Output:
# {
#     key   {
#         " "    2,
#         ||||   4,
#         a      2,
#         b      1
#     }
# }