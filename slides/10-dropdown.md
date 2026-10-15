---
author: Colin Gross
---

# File Clutter

Processing data in chunks can leave many little files.

## Quantity of Chunks
E.g. in [coverage aggregation](https://github.com/statgen/bravo_data_prep/blob/sv_loc/workflows/coverage/templates/mlr_agg.sh)

* 500 samples
* 23 chromosome files per sample
* 50 - 250 chunks per chromosome

2,980,000 intermediate files

## Intermediate Files
Process depth files 1M bp at a time.
```txt
NWD001.depth.gz NWD002.depth.gz NWD003.depth.gz
```

```txt
tabix NWD001.depth.gz "chr1:1-1000000" > 1_1-1000000.tsv
tabix NWD002.depth.gz "chr1:1-1000000" > 2_1-1000000.tsv
tabix NWD003.depth.gz "chr1:1-1000000" > 3_1-1000000.tsv

aggregate.sh 1_1-1000000.tsv 2_1-1000000.tsv 3_1-1000000.tsv
```

## Named Pipe Instead of Files
```txt
mkfifo pipe1 pipe2 pipe3

tabix NWD001.depth.gz "chr1:1-100000" > pipe1 &
tabix NWD002.depth.gz "chr1:1-100000" > pipe2 &
tabix NWD003.depth.gz "chr1:1-100000" > pipe3 &

aggregate.sh pipe1 pipe2 pipe3
```

## Current Use in Data Prep
```txt
PIPES=()
PIPE_COUNT=0

for INFILE in ${INFILES[@]}
do
  PIPE_NAME=pipe_${PIPE_COUNT}
  mkfifo ${PIPE_NAME}
  PIPES+=( ${PIPE_NAME} )

  # Start reading depth file into pipe
  (tabix ${INFILE} ${chromosome}:${POS}-${END} > ${PIPE_NAME}) &

  let "PIPE_COUNT = PIPE_COUNT + 1"
done
```
