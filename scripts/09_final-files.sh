#!/bin/bash

echo "Create the OTU and TAXONOMY tables"

NETID="$1"
PROJECT="$2"

mkdir -p final_files_output

echo "Creating the otu_table.tsv file"
qiime tools export --input-path table.qza --output-path final_files_output
qiime tools export --input-path taxonomy.qza --output-path final_files_output
biom convert -i final_files_output/feature-table.biom -o final_files_output/otu_table.tsv --to-tsv

ls 

echo "contents of final_files_output are: $(ls final_files_output)"

tar cf final_files_output.tar.gz final_files_output

echo "Done"

