---
layout: default
title: Customization
nav_order: 3
---

# Customizing the workflow

After you finish running the pipeline with the defaults, you will likely need to edit a few parameters to correctly process your dataset. Some of the main ones that can be changed are:

- Trimming lenghts on the forward and reverse reads (likely have to change depending on your data) (`scripts/02_dada2_qc.sh`)
- Depth of sequencing (likely have to change depending on your data) (`scripts/05_abdiv.sh`)
- Reference Taxonomic Database (`scripts/07_taxonomy.sh`)

## Asssessing what trimming lengths to use
`01-import-demux/demux.qzv` needs to be imported in qiime2 view. 
Click on the tab that says "Interactive quality plot". Check on the forward and reverse reads what position needs to be trimmed on the left and right-hand side of the forward and reverse reads. 

Go into the `scripts/02-dada2-qc.sh` script and manually (using nano) edit the file to change these 4 lines based on what you saw in the demux.qzv file:
```
  --p-trim-left-f newValue \
  --p-trim-left-r newValue \
  --p-trunc-len-f newValue \
  --p-trunc-len-r newValue \
```

## Sample Depth
Open the file `03_features/table.qzv` in Qiime2 View. 
Go to Interactive Sample Details and play around with the slider to see how increasing the Sequencing Depth decreases the number of seqs per samples.

Edit the line `--p-sampling-depth` of the script `05_abdiv.sh` according to what you see in output file 

## Taxonomy
`07-taxonomy/taxa-bar-plot.qzv` in qiime2 view: it doesn't look like much at first, but use the drop-down menu to select another taxonomic level (level 1 = kingdom, 2 = phylum, 3=class, 4=order, 5=family, 6=genus), different color palettes, samples, etc. You can even change the color paletter.

### Change a taxonomy classifier
This workflow supports multiple pre-trained classifiers for taxonomic assignment. The choice of classifier depends on your research goals and sample type.

#### **SILVA**
- **What it is**: A large and widely used database of *16S rRNA gene sequences* from bacteria and archaea.  
- **Options**:  
  - `silva-full`: Full-length 16S reference sequences (most comprehensive, highest resource usage).  
  - `silva-diverse`: Weighted classifier trained on diverse environments (balances accuracy and efficiency).  
  - `silva-stool`: Weighted classifier trained on human stool microbiomes (optimized for gut studies).  
- **Notes**: Considered the "gold standard" for 16S classification. Very large, which can require high memory during classification.  

#### **GTDB (Genome Taxonomy Database)**  
- **What it is**: Genome-based taxonomy built from thousands of bacterial and archaeal genomes.  
- **Options**:  
  - `gtdb-full`: Full-length reference database.  
  - `gtdb-diverse`: Weighted classifier for diverse sample types.  
  - `gtdb-stool`: Weighted classifier optimized for human stool samples.  
- **Notes**: Incorporates whole-genome information, not just 16S. Useful for metagenomic datasets or when genomic resolution is important. Larger than Silva, and still growing rapidly.  

####  **Greengenes2 (GG2)**  
- **What it is**: An updated version of the older Greengenes 16S rRNA reference database.  
- **Options**:  
  - `gg2-full`: Full-length 16S reference classifier.  
  - `gg2-525f`: V4 region (515F/806R primers) classifier, optimized for that commonly sequenced amplicon.  
- **Notes**: Historically popular but smaller than Silva. GG2 is a refreshed release (2024+), but Silva is generally more comprehensive. GG2 classifiers may be faster and lighter to run.  

## Adjusting Taxonomic Level in Differential Abundance (ANCOM-BC)
This section explains how to modify the **taxonomic level** used in ANCOM-BC analysis. By default, the pipeline runs ANCOM-BC at **Level 6** (genus level), but you can easily change this to any desired taxonomic rank (e.g., Level 2 = phylum, Level 3 = class, Level 7 = species).

1. Open the `08_ancombc.sh` script.  
```
nano 08_ancombc.sh
```

2. Change the collapse level `p-level` to your desired level and rename the output file accordingly. For example, the code below set the level to 5 (family):  
```
qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 5 \
  --o-collapsed-table table-level-5.qza \
  --verbose
qiime composition ancombc \
  --i-table table-level-5.qza \
  --m-metadata-file sample-metadata.tsv \
  --p-formula "$COLUMN" \
  --o-differentials level-5-ancombc-${COLUMN}.qza \
  --verbose
qiime composition da-barplot \
  --i-data level-5-ancombc-${COLUMN}.qza \
  --p-significance-threshold 0.001 \
  --o-visualization level-5-da-barplot-${COLUMN}.qzv \
  --verbose
```

3. Pressing `Ctrl + O`, `Enter`, then `Ctrl + X` to save and exit.


## Resubmit the DAG
Once you have modified these values for something customized to your study, rerun the dag, by making a copy of your dag workflow first (e.g. `test_project_dag.dag`)
```
# in the chtc terminal:
cp test_project_dag.dag test_project_dag_2.dag
condor_submit_dag test_project_dag_2.dag
```

Wait for the job to complete, and take a look at the output files again, now that the workflow is using the proper trimming parameters that are specific to your dataset.
