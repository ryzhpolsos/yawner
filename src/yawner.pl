use v5.42.0;
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin;

use Yawner::Lang::Tokenizer;

my $source_code;

do {
    local $/ = undef;
    open(my $fh, '<', $ARGV[0]) or die "Failed to open $ARGV[0]: $!";
    $source_code = readline $fh;
    close($fh);
};

tokenize $source_code;
