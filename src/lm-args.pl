#!/usr/bin/perl -w

use strict;

my $train = $ARGV[0] || die("missing training file");
my $test = $ARGV[1] || die("missing test file");
my $vocthr = $ARGV[2] || 2; 
my @discounts = qw(ndiscount wbdiscount ukndiscount kndiscount); 
my @options = qw(interpolate no);
my @order = qw(4 5);

for my $d (@discounts) {
  for my $o (@options) {
    for my $n (@order) {
      print "$train\t$test\t$vocthr\t$n\t$d\t$o\n";
    }
  }
}
