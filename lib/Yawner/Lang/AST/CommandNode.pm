package Yawner::Lang::AST::CommandNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $line, $char) = @_;

    my $self = $class->SUPER::new($line, $char);
    $self->{cmd} = '';
    $self->{args} = [];
    return $self;
}

sub cmd {
    return (shift)->{cmd};
}

sub args {
    return (shift)->{args};
}

sub add_node {
    my ($self, $node) = @_;

    if(!$self->{cmd}){
        $self->{cmd} = $node;
    }else{
        push @{$self->{args}}, $node;
    }
}

sub to_string {
    my $self = shift;
    return $self->SUPER::to_string . ', cmd: ' . $self->cmd;
}

1;
