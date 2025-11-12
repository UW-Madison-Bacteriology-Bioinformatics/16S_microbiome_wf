#!/bin/bash

echo "Create the OTU and TAXONOMY tables"

NETID="$1"
PROJECT="$2"

MY_PROJECT="/staging/$NETID/$PROJECT/"
echo "The results will be saved here:  $MY_PROJECT"

echo "Creating the otu_table.tsv file"
qiime tools export --input-path $MY_PROJECT/02_dada2_qc/table.qza --output-path $MY_PROJECT/09_final-files
qiime tools export --input-path $MY_PROJECT/07_taxonomy/taxonomy.qza --output-path $MY_PROJECT/09_final-files
biom convert -i $MY_PROJECT/09_final-files/feature-table.biom -o $MY_PROJECT/09_final-files/otu_table.tsv --to-tsv

echo "Done"
