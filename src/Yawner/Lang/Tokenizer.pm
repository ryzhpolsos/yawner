package Yawner::Lang::Tokenizer;

use v5.42.0;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(tokenize);

use Yawner::Lang::Token;

use enum qw(
    Token_Ident
    Token_LParen
    Token_RParen
    Token_Comma
    Token_Equals
    Token_String
    Token_RawString
);

my %SpecialCharacters = (
    LParen => '(',
    RParen => ')',
    Comma => ',',
    Equals => '=',
    String => '"',
    RawString => '\''
);

sub tokenize {
    my $code = shift;

    for(my $i = 0; $i < length($code); $i++){
        say substr($code, $i, 1);
    }
    # my $tok = Yawner::Lang::Token->new(TokenType::, 'Token');
}

1;
