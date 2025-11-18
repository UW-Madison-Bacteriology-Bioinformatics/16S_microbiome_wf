#!/bin/bash
set -e 
COLUMN="$1"
CPU="$2"

echo "The group we are using is: ${COLUMN}"
echo "using cpus: ${CPU}"

echo "Computing diversity metrics..."

qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table.qza \
  --p-sampling-depth 1103 \
  --m-metadata-file sample-metadata.tsv \
  --output-dir core-metrics-results \
  --p-n-jobs-or-threads ${CPU}

echo  "Testing for differences in alpha diversity between groups of samples..."

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv \

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/evenness-group-significance.qzv

echo  "Testing differences in beta diversity between groups of samples..."

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file sample-metadata.tsv \
  --m-metadata-column ${COLUMN} \
  --o-visualization core-metrics-results/unweighted-unifrac-${COLUMN}-significance.qzv \
  --p-pairwise

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file sample-metadata.tsv \
  --m-metadata-column ${COLUMN} \
  --o-visualization core-metrics-results/unweighted-unifrac-${COLUMN}-group-significance.qzv \
  --p-pairwise
  
# Emperor plots:
qiime emperor plot \
  --i-pcoa core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/unweighted-unifrac-emperor-${COLUMN}.qzv

qiime emperor plot \
  --i-pcoa core-metrics-results/bray_curtis_pcoa_results.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/bray-curtis-emperor-${COLUMN}.qzv

ls core-metrics-results

tar cfv diversity-core-metrics-phylogenetic.tar.gz core-metrics-results

ls

echo "Job 05 Complete!"
