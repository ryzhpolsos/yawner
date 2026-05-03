use v5.42.0;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Data::Dumper;

use Yawner::Lang::Tokenizer;
use Yawner::Lang::Parser;
use Yawner::Compiler::Shell;
use Yawner::Compiler::Batch;

my $source_code;

do {
    local $/ = undef;
    open(my $fh, '<', $ARGV[0]) or die "Failed to open $ARGV[0]: $!";
    $source_code = readline $fh;
    close($fh);
};

say '=== SOURCE ===';
print $source_code;
say '';
say '=== TOKENIZED ===';

my @tokens = tokenize $source_code;
print_token $_ foreach @tokens;

say '';
say '=== AST ===';

my @ast = build_ast @tokens;
say Dumper \@ast;

say '';
say '=== RESULT 1 ===';
say Yawner::Compiler::Shell::compile @ast;

say '';
say '=== RESULT 2 ===';
say Yawner::Compiler::Batch::compile @ast;
