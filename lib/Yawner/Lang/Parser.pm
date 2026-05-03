package Yawner::Lang::Parser;

use v5.42.0;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(build_ast);

use Yawner::Lang::Token;

use Yawner::Lang::AST::CommandNode;
use Yawner::Lang::AST::LiteralValueNode;
use Yawner::Lang::AST::ExpandableValueNode;

sub build_ast {
    my @tokens = @_;
    my @nodes;
    my @stack;

    my $need_cmd_name = 1;

    my sub last_node {
        return $stack[@stack - 1];
    }

    for(my $i = 0; $i < @tokens; $i++){
        my $token = $tokens[$i];
        my $next_token = $i == @tokens - 1 ? Yawner::Lang::Token->new($TokenType{None}, '') : $tokens[$i + 1];

        if($token->type == $TokenType{Ident}){
            if($need_cmd_name){
                push @stack, Yawner::Lang::AST::CommandNode->new($token->value);
                push @nodes, last_node;
                $need_cmd_name = 0;
            }else{
                (last_node)->add_arg(Yawner::Lang::AST::LiteralValueNode->new($token->value));
            }
        }elsif($token->type == $TokenType{String}){
            (last_node)->add_arg(Yawner::Lang::AST::ExpandableValueNode->new($token->value));
        }elsif($token->type == $TokenType{RawString}){
            (last_node)->add_arg(Yawner::Lang::AST::LiteralValueNode->new($token->value));
        }elsif($token->type == $TokenType{NewLine}){
            $need_cmd_name = 1;
        }
    }

    return @nodes;
}

1;
