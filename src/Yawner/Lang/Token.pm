package Yawner::Lang::Token;

use v5.42.0;
use strict;
use warnings;

sub new {
    my ($class, $type, $value) = @_;

    bless {
        type => $type,
        value => $value
    }, $class;
}

sub type {
    return (shift)->{type};
}

sub value {
    return (shift)->{value};
}
