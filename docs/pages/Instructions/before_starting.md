---
layout: default
title: Before starting
parent: Instructions
nav_order: 1
---

## Before starting

**CHTC account setup**

There are 2 ways to run this workflow, and it depends on your data input file size. 
The home folder has a smaller disk size limit, but unlimited files count, and comes automatically when you create an account.
The staging folder needs to be manually requested by filling in a form, but works well if you have large files (~100MB each), but it does come with a file count number limit. Additionally, if you run out of space, you need to manually requested more disk/file limit.

For this reason, we have 2 versions of this `16S_wf`. 

**1. Version main**:

You will first need access to a `/staging/netid` folder. For more information about `/staging` folders, please visit: https://chtc.cs.wisc.edu/uw-research-computing/file-avail-largedata . The `/staging` folder will be used for the large genomic input files, and the large genomic output files.

In your request, please consider your input files (how many samples will you have, have the size of all your reads and assembled data, as well as your output files).

**2. Version home**
You will need access to `/home/netid`. Check your quota by typing `get_quotas` once logged in to view how much space/files you have remaining. Make sure it has enough disk space for your input files, and estimate enough space for your output files.

**Demultiplexed or not?**

You will need **paired-end reads** (Illumina) corresponding to the 16S rRNA gene amplicons.

- Already demultiplexed:

Most of the time, sequencing centers will give you this data already **demultiplexed**, meaning that you will get 2 files per samples. Then make a `fastq-manifest.txt` file as shown below to match all input sequncing file names.


- Not already demultiplexed:

If the data is not already demultiplexed, you should find a forward reads fastq file, a reverse reads fastq file, and a file with barcodes associated with each sample. 

Organize your files like this:
```
seqs/
seqs/forward.fastq.gz
seqs/reverse.fastq.gz
seqs/barcodes.fastq.gz
```

If you just have fastq files, you can "zip" them into the gz file format by typing:
```
gzip forward.fastq
```

**Sample information**

You will need a **tab-separated table** named exactly `sample-metadata.tsv`, (tsv = tab separated values). The file should contain information about the samples, such as sample characteristics. A TSV file is a text file that can be opened with any regular text editor or spreasheet program. The column names for the sample characteristics should not container any special characters, including dashes. For example, if you have a column named `transect-sites` rename it as `transectSite` (or something without dashes), and save the file again.

**Manifest file**

You will need a **tab-separated text file** named exactly `fastq-manifest.txt` for paired-end data (i.e. already demultiplexed data).  This file tells QIIME 2 where each of your FASTQ sequencing files is located.  
The manifest must include the sample IDs and the **absolute file paths** to your FASTQ files stored under `/staging/username/project/00_pipeline_inputs/seqs/`. This file should include three columns: `sample-id `, `forward-absolute-filepath`, and `reverse-absolute-filepath`.

Each row should correspond to one sample, followed by the full path(s) to its FASTQ files.  
In this workflow, you can use **environment variables** (`${NETID}` and `${PROJECT}`) in the file paths, which will be automatically replaced by the pipeline during job submission. For example:
```
sample-id	forward-absolute-filepath	reverse-absolute-filepath
BAQ1370.1.2	/staging/${NETID}/${PROJECT}/00_pipeline_inputs/seqs/BAQ1370.1.2_75_L001_R1_001.fastq.gz	/staging/${NETID}/${PROJECT}/00_pipeline_inputs/seqs/BAQ1370.1.2_75_L001_R2_001.fastq.gz
```


{: .note }
> For your reference, [here](https://drive.google.com/drive/folders/1qCO_ztaghJvXEnkwRji8tGCH98csbijj?usp=sharing) is an example of what the input folder should look like.
