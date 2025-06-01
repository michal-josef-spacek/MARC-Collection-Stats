package MARC::Collection::Stats::Utils;

use base qw(Exporter);
use strict;
use warnings;

use Readonly;

Readonly::Array our @EXPORT_OK => qw(process_more_characters);

our $VERSION = 0.01;

sub process_more_characters {
	my ($struct_hr, $key, $value) = @_;

	my $len = length $value;
	my $exp_value_und = '|' x $len;
	if ($value eq $exp_value_und) {
		$struct_hr->{$key}->{$value}++;
	} else {
		my @characters = split m//ms, $value;
		foreach my $char (@characters) {
			$struct_hr->{$key}->{$char}++;
		}
	}

	return;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

MARC::Collection::Stats::Utils - Utilities for MARC::Collection::Stats.

=head1 SYNOPSIS

 use MARC::Collection::Stats::Utils qw(process_more_characters);

 process_more_characters($struct_hr, $key, $value);

=head1 SUBROUTINES

=head2 C<process_more_characters>

 process_more_characters($struct_hr, $key, $value);

Process string defined in C<$value>. First detect if is string filled by all
characters with '|'. If yes, then increase counter for the string in C<$struct_hr->{$key}>.
If not, split string to characters and increate counter for each character.

Returns undef.

=head1 ERRORS

 No errors.

=head1 EXAMPLE1

=for comment filename=process_more_characters_pipe.pl

 use strict;
 use warnings;

 use Data::Printer;
 use MARC::Collection::Stats::Utils qw(process_more_characters);

 # Value.
 my $value = '||||';

 # Structure.
 my $struct_hr = {
         'key' => {
                 '||||' => 4,
         },
 };

 # Process value.
 process_more_characters($struct_hr, 'key', $value);

 # Print out.
 p $struct_hr;

 # Output:
 # {
 #     key   {
 #         ||||   5
 #     }
 # }

=head1 EXAMPLE2

=for comment filename=process_more_characters_different.pl

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

=head1 DEPENDENCIES

L<Exporter>,
L<Readonly>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/MARC-Collection-Stats>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2025 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
