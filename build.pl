#!/usr/bin/env perl

use v5.42.0;
use strict;
use warnings;
use utf8;

mkdir 'bin' unless -d 'bin';
print `pp -o bin/yawner -I src src/yawner.pl`;
say 'Done';
