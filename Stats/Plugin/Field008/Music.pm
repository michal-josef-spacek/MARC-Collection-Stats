package MARC::Collection::Stats::Plugin::Field008::Music;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use MARC::Field008;
use MARC::Leader;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'field008_music';
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
	} elsif ($field_008->material_type eq 'music') {
		my $music = $field_008->material;
		$struct_hr->{'form_of_composition'}->{$music->form_of_composition}++;
		$struct_hr->{'format_of_music'}->{$music->format_of_music}++;
		$struct_hr->{'music_parts'}->{$music->music_parts}++;
		$struct_hr->{'target_audience'}->{$music->target_audience}++;
		$struct_hr->{'form_of_item'}->{$music->form_of_item}++;
		my @accompanying_matter = split m//ms, $music->accompanying_matter;
		foreach my $accompanying_matter (@accompanying_matter) {
			$struct_hr->{'accompanying_matter'}->{$accompanying_matter}++;
		}
		my @literary_text_for_sound_recordings
			= split m//ms, $music->literary_text_for_sound_recordings;
		foreach my $literary_text_for_sound_recordings (@literary_text_for_sound_recordings) {
			$struct_hr->{'literary_text_for_sound_recordings'}
				->{$literary_text_for_sound_recordings}++;
		}
		$struct_hr->{'transposition_and_arrangement'}
			->{$music->transposition_and_arrangement}++;
	} else {
		$self->{'struct'}->{'stats'}->{'not_music'}++;
	}

	$self->{'struct'}->{'stats'}->{$self->name} = $struct_hr;

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	my $struct_hr = {};
	$struct_hr->{'accompanying_matter'} = {};
	$struct_hr->{'form_of_composition'} = {};
	$struct_hr->{'form_of_item'} = {};
	$struct_hr->{'format_of_music'} = {};
	$struct_hr->{'literary_text_for_sound_recordings'} = {};
	$struct_hr->{'music_parts'} = {};
	$struct_hr->{'target_audience'} = {};
	$struct_hr->{'transposition_and_arrangement'} = {};

	$self->{'struct'}->{'stats'}->{$self->name} = $struct_hr;

	return;
}

1;

__END__
