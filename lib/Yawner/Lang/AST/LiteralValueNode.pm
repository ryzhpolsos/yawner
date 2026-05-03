package Yawner::Lang::AST::LiteralValueNode;
use strict;
use warnings;
use parent qw(Yawner::Lang::AST::BaseNode);

sub new {
    my ($class, $value) = @_;

    my $self = $class->SUPER::new();
    $self->{value} = $value;
    return $self;
}

sub value {
    return (shift)->{value};
}

1;
