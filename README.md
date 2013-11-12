bestLM
======

Run SRILM with different options to find best language model(LM) given the training and test data.

Directory Structure:
  src/  Scripts
  run/  Experiment Folder
    /demo Sample experiment

How to run?

* Set SRILM path in +run/Makefile+
* Copy your LM training file and name it as train.tok.gz 
* Copy your test file and name it as test.tok.gz (this file is used to calculate perplexity)
* Edit the vocabulary threshold according to your needs  
* run cd run/demo && make ppl.out
* To run on 10 CPU
  run cd run/demo && make ppl.out NCPU=10  
* Each line of ppl.out will corresponds to an LM and its perplexity
  ppl.out format:
  training-set test-set vocabulary-thr ngram discount option prob ppl ppl2 time
* Each LM has its own folder in the experiment folder (i.e., run/demo/). 
* In order to run experiments on different datasets create a folder under run and
  copy the Makefile in demo to this new directory and perform the above steps

Supported SRILM options:
* An experiment will run the following discountings:
  ndiscount wbdiscount ukndiscount kndiscount
* All discountings will be run with/without interpolation
* All experiments will run for 4 and 5 grams
* If you want to edit these settings please edit the src/lm-args.pl
