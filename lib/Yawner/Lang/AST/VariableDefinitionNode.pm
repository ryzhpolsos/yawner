package Yawner::Lang::AST::VariableDefinitionNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $line, $char, $var, $value) = @_;

    my $self = $class->SUPER::new($line, $char);
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

sub add_arg {
    my ($self, $value) = @_;
    $self->{value} = $value;
}

sub to_string {
    my $self = shift;
    return $self->SUPER::to_string . ', var: ' . $self->var . ', value: ' . (defined $self->value?$self->value->to_string:'');
}

1;
