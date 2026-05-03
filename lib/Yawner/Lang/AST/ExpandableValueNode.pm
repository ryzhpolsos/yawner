package Yawner::Lang::AST::ExpandableValueNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $line, $char, $value) = @_;

    my $self = $class->SUPER::new($line, $char);
    $self->{value} = $value;
    return $self;
}

sub value {
    return (shift)->{value};
}

sub to_string {
    my $self = shift;
    return $self->SUPER::to_string . ', value: ' . $self->value;
}

1;
