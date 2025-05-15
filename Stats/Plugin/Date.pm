package MARC::Collection::Stats::Plugin::Date;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Unicode::UTF8 qw(decode_utf8 encode_utf8);

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'date';
}

sub process {
	my ($self, $marc_record) = @_;

	my @keys;

	my $leader_string = $marc_record->leader;
	my $leader = MARC::Leader->new(
		'verbose' => $self->{'verbose'},
	)->parse($leader_string);

	my $cnb = $marc_record->field('015')->subfield('a');

	my $field_008_string = $marc_record->field('008')->as_string;
	my $field_008 = eval {
		MARC::Field008->new(
			'leader' => $leader,
			'verbose' => $self->{'verbose'},
		)->parse($field_008_string);
	};
	if ($EVAL_ERROR) {
		if ($self->{'debug'}) {
			$self->_print("CNB id '$cnb' has not valid 008 field.");
		}
		push @keys, 'not_valid_008';
		clean();
	} else {
		if ($field_008->date1 eq '9999') {
			push @keys, 'field_008_date1_9999';
		} elsif ($field_008->date1 =~ m/^\d+$/ms) {
			push @keys, 'field_008_date1_numbers';
		} elsif ($field_008->date1 =~ m/^\d{3}u$/ms) {
			push @keys, 'field_008_date1_NNNu';
		} elsif ($field_008->date1 =~ m/^\d{2}uu$/ms) {
			push @keys, 'field_008_date1_NNuu';
		} elsif ($field_008->date1 =~ m/^\duuu$/ms) {
			push @keys, 'field_008_date1_Nuuu';
		} elsif ($field_008->date1 =~ m/^uuuu$/ms) {
			push @keys, 'field_008_date1_uuuu';
		} elsif ($field_008->date1 =~ m/^\s+$/ms) {
			push @keys, 'field_008_date1_blank';
		}

		if ($field_008->date2 eq '9999') {
			push @keys, 'field_008_date2_9999';
		} elsif ($field_008->date2 =~ m/^\d+$/ms) {
			push @keys, 'field_008_date2_numbers';
		} elsif ($field_008->date2 =~ m/^\d{3}u$/ms) {
			push @keys, 'field_008_date2_NNNu';
		} elsif ($field_008->date2 =~ m/^\d{2}uu$/ms) {
			push @keys, 'field_008_date2_NNuu';
		} elsif ($field_008->date2 =~ m/^\duuu$/ms) {
			push @keys, 'field_008_date2_Nuuu';
		} elsif ($field_008->date2 =~ m/^uuuu$/ms) {
			push @keys, 'field_008_date2_uuuu';
		} elsif ($field_008->date2 =~ m/^\s+$/ms) {
			push @keys, 'field_008_date2_blank';
		}
	}

	foreach my $key (@keys) {
		$self->{'struct'}->{'stats'}->{'field_008'}->{$key}++;
	}

	@keys = ();
	my @fields_260 = $marc_record->field('260');
	foreach my $field_260 (@fields_260) {
		my @field_260c = $field_260->subfield('c');
		foreach my $field_260c (@field_260c) {
			my $C = decode_utf8('©');
			if ($field_260c =~ m/^\d+$/ms) {
				push @keys, 'field_260c_numbers';
			} elsif ($field_260c =~ m/^\[\d+\]$/ms
				|| $field_260c =~ m/^\[\d+$/ms
				|| $field_260c =~ m/^\d+\]$/ms) {

				push @keys, 'field_260c_numbers_not_on_book';
			} elsif ($field_260c =~ m/^\[\d+\?\]$/ms) {
				push @keys, 'field_260c_numbers_not_on_book_probably';
			} elsif ($field_260c =~ m/^c\d+$/ms
				|| $field_260c =~ m/^$C\d+$/ms
				|| $field_260c =~ m/^$C\s+\d+$/ms) {

				push @keys, 'field_260c_numbers_copyright';
			} elsif ($field_260c =~ m/^\d+\-\d+$/ms) {
				push @keys, 'field_260c_numbers_range';
			} elsif ($field_260c =~ m/^\[\d+\]\-\d+$/ms) {
				push @keys, 'field_260c_numbers_range_from_not_on_book';
			} elsif ($field_260c =~ m/^\[\d+\?\]\-\d+$/ms) {
				push @keys, 'field_260c_numbers_range_from_not_on_book_probably';
			} elsif ($field_260c =~ m/^\d+\-\[\d+\]$/ms) {
				push @keys, 'field_260c_numbers_range_to_not_on_book';
			} elsif ($field_260c =~ m/^\d+\-$/ms) {
				push @keys, 'field_260c_numbers_range_from';
			} elsif ($field_260c =~ m/^\[\d+\]\-$/ms) {
				push @keys, 'field_260c_numbers_range_from_from_not_on_book';
			} elsif ($field_260c =~ m/^\[\d+\?\]\-$/ms) {
				push @keys, 'field_260c_numbers_range_from_from_not_on_book_probably';
			} elsif ($field_260c =~ m/^\[\d+\-\d+\]$/ms) {
				push @keys, 'field_260c_numbers_range_not_on_book';
			} else {
				if ($self->{'debug'}) {
					$self->_print("CNB id '$cnb' has field 260c = '$field_260c'.");
				}
				push @keys, 'field_260c_other';
			}
		}
	}

	foreach my $key (@keys) {
		$self->{'struct'}->{'stats'}->{'field_260c'}->{$key}++;
	}

	@keys = ();
	my @fields_264 = $marc_record->field('264');
	foreach my $field_264 (@fields_264) {
		my @field_264c = $field_264->subfield('c');
		foreach my $field_264c (@field_264c) {
			my $C = decode_utf8('©');
			if ($field_264c =~ m/^\d+$/ms) {
				push @keys, 'field_264c_numbers';
			} elsif ($field_264c =~ m/^\[\d+\]$/ms
				|| $field_264c =~ m/^\[\d+$/ms
				|| $field_264c =~ m/^\d+\]$/ms) {

				push @keys, 'field_264c_numbers_not_on_book';
			} elsif ($field_264c =~ m/^\[\d+\?\]$/ms) {
				push @keys, 'field_264c_numbers_not_on_book_probably';
			} elsif ($field_264c =~ m/^c\d+$/ms
				|| $field_264c =~ m/^$C\d+$/ms
				|| $field_264c =~ m/^$C\s+\d+$/ms) {

				push @keys, 'field_264c_numbers_copyright';
			} elsif ($field_264c =~ m/^\d+\-\d+$/ms) {
				push @keys, 'field_264c_numbers_range';
			} elsif ($field_264c =~ m/^\[\d+\]\-\d+$/ms) {
				push @keys, 'field_264c_numbers_range_from_not_on_book';
			} elsif ($field_264c =~ m/^\[\d+\?\]\-\d+$/ms) {
				push @keys, 'field_264c_numbers_range_from_not_on_book_probably';
			} elsif ($field_264c =~ m/^\d+\-\[\d+\]$/ms) {
				push @keys, 'field_264c_numbers_range_to_not_on_book';
			} elsif ($field_264c =~ m/^\d+\-$/ms) {
				push @keys, 'field_264c_numbers_range_from';
			} elsif ($field_264c =~ m/^\[\d+\]\-$/ms) {
				push @keys, 'field_264c_numbers_range_from_from_not_on_book';
			} elsif ($field_264c =~ m/^\[\d+\?\]\-$/ms) {
				push @keys, 'field_264c_numbers_range_from_from_not_on_book_probably';
			} elsif ($field_264c =~ m/^\[\d+\-\d+\]$/ms) {
				push @keys, 'field_264c_numbers_range_not_on_book';
			} else {
				if ($self->{'debug'}) {
					$self->_print("CNB id '$cnb' has field 264c = '$field_264c'.");
				}
				push @keys, 'field_264c_other';
			}
		}
	}

	foreach my $key (@keys) {
		$self->{'struct'}->{'stats'}->{'field_264c'}->{$key}++;
	}

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'field_008'} = {};
	$self->{'struct'}->{'stats'}->{'field_260c'} = {};
	$self->{'struct'}->{'stats'}->{'field_264c'} = {};

	return;
}

sub _print {
	my ($self, $value) = @_;

	print encode_utf8($value)."\n";

	return;
}

1;

__END__
