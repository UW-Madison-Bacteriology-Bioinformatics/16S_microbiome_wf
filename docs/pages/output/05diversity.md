---
layout: default
title: 05-diversity
parent: Result Interpretation
nav_order: 5
---

## Alpha & Beta Diversity and Other Microbiome Diversity Metrics

**Files:**
- `diversity-core-metrics-phylogenetic.tar.gz`

The file can be unzipped using `tar xf diversity-core-metrics-phylogenetic.tar.gz`, which will open a folder with multiple .qza and .qzv files for viewing. 

**Purpose:** The folder contains results from the `qiime diversity` functions, including alpha and beta diversity indices, and principal component analyzes (pcoa) in the `Emperor` plots. 

The folder contains:

**Alpha diversity**

- Shannon’s diversity index (a quantitative measure of community richness)

- Observed Features (a qualitative measure of community richness)

- Faith’s Phylogenetic Diversity (a qualitative measure of community richness that incorporates phylogenetic relationships between the features)

- Evenness (or Pielou’s Evenness; a measure of community evenness)
  
**Beta diversity**

- Jaccard distance (a qualitative measure of community dissimilarity)

- Bray-Curtis distance (a quantitative measure of community dissimilarity)

- unweighted UniFrac distance (a qualitative measure of community dissimilarity that incorporates phylogenetic relationships between the features)

- weighted UniFrac distance (a quantitative measure of community dissimilarity that incorporates phylogenetic relationships between the features)

The **main results** are:

- Saved FeatureTable[Frequency] to: core-metrics-results/rarefied_table.qza

- Saved SampleData[AlphaDiversity] to: core-metrics-results/faith_pd_vector.qza

- Saved SampleData[AlphaDiversity] to: core-metrics-results/observed_features_vector.qza

- Saved SampleData[AlphaDiversity] to: core-metrics-results/shannon_vector.qza

- Saved SampleData[AlphaDiversity] to: core-metrics-results/evenness_vector.qza

- Saved DistanceMatrix to: core-metrics-results/unweighted_unifrac_distance_matrix.qza

- Saved DistanceMatrix to: core-metrics-results/weighted_unifrac_distance_matrix.qza

- Saved DistanceMatrix to: core-metrics-results/jaccard_distance_matrix.qza

- Saved DistanceMatrix to: core-metrics-results/bray_curtis_distance_matrix.qza

- Saved PCoAResults to: core-metrics-results/unweighted_unifrac_pcoa_results.qza

- Saved PCoAResults to: core-metrics-results/weighted_unifrac_pcoa_results.qza

- Saved PCoAResults to: core-metrics-results/jaccard_pcoa_results.qza

- Saved PCoAResults to: core-metrics-results/bray_curtis_pcoa_results.qza

- Saved Visualization to: core-metrics-results/unweighted_unifrac_emperor.qzv ---> ORDINATION PLOT

- Saved Visualization to: core-metrics-results/weighted_unifrac_emperor.qzv ---> ORDINATION PLOT

- Saved Visualization to: core-metrics-results/jaccard_emperor.qzv ---> ORDINATION PLOT

- Saved Visualization to: core-metrics-results/bray_curtis_emperor.qzv---> ORDINATION PLOT

Additionally, comparison of **alpha** and **beta** diversity indices are found in these files:

- Saved Visualization to: core-metrics-results/faith-pd-group-significance.qzv ---> ALPHA-DIVERSITY

- Saved Visualization to: core-metrics-results/evenness-group-significance.qzv ---> ALPHA-DIVERSITY

- Saved Visualization to: core-metrics-results/unweighted-unifrac-${COLUMN}-significance.qzv --> BETA-DIVERSITY

- Saved Visualization to: core-metrics-results/unweighted-unifrac-${COLUMN}-group-significance.qzv --> BETA-DIVERSITY

Additionally **Emperor Plots** (aka ordination plots) are found here:

- Saved Visualization to: core-metrics-results/unweighted-unifrac-emperor-${COLUMN}.qzv

- Saved Visualization to: core-metrics-results/bray-curtis-emperor-${COLUMN}.qzv



**Interpretation:**  


Ref: For more information, visit this website: https://docs.qiime2.org/2024.10/tutorials/moving-pictures/#alpha-and-beta-diversity-analysis 
