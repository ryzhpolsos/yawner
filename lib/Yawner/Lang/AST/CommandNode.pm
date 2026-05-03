package Yawner::Lang::AST::CommandNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $line, $char, $cmd, @args) = @_;

    my $self = $class->SUPER::new($line, $char);
    $self->{cmd} = $cmd;
    $self->{args} = \@args;
    return $self;
}

sub cmd {
    return (shift)->{cmd};
}

sub args {
    return (shift)->{args};
}

sub add_arg {
    push @{(shift)->{args}}, shift;
}

sub to_string {
    my $self = shift;
    return $self->SUPER::to_string . ', cmd: ' . $self->cmd;
}

1;
