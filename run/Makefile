## ### GENERAL setup:
SEED=1 # Random seed
NCPU=10 # Number of threads/processes to use for parallel computations
SRILM_PATH=/opt/srilm/bin/i686-m64
export PATH := ../../src:.:${SRILM_PATH}:${PATH} # Binaries in the bin directory

## LM Experiments
NARGS=6
NCPU=1

ppl.out: train.tok.gz test.tok.gz
	lm-args.pl train.tok.gz test.tok.gz ${LM_VOC} | xargs -n${NARGS} -P${NCPU} lm-run.pl > $@  	

clean:
	rm -rf lm*_*_* ppl.out
