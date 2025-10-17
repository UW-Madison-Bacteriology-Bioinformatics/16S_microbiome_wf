#!/bin/bash
#To run script, simply type bash 00_mkdir.sh into the terminal


# arguments
NETID="$1"
project="$2"

staging="/staging/${NETID}"

echo $staging
echo $project

mkdir -p $staging/$project/
mkdir -p $staging/$project/00_pipeline_inputs/
mkdir -p $staging/$project/00_pipeline_inputs/seqs
mkdir -p $staging/$project/01_import-demux/
mkdir -p $staging/$project/02_dada2_qc/
mkdir -p $staging/$project/03_features/
mkdir -p $staging/$project/04_phytree/
mkdir -p $staging/$project/05_abdiv/
mkdir -p $staging/$project/06_rarefact/
mkdir -p $staging/$project/07_taxonomy/
mkdir -p $staging/$project/08_ancombc/

echo "Created folder structure for 16S rRNA pipeline at $staging/$project"
