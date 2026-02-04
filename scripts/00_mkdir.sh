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

home="/home/${NETID}"

echo "Folder will be created at: $home/$project"

mkdir -p $home/$project/
mkdir -p $home/$project/00_pipeline_inputs/
mkdir -p $home/$project/00_pipeline_inputs/seqs
mkdir -p $home/$project/01_import-demux/
mkdir -p $home/$project/02_dada2_qc/
mkdir -p $home/$project/03_features/
mkdir -p $home/$project/04_phytree/
mkdir -p $home/$project/05_abdiv/
mkdir -p $home/$project/06_rarefact/
mkdir -p $home/$project/07_taxonomy/
mkdir -p $home/$project/08_ancombc/
mkdir -p $home/$project/09_final-files/

echo "Created folder structure for 16S rRNA pipeline at $home/$project"
echo "Completed"
