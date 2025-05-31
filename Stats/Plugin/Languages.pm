package MARC::Collection::Stats::Plugin::Languages;

use base qw(MARC::Collection::Stats::Abstract);
use strict;
use warnings;

use List::Util 1.33 qw(none);

our $VERSION = 0.01;

sub name {
	my $self = shift;

	return 'languages';
}

sub process {
	my ($self, $marc_record) = @_;

	my @keys;

	my @langs;
	my @fields = $marc_record->field('041');
	foreach my $field (@fields) {
		my @field_langs = $field->subfield('a');
		foreach my $field_lang (@field_langs) {
			if (none { $field_lang eq $_ } @langs) {
				push @langs, $field_lang;
			}
		}
	}

	foreach my $lang (@langs) {
		$self->{'struct'}->{'stats'}->{'languages_single'}->{$lang}++;
	}

	if (@langs > 1) {
		my $multi = join '/', sort @langs;
		$self->{'struct'}->{'stats'}->{'languages_multi'}->{$multi}++;
	}

	return;
}

sub _init {
	my $self = shift;

	$self->{'struct'}->{'module_name'} = __PACKAGE__;
	$self->{'struct'}->{'module_version'} = $VERSION;

	$self->{'struct'}->{'stats'}->{'languages_single'} = {};
	$self->{'struct'}->{'stats'}->{'languages_multi'} = {};

	return;
}

1;

__END__
