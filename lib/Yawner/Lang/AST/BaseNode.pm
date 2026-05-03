package Yawner::Lang::AST::BaseNode;
use strict;
use warnings;
use overload '""' => \&to_string;

sub new {
    my ($class, $line, $char) = @_;

    return bless {
        name => $class,
        line => $line,
        char => $char
    }, $class;
}

sub name {
    return (shift)->{name};
}

sub line {
    return (shift)->{line};
}

sub char {
    return (shift)->{char};
}

sub to_string {
    my $self = shift;
    return '[' . $self->name . ']';
}

1;
