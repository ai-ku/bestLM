 ### GENERAL setup:
NCPU=10 # Number of threads/processes to use for parallel computations
SRILM_PATH=/opt/srilm/bin/i686-m64
export PATH := ../../src:.:${SRILM_PATH}:${PATH} # Binaries in the bin directory

## LM Experiments
NARGS=6

all: ppl.out

train.tok.gz:
	test -e train.tok.gz || echo "Please copy train.tok.gz in to this folder"
	test -e test.tok.gz || echo "Please copy test.tok.gz in to this folder"

ppl.out: train.tok.gz test.tok.gz
	lm-args.pl train.tok.gz test.tok.gz ${LM_VOC} | xargs -n${NARGS} -P${NCPU} lm-run.pl > $@  	

clean:
	rm -rf lm*_*_* ppl.out
