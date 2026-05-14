package Yawner::Lang::AST::IFNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $line, $char, $condition) = @_;

    my $self = $class->SUPER::new($line, $char);
    $self->{condition} = $condition;
    $self->{true_nodes} = [];
    $self->{false_nodes} = [];
    return $self;
}

sub condition {
    return (shift)->{condition};
}

sub to_string {
    my $self = shift;
    return $self->SUPER::to_string . ', condition: ' . $self->condition;
}

sub add_true_node {
    my ($self, $type, $value) = @_;
    push @{$self->{true_nodes}}, $value;
}

sub add_false_node {
    my ($self, $type, $value) = @_;
    push @{$self->{false_nodes}}, $value;
}

sub set_condition {
    my ($self, $condition) = @_;
    $self->{condition} = $condition;
}

1;
