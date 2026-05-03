package Yawner::Lang::Token;

use v5.42.0;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(%TokenType);

our %TokenType = (
    None        => 0,
    Ident       => 1,
    LParen      => 2,
    RParen      => 3,
    Comma       => 4,
    Equals      => 5,
    String      => 6,
    RawString   => 7,
    NewLine     => 8,
);

sub new {
    my ($class, $type, $value, $line, $char) = @_;

    return bless {
        type => $type,
        value => $value,
        line => $line,
        char => $char
    }, $class;
}

sub type {
    return (shift)->{type};
}

sub value {
    return (shift)->{value};
}

sub line {
    return (shift)->{line};
}

sub char {
    return (shift)->{char};
}

1;
