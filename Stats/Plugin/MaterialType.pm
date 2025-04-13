package MARC::Collection::Stats::Plugin::MaterialType;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use English;
use MARC::Leader 0.04;
use MARC::Leader::Utils qw(material_type);

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'material_type';
}

sub process {
	my ($self, $marc_record) = @_;

	my $leader_string = $marc_record->leader;
	my $leader = MARC::Leader->new(
		'verbose' => $self->{'verbose'},
	)->parse($leader_string);
	my $material_type = eval {
		material_type($leader);
	};
	if ($EVAL_ERROR) {
		$material_type = 'unsupported';
	}
	
	$self->{'struct'}->{'stats'}->{'material_type'}->{$material_type}++;

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'material_type'} = {};

	return;
}

1;

__END__
