---
author: Colin Gross
---

# Nextflow Dustbusting

Nextflow has clutter reducing options as well.

- scratch directory
- process outputs

## Process Outputs

```txt
process select_sample {
   input:
   val(bcf_entry)

   output:
   tuple val(sv_id), val(sample_id)

   script:
   def sv_id = parse_sv_id( bcf_entry )
   def sample_id = select_samples( bcf_entry, 1)
}

workflow {
  sv_bcf = channel.fromPath('structvars.bcf')

  bcf_entries = read_bcf( sv_bcf )
  sv_singles = select_samples( bcf_entries )
}
```

## Scratch Space
```
process messy_chops {
  scratch true

  input:
  path(bcf)
  path(cram_dir)

  output:
  path("depths.tsv")

  script:
  """
  ${bins}/chop_up_bcf $bcf
  ${bins}/subset_crams $cram_dir *.chopped.tsv
  ${bins}/make_pileups *.cram
  ${bins}/aggregate_depths *.pileup > depths.tsv
  """
}
```
