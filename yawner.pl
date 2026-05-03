use v5.42.0;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Data::Dumper;
use Getopt::Long;

use Yawner::Lang::Tokenizer;
use Yawner::Lang::Parser;
use Yawner::Compiler::Shell;
use Yawner::Compiler::Batch;

my $format = '<unknown>';
my $input;
my $output;
my $debug;
GetOptions(
    'format=s' => \$format,
    'input=s' => \$input,
    'output=s' => \$output,
    'debug' => \$debug
);

my $source_code;

do {
    local $/ = undef;
    
    if($input){
        open(my $fh, '<', $input) or die "Failed to open $input: $!";
        $source_code = readline $fh;
        close $fh;
    }else{
        $source_code = readline STDIN;
    }
};

if($debug){
    say '=== SOURCE ===';
    print $source_code;
    say '';
    say '=== TOKENIZED ===';
}

my @tokens = tokenize $source_code;

if($debug){
    print_token $_ foreach @tokens;
}

if($debug){
    say '';
    say '=== AST ===';
}

my @ast = build_ast @tokens;
print_ast \@ast if $debug;

if($debug){
    say '';
    say '=== RESULT 1 ===';
    say Yawner::Compiler::Shell::compile @ast;

    say '';
    say '=== RESULT 2 ===';
    say Yawner::Compiler::Batch::compile @ast;
}

my $result;

if($format eq '<unknown>' && $output){
    $format = (split /\./, $output)[-1];
}

if($format eq 'bat'){
    $result = Yawner::Compiler::Batch::compile @ast;
}elsif($format eq 'sh'){
    $result = Yawner::Compiler::Shell::compile @ast;
}else{
    die "Invalid format: $format";
}

my $out_file;

if($output){
    open($out_file, '>', $output) or die "Failed to open $input: $!";
}else{
    $out_file = \*STDOUT;
}

print $out_file $result;
close $out_file;
