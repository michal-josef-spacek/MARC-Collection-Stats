package MARC::Collection::Stats::Abstract;

use strict;
use warnings;

use Class::Utils qw(set_params);
use DateTime;
use Error::Pure qw(err);
use Mo::utils 0.06 qw(check_bool);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Debug mode.
	$self->{'debug'} = 0;

	# Structure.
	$self->{'struct'} = {};

	# Verbose mode.
	$self->{'verbose'} = 0;

	# Process parameters.
	set_params($self, @params);

	# Check 'verbose'.
	check_bool($self, 'verbose');

	# Initialize structure.
	$self->init;

	return $self;
}

# Initialization.
sub init {
	my $self = shift;

	# Common initialization.
	$self->{'struct'}->{'name'} = $self->name;
	$self->{'struct'}->{'datetime'} = DateTime->now->iso8601;

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
	my ($self, $marc_record) = @_;

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
