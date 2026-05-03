package Yawner::Lang::AST::VariableDefinitionNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $var, $value) = @_;

    my $self = $class->SUPER::new();
    $self->{var} = $var;
    $self->{value} = $value;
    return $self;
}

sub var {
    return (shift)->{var};
}

sub value {
    return (shift)->{value};
}
