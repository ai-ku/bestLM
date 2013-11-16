#!/usr/bin/perl -w

use strict;

my $usage = q{Usage: lm-run.pl train test vocthr ngram discount option};
my $train = shift or die ("missing train => $usage");
my $test = shift or die $usage;
my $vocthr = shift or die $usage;
my $ngram = shift or die $usage;
my $discount = shift or die $usage;
my $option = shift or die $usage;
my $runDir = "lm_".$discount."_".$ngram."_".$option."_".$vocthr;
my $optionFL = $option eq "no" ? "" : "-$option";
my $vocFile = "vocab.gz";
my $LM = "$runDir/train.gz";
my $PPL = "$runDir/ppl.gz";
system("rm -rf $runDir") if ( -d $runDir );
system("mkdir $runDir");
my $tm = time;
my $trainLM = "zcat $train | ngram-count -$discount -order $ngram $optionFL" . 
              " -unk -vocab $vocFile -text - -lm $LM 2> $runDir/lm.err"; 
my $ppl = "zcat $test | ngram -order $ngram -unk -lm $LM -ppl - 2> $runDir/ppl.err | gzip > $PPL";
$tm = time - $tm;
system($trainLM);
system($ppl);
my @res = split(' ', `zcat $PPL | grep logprob`);
print "$train $test $vocthr $ngram $discount $option $res[3] $res[5] $res[7] $tm\n";
