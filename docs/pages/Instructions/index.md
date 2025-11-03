---
layout: default
title: Instructions
nav_order: 2
---

# Workflow
## Description of files in this repository:

* `README.md`: These directions
* `docs/`: Contains files for visualization of documentation on the website
* `scripts/`: Contains all `.sh`/`.sub` files required for the pipeline.
  * `00_mkdir.sh`: Script to create directory in staging that will store outputs of jobs
  * `make_dag.sh`: DAGman configuration file
  * `00-08`: Executable and submit scripts pairs for HTCondor DAGman jobs
* `.gitignore`: all files to be ignored

## Quick Overview of Workflow

1. **Prepare inputs** — upload all required files (`seqs/`, `sample-metadata.tsv`, and `fastq-manifest.txt`) to your `/staging/username/project/00_pipeline_inputs` directory.  
2. **Run scripts** — execute the provided `.sh` and `.sub` files in order or through the DAGMan workflow.  
3. **Monitor progress** — use `condor_q` to check running jobs and inspect `.out` and `.err` logs.  
4. **Review outputs** — visualize `.qzv` files using [QIIME2 View](https://view.qiime2.org/) and confirm expected results in each numbered output folder.