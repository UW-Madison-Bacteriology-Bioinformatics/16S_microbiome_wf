#!/bin/bash

set -e

NETID="$1"
PROJECT="$2"

echo "Importing..."
qiime tools import \
  --type EMPPairedEndSequences \
  --input-path /staging/${NETID}/${PROJECT}/input_outputs/00_pipeline_inputs/seqs-2 \
  --output-path original_demux.qza

echo "Demultiplexing..."
qiime demux emp-paired \
  --i-seqs original_demux.qza \
  --m-barcodes-file sample-metadata.tsv \
  --m-barcodes-column barcode-sequence \
  --o-per-sample-sequences demux.qza \
  --p-rev-comp-mapping-barcodes \
  --o-error-correction-details error.qza

echo "Running QIIME summarize..."
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv

echo "Job 01 Complete!"
