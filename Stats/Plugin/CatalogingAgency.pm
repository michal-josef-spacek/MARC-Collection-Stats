package MARC::Collection::Stats::Plugin::CatalogingAgency;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'cataloging_agency';
}

sub process {
	my ($self, $record) = @_;

	my $original_cataloging_agency_key = 'not_040';
	my $field_040 = $record->field('040');
	if (defined $field_040) {
		my $field_040a = $field_040->subfield('a');
		if (defined $field_040a) {
			$original_cataloging_agency_key = $field_040a;
		} else {
			$original_cataloging_agency_key = 'not_040a';
		}
	}
	$self->{'struct'}->{'stats'}->{'original_cataloging_agency'}->{$original_cataloging_agency_key}++;

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'original_cataloging_agency'} = {};

	return;
}

1;

__END__
