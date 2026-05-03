package Yawner::Lang::AST::BaseNode;
use strict;
use warnings;

sub new {
    my ($class) = @_;

    return bless {
        name => $class
    }, $class;
}

sub name {
    return (shift)->{name};
}

1;
