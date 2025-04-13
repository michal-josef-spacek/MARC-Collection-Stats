package MARC::Collection::Stats::Plugin::Count;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'count';
}

sub process {
	my ($self, $marc_record) = @_;

	$self->{'struct'}->{'stats'}->{'count'}++;

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'count'} = 0;

	return;
}

1;

__END__
