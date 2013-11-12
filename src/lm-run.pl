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
my $vocFile = "$runDir/vocab.gz";
my $LM = "$runDir/train.gz";
my $PPL = "$runDir/ppl.gz";
system("rm -rf $runDir") if ( -d $runDir );
system("mkdir $runDir");
my $tm = time;
my $getVoc = "zcat $train | ngram-count -write-order 1 -text - -write - |" .
              "perl -lane \'print \$F[0] if \$F[1] >= $vocthr \' 2> $runDir/voc.err |".
              "gzip > $vocFile";
my $trainLM = "zcat $train | ngram-count -$discount -order $ngram $optionFL" . 
              " -unk -vocab $vocFile -text - -lm $LM 2> $runDir/lm.err"; 
my $ppl = "zcat $test | ngram -order $ngram -unk -lm $LM -ppl - 2> $runDir/ppl.err | gzip > $PPL";
$tm = time - $tm;
system($getVoc);
system($trainLM);
system($ppl);
my @res = split(' ', `zcat $PPL | grep logprob`);
print "$train $test $vocthr $ngram $discount $option $res[3] $res[5] $res[7] $tm\n";
