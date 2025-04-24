package MARC::Collection::Stats::Plugin::Multiplicity;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'multiplicity';
}

sub process {
	my ($self, $marc_record) = @_;

	# TODO More fields.
	foreach my $field_num (260, 264) {
		my @fields = $marc_record->field($field_num);
		if (@fields) {
			my $fields_count = @fields;
			my $key = $field_num.'x'.$fields_count;
			$self->{'struct'}->{'stats'}->{'multiplicity'}->{$key}++;
		}
	}

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'multiplicity'} = {};

	return;
}

1;

__END__
