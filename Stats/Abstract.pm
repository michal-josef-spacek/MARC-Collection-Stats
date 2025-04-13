package MARC::Collection::Stats::Abstract;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Structure.
	$self->{'struct'} = {};

	# Process parameters.
	set_params($self, @params);

	# Initialize structure.
	$self->init;

	return $self;
}

# Initialization.
sub init {
	my $self = shift;

	# Common initialization.
	$self->{'struct'}->{'name'} = $self->name;

	# Plugin initialization.
	$self->_init;

	return;
}

# Name of plugin.
sub name {
	my $self = shift;

	err __PACKAGE__.' is abstract class,';
}

# Process statistics.
sub process {
	my ($self, $record) = @_;

	err __PACKAGE__.' is abstract class.';
}

sub struct {
	my $self = shift;

	return $self->{'struct'};
}

sub _init {
	my $self = shift;

	err __PACKAGE__.' is abstract class.';
}

1;

__END__
