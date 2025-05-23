package MARC::Collection::Stats::Plugin::Field008;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use English;
use MARC::Leader;
use MARC::Field008;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'field_008';
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
			print "CNB id '$cnb' has not valid 008 field.\n";
		}
		push @keys, 'not_valid_008';
	}

	if (! @keys) {
		push @keys, $field_008->type_of_date;
	}

	foreach my $key (@keys) {
		$self->{'struct'}->{'stats'}->{'field_008_type_of_date'}->{$key}++;
	}

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'field_008_type_of_date'} = {};

	return;
}

1;

__END__
