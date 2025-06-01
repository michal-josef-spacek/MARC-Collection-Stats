package MARC::Collection::Stats::Plugin::Field008::Map;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use MARC::Collection::Stats::Utils qw(process_more_characters);
use MARC::Field008;
use MARC::Leader;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'field008_map';
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
	} elsif ($field_008->material_type eq 'map') {
		my $map = $field_008->material;
		$struct_hr->{'form_of_item'}->{$map->form_of_item}++;
		$struct_hr->{'government_publication'}->{$map->government_publication}++;
		$struct_hr->{'index'}->{$map->index}++;
		$struct_hr->{'projection'}->{$map->projection}++;
		process_more_characters($struct_hr, 'relief', $map->relief);
		process_more_characters($struct_hr, 'special_format_characteristics',
			$map->special_format_characteristics);
		$struct_hr->{'type_of_cartographic_material'}->{$map->type_of_cartographic_material}++;
	} else {
		$self->{'struct'}->{'stats'}->{'not_map'}++;
	}

	$self->{'struct'}->{'stats'}->{$self->name} = $struct_hr;

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	my $struct_hr = {};
	$struct_hr->{'form_of_item'} = {};
	$struct_hr->{'government_publication'} = {};
	$struct_hr->{'index'} = {};
	$struct_hr->{'projection'} = {};
	$struct_hr->{'relief'} = {};
	$struct_hr->{'special_format_characteristics'} = {};
	$struct_hr->{'type_of_cartographic_material'} = {};

	$self->{'struct'}->{'stats'}->{$self->name} = $struct_hr;

	return;
}

1;

__END__
