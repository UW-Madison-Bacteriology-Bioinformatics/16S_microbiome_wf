---
layout: default
title: Step-by-step instructions
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

## Before starting

You will first need access to a `/staging/netid` folder. For more information about /staging folders, please visit: https://chtc.cs.wisc.edu/uw-research-computing/file-avail-largedata . The /staging folder will be used for the large genomic input files, and the large genomic output files.

In your request, please consider your input files (how many samples will you have, have the size of all your reads and assembled data, as well as your output files).

📂 **Input files needed**

**Demultiplied or not?**

1. You will need **paired-end reads** (Illumina) corresponding to the 16S rRNA gene amplicons.

**1.1. Already demultiplexed:**

Most of the time, sequencing centers will give you this data already **demultiplexed**, meaning that you will get 2 files per samples, labelled like this: `{sample}_R1_001.fastq.gz` and `{sample}_R2_001.fastq.gz`.

Organize them like this:
 ```
 seqs/{sample}_R1_001.fastq.gz
 seqs/{sample}_R2_001.fastq.gz
 etc.
 ```


