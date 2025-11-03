#!/bin/bash
#To run script, simply type bash 00_mkdir.sh into the terminal

if [ "$#" -lt 2 ]; then
  echo "Usage: bash 00_mkdir.sh NETID PROJECT" >&2
  echo "Error: Not enough arguments provided. Provide your netID as the 1st argument, and your project name as the 2nd argument" >&2
  exit 1
fi

# arguments
NETID="$1"
project="$2"

echo "NetID is: ${NETID}"
echo "Project name is: ${project}"

staging="/staging/${NETID}"

echo "Folder will be created at: $staging/$project"

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
echo "Completed"
