#!/bin/bash
set -e 

DATABASE=$3

echo "Selected classifier: $DATABASE"

CLASSIFIER=""

if [[ "$DATABASE" == "silva-full" ]]; then
    CLASSIFIER="silva-138-99-nb-classifier.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/silva/silva-138-99-nb-classifier.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "silva-diverse" ]]; then
    CLASSIFIER="silva-138-99-nb-diverse-weighted-classifier.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/silva/silva-138-99-nb-diverse-weighted-classifier.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "silva-stool" ]]; then
    CLASSIFIER="silva-138-99-nb-human-stool-weighted-classifier.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/silva/silva-138-99-nb-human-stool-weighted-classifier.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "gtdb-full" ]]; then
    CLASSIFIER="gtdb_classifier_r220.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/gtdb/gtdb_classifier_r220.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "gtdb-diverse" ]]; then
    CLASSIFIER="gtdb_diverse_weighted_classifier_r220.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/gtdb/gtdb_diverse_weighted_classifier_r220.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "gtdb-stool" ]]; then
    CLASSIFIER="gtdb_human_stool_weighted_classifier_r220.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/gtdb/gtdb_human_stool_weighted_classifier_r220.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "gg2-full" ]]; then
    CLASSIFIER="2024.09.backbone.full-length.nb.sklearn-1.4.2.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/greengenes2/2024.09.backbone.full-length.nb.sklearn-1.4.2.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

if [[ "$DATABASE" == "gg2-515f" ]]; then
    CLASSIFIER="2024.09.backbone.v4.nb.sklearn-1.4.2.qza"
    URL="https://data.qiime2.org/classifiers/sklearn-1.4.2/greengenes2/2024.09.backbone.v4.nb.sklearn-1.4.2.qza"
  echo "Downloading classifier from $URL ..."
  wget -O "$CLASSIFIER" "$URL"
fi

echo "Classifying data..."

qiime feature-classifier classify-sklearn \
  --i-classifier "$CLASSIFIER" \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza
qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

echo "Generating taxonomic composition barplots..."
qiime taxa barplot \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization taxa-bar-plots.qzv

echo "Job 07 Complete!"
