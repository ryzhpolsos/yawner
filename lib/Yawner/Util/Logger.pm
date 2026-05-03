package Yawner::Util::Logger;

use strict;
use warnings;

sub new {
    my ($class, $name) = @_;

    return bless {
        name => $name
    }, $class;
}

sub log {
    my ($self, $prefix, $message, $fh) = @_;
    print $fh "[$self->{name}] $prefix: $message\n"
}

sub info {
    my ($self, $message) = @_;
    $self->log('INFO', $message, \*STDOUT);
}

sub warn {
    my ($self, $message) = @_;
    $self->log('WARNING', $message, \*STDERR);
}

sub error {
    my ($self, $message) = @_;
    $self->log('ERROR', $message, \*STDERR);
}

1;
