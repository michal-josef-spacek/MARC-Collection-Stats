package MARC::Collection::Stats::Plugin::Field008;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use MARC::Leader;
use MARC::Field008;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'field_008';
}

sub process {
	my ($self, $marc_record) = @_;

	my $struct_hr = $self->{'struct'}->{'stats'}->{$self->name};

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
		$self->{'struct'}->{'stats'}->{'not_valid_008'}++;
		clean();
	} else {
		my $type_of_date = $field_008->type_of_date;
		$struct_hr->{'type_of_date'}->{$type_of_date}++;
	}

	$self->{'struct'}->{'stats'}->{$self->name} = $struct_hr;

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{$self->name} = {};
	$self->{'struct'}->{'stats'}->{$self->name}->{'type_of_date'} = {};

	return;
}

1;

__END__
