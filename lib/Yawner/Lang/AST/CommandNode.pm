package Yawner::Lang::AST::CommandNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $cmd, @args) = @_;

    my $self = $class->SUPER::new();
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

1;
