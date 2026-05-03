package Yawner::Lang::Parser;

use v5.42.0;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(build_ast print_ast);

use Yawner::Lang::Token;

use Yawner::Lang::AST::CommandNode;
use Yawner::Lang::AST::LiteralValueNode;
use Yawner::Lang::AST::ExpandableValueNode;
use Yawner::Lang::AST::VariableDefinitionNode;

sub build_ast {
    my @tokens = @_;
    my @nodes;
    my @stack;

    my $need_cmd_name = 1;
    my $need_push_nodes = 1; 
    my $is_var = 0;
    my $is_subcmd = 0;

    my sub last_node {
        return $stack[@stack - 1];
    }

    for(my $i = 0; $i < @tokens; $i++){
        my $token = $tokens[$i];
        my $next_token = $i == @tokens - 1 ? Yawner::Lang::Token->new($TokenType{None}, '') : $tokens[$i + 1];

        if($token->type == $TokenType{Ident}){
            if($need_cmd_name){
                if($next_token->type == $TokenType{Equals}){
                    push @stack, Yawner::Lang::AST::VariableDefinitionNode->new($token->line, $token->char, $token->value);
                    push @nodes, last_node if $need_push_nodes;
                    $is_var = 1;
                    $need_cmd_name = 1;
                }else{
                    push @stack, Yawner::Lang::AST::CommandNode->new($token->line, $token->char, $token->value);
                    push @nodes, last_node if $need_push_nodes;
                    $need_cmd_name = 0;
                }

                $need_push_nodes = 0;
            }else{
                (last_node)->add_arg(Yawner::Lang::AST::ExpandableValueNode->new($token->line, $token->char, $token->value));
            }
        }elsif($token->type == $TokenType{String}){
            (last_node)->add_arg(Yawner::Lang::AST::ExpandableValueNode->new($token->line, $token->char, $token->value));
        }elsif($token->type == $TokenType{RawString}){
            (last_node)->add_arg(Yawner::Lang::AST::LiteralValueNode->new($token->line, $token->char, $token->value));
        }elsif(!$is_subcmd && $token->type == $TokenType{NewLine}){
            $need_cmd_name = 1;
            $need_push_nodes = 1;

            if($is_var){
                my $last_node = pop @stack;
                (last_node)->add_arg($last_node) if defined (last_node) && (last_node)->can('add_arg');
            }
        }elsif($token->type == $TokenType{LParen}){
            $need_cmd_name = 1;
            $is_subcmd = 1;
        }elsif($token->type == $TokenType{RParen}){
            $need_cmd_name = 0;
            $is_subcmd = 0;
            my $last_node = pop @stack;
            (last_node)->add_arg($last_node);
        }
    }

    return @nodes;
}

sub print_ast {
    my ($ast, $tab_amount) = @_;

    $tab_amount = 0 unless defined $tab_amount;

    foreach my $node (@$ast){
        say(' ' x ($tab_amount * 4) . $node->to_string); 

        if($node->name eq 'Yawner::Lang::AST::CommandNode'){
            foreach(@{$node->args}){
                print_ast([$_], $tab_amount + 1);
            }
        }
    }
}

1;
