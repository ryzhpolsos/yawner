package Yawner::Lang::Tokenizer;

use v5.42.0;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(tokenize print_token);

use Yawner::Lang::Token;

my %State = (
    None        => 0,
    Comment     => 1,
    Expr        => 2,
    String      => 3,
    RawString   => 4,
    Escape      => 5,
    Comment     => 6,
);

my %SpecialChar = (
    LParen      => '(',
    RParen      => ')',
    Comma       => ',',
    Equals      => '=',
    String      => '"',
    RawString   => '\'',
    Escape      => '\\',
    Comment     => '#',
    NewLine     => "\n"
);

my $is_ident_regex = qr(^[\w\$]+$);
my $is_number_regex = qr(^\d+$);

sub is_ident {
    shift =~ $is_ident_regex;
}

sub is_number {
    shift =~ $is_number_regex;
}

sub print_token {
    my $token = shift;
    my ($type) = grep { $TokenType{$_} == $token->type } (keys %TokenType);
    my $value = $token->value;
    say "[$type] '$value'";
}

sub tokenize {
    my $code = shift;
    $code =~ s/\r\n/\n/g;
    $code =~ s/\r/\n/g;

    my @tokens;
    my $state = $State{None};
    my $old_state = $state;

    my $buffer = '';

    my $line = 1;
    my $char = 0;

    my sub set_state {
        $old_state = $state;
        $state = $State{shift()};
    }

    for(my $i = 0; $i < length($code); $i++){
        my $ch = substr($code, $i, 1);

        $char++;
        if($ch eq $SpecialChar{NewLine}){
            $line++;
            $char = 0;
        }

        if($state == $State{Comment}){
            if($ch eq $SpecialChar{NewLine}){
                set_state 'None';
            }

            next;
        }elsif($ch eq $SpecialChar{Escape}){
            set_state 'Escape';
            next;
        }

        if($state != $State{String} && $state != $State{RawString}){
            if($ch eq $SpecialChar{Comment}){
                set_state 'Comment';
            }else{
                for(qw(LParen RParen Comma Equals)){
                    if($ch eq $SpecialChar{$_}){
                        push @tokens, Yawner::Lang::Token->new($TokenType{$_}, '', $line, $char);
                        last;
                    }
                }            
            }
        }

        if($state == $State{Escape}){
            set_state $old_state;
            $buffer .= $ch;
        }elsif($state == $State{None}){
            if(is_ident $ch){
                set_state 'Expr';
                $buffer .= $ch;
            }elsif($ch eq $SpecialChar{String}){
                set_state 'String';
            }elsif($ch eq $SpecialChar{RawString}){
                set_state 'RawString';
            }
        }elsif($state == $State{Expr}){
            if(is_ident $ch){
                $buffer .= $ch;
            }else{
                set_state 'None';
                push @tokens, Yawner::Lang::Token->new($TokenType{Ident}, $buffer, $line, $char);
                $buffer = '';
            }
        }elsif($state == $State{String}){
            if($ch eq $SpecialChar{String}){
                set_state 'None';
                push @tokens, Yawner::Lang::Token->new($TokenType{String}, $buffer, $line, $char);
                $buffer = '';
            }else{
                $buffer .= $ch;
            }
        }elsif($state == $State{RawString}){
            if($ch eq $SpecialChar{RawString}){
                set_state 'None';
                push @tokens, Yawner::Lang::Token->new($TokenType{RawString}, $buffer, $line, $char);
                $buffer = '';
            }else{
                $buffer .= $ch;
            }
        }
        
        if($ch eq $SpecialChar{NewLine}){
            push @tokens, Yawner::Lang::Token->new($TokenType{NewLine}, '', $line, $char);
        }
    }
    # my $tok = Yawner::Lang::Token->new(TokenType::, 'Token', $line, $char);

    return @tokens;
}

1;
