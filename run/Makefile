## ### GENERAL setup:
SEED=1 # Random seed
NCPU=10 # Number of threads/processes to use for parallel computations
SRILM_PATH=/opt/srilm/bin/i686-m64
export PATH := ../../src:.:${SRILM_PATH}:${PATH} # Binaries in the bin directory

## LM Experiments
NARGS=6
NCPU=1

ppl.out: train.tok.gz test.tok.gz vocab.gz unknown.out
	lm-args.pl train.tok.gz test.tok.gz ${LM_VOC} | xargs -n${NARGS} -P${NCPU} lm-run.pl > $@  	

vocab.gz: train.tok.gz ## LM_VOCAB=2: time=1m16s, wc=78498   78498  672284
	zcat $< | ngram-count -write-order 1 -text - -write - | \
	perl -lane 'print $$F[0] if $$F[1] >= ${LM_VOC}' | gzip > $@

unknown.out: vocab.gz test.tok.gz 
	unknown.pl $< test.tok.gz > $@

clean:
	rm -rf lm*_*_* ppl.out unknown.out 
