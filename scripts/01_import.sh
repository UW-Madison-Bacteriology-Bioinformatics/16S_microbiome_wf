#!/bin/bash

set -e
NETID="$1"
PROJECT="$2"
export NETID
export PROJECT
echo ${NETID}
echo ${PROJECT}

echo "Container launched successfully..."

MANIFEST_SRC="fastq-manifest.txt"
MANIFEST_TMP="manifest_expanded.txt"

envsubst < "$MANIFEST_SRC" > "$MANIFEST_TMP"

echo "Importing with QIIME tools import..."
qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path  "$MANIFEST_TMP" \
  --input-format PairedEndFastqManifestPhred33V2 \
  --output-path demux.qza

ls -lht

echo "Running QIIME summarize..."
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv

ls -lht
