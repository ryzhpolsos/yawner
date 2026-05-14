package Yawner::Lang::AST::RootNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $line, $char) = @_;

    my $self = $class->SUPER::new($line, $char);
    $self->{nodes} = [];
    return $self;
}

sub add_node {
    my ($self, $node) = @_;
    push @{$self->{nodes}}, $node;
}

sub get_nodes {
    my $self = shift;
    return @{$self->{nodes}};
}

1;
