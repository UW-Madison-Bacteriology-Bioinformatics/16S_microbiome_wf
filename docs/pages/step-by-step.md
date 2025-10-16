---
layout: default
title: Step-by-step instructions
nav_order: 2
---

# Workflow
## Description of files in this repository:

* `README.md`: These directions
* `docs/`: Contains files for visualization of documentation on the website
* `scripts/`: Contains all `.sh`/`.sub` files required for the pipeline.
  * `00_mkdir.sh`: Script to create directory in staging that will store outputs of jobs
  * `make_dag.sh`: DAGman configuration file
  * `00-08`: Executable and submit scripts pairs for HTCondor DAGman jobs
* `.gitignore`: all files to be ignored

## Before starting

**CHTC account setup**

You will first need access to a `/staging/netid` folder. For more information about /staging folders, please visit: https://chtc.cs.wisc.edu/uw-research-computing/file-avail-largedata . The /staging folder will be used for the large genomic input files, and the large genomic output files.

In your request, please consider your input files (how many samples will you have, have the size of all your reads and assembled data, as well as your output files).

**Demultiplied or not?**

You will need **paired-end reads** (Illumina) corresponding to the 16S rRNA gene amplicons.

- Already demultiplexed:

Most of the time, sequencing centers will give you this data already **demultiplexed**, meaning that you will get 2 files per samples, labelled like this: `{sample}_R1_001.fastq.gz` and `{sample}_R2_001.fastq.gz`.

Organize them like this:
 ```
 seqs/{sample}_R1_001.fastq.gz
 seqs/{sample}_R2_001.fastq.gz
 etc.
 ```


- Not already demultiplexed:

If the data is not already demultiplexed, you should find a forward reads fastq file, a reverse reads fastq file, and a file with barcodes associated with each sample. 

Organize your files like this:
```
seqs/
seqs/forward.fastq.gz
seqs/reverse.fastq.gz
seqs/barcodes.fastq.gz
```

If you just have fastq files, you can "zip" them into the gz file format by typing:
```
gzip forward.fastq
```

**Sample information**

You will need a **tab-separated table** named exactly `sample-metadata.tsv`, (tsv = tab separated values). The file should contain information about the samples, such as sample characteristics. A TSV file is a text file that can be opened with any regular text editor or spreasheet program. The column names for the sample characteristics should not container any special characters, including dashes. For example, if you have a column named `transect-sites` rename it as `transectSite` (or something without dashes), and save the file again.

{: .note }
> For your reference, [here](https://drive.google.com/drive/folders/1qCO_ztaghJvXEnkwRji8tGCH98csbijj?usp=sharing) is an example of what the input folder should look like.

## Steps

1. Log into CHTC
```
ssh netid@ap2002.chtc.wisc.edu
#enter your password
pwd
# this will say something like /home/netid
```
2. Clone this directory into your home directory and make all the script executable with the `chmod` command:
```
git clone https://github.com/UW-Madison-Bacteriology-Bioinformatics/16S_microbiome_wf.git
cd 16S_microbiome_wf
chmod +x scripts/*.sh
```
3. Create a logs folder in your cloned directory (path: `home/username/16S_microbiome_wf/scripts`) for your CHTC log, err and out files.
```
mkdir -p scripts/logs
```


4. Run the helper script `00_mkdir.sh` from your 16S_microbiome_wf/scripts directory. 
This will create the directory within your staging folder that is necessary to handle all file inputs and outputs. To run, type: ``` bash 00_mkdir.sh ```
The script takes 2 arguments: your netid, and the name of a folder that will be created. In this example, the folder will be named `my_project`
```
cd scripts
# change this for your netid
NETID=ptran5
PROJECT=my_project
bash 00_mkdir.sh $NETID $PROJECT
```

5. Run `make_dag.sh` from your scripts directory to create a DAG workflow. 
Be sure to include the six neccessary arguments for it to work.

```
make_dag.sh: illegal option -- h
HELP PAGE...


Syntax: bash make_dag.sh -d <TRUE|FALSE> -n <netid> -g <group> -p <project> -o <output filename>
These arguments can be provided in any order, but all arguments are required. Options are case-sensitive.

Options:
  -d    (required) Demux: Whether you need to demultiplex your data. Use TRUE if you want to demultiplex the data, and FALSE if you have already demultipldex data. Example: TRUE
  -n    (required) NetID: Your UW Madison netid. Example: bbadger
  -g    (required) Group: Group for the diversity plots, must be a column name in sample-metadata.tsv. Example: vegetation
  -p    (required) ProjectName: The project subfolder name. Example: my_project
  -r    (required) Reference database: Target reference database for taxonomy. Example: silva-full
  -o    (required) DAG output file name: Desired name for DAG file. Example: test_project

Example usage: bash make_dag.sh -d TRUE -n bbadger -g vegetation -p my_project -r silva-full -o test_project_true
Example usage: bash make_dag.sh -d FALSE -n bbadger -g vegetation -p my_project -r silva-full -o test_project_false
```

This will create a file named `test_project_true.dag` or `test_project_false.dag`

{: .note }
> 07/15: For now, the group (`-g`) must be a categorical variable without any special characters. For example transect-name will not work because of the dash, but the group vegetation will. See Input Files above.
> This will be fixed in future iterations.
> For a temporary fix, you could also renamed your columns in your sample-metadata.tsv file such as there are no dashes (e.g transect-name would be TransectName) and use that as the group name when using `00_mkdir.sh`

{: .note }
> Check out all options for reference databases in the customization part below.

{:style="counter-reset:none"}

6. Confirm that you have:
	- A) the proper staging folder structure (path: `/staging/username/project/all job names 00-08`) 
	- B) a DAG with your desired name in your scripts folder.

7. Import your input data (paired-end fastq files, and `sample-metadata.tsv` file) into your `/staging/username/project/00_pipeline_inputs` directory.

To transfer files from your laptop to CHTC you can do the following:
	- Open a new terminal window
	- From your laptop navigate to where the FASTQ files are located
```
cd Downloads
scp -r ~/Downloads/seqs netid@ap2002.chtc.wisc.edu:/staging/netid/project/00_pipeline_inputs
```

Do the same thing to transfer the `sample-metadata.tsv` file to the sample folder:
```
scp -r ~/Downloads/sample-metadata.tsv netid@ap2002.chtc.wisc.edu:/staging/netid/project/00_pipeline_inputs
```

The `scp` command takes two arguments. The first one (`~/Downloads/seqs`) is the folder you want to transfer over, and the second argument takes the form of the `sshaddress:path to where you want to put it`

{: .note }
For your reference, [here](https://drive.google.com/drive/folders/1qCO_ztaghJvXEnkwRji8tGCH98csbijj?usp=sharing) is an example of what the input  `00_pipeline_inputs` folder should look like.

{:style="counter-reset:none"}

8. Switch terminal windows and check that the files are transferred correctly.
```
ls /staging/netid/project/00_pipeline_inputs/seqs
ls /staging/netid/project/00_pipeline_inputs/
```

You should be able to see all your paired FASTQ files - if not, try to troubleshoot the `scp` command or ask for help.

{:style="counter-reset:none"}

9. Navigate back to your `/home/username/16S_microbiome_wf/scripts` folder, and from there submit the dag.

```
cd ~/16S_microbiome_wf/scripts
condor_submit_dag test_project_dag.dag
```

{:style="counter-reset:none"}

10. Check your DAG's status with:

```
condor_q
```

At this point, you can log out of chtc, the job will still be running.
Just log back in later to see the job progress by typing condor_q again.

{: .tip }
> If after typing `condor_q` you notice that one of your jobs went on hold, you can try to identify the reason by typing `condor_q -hold` or `condor_q -hold jobID`, where jobID is the number in the last column of the terminal printout for condor_q.
> Carefully read the message, and it might tell you that there was an issue during file transfer input or output. Common mistakes are incorrect file naming, in which case you will see something like "file not found". Carefully read that the path of the file it is trying to transfer is correct and exists.

{:style="counter-reset:none"}

11. The result for each job should appear within its respective output file within the `/staging/$NETID/$PROJECT` directory.

12. Transfer your files from CHTC to your computer once the job is correctly completed. The `/staging` folder is intended for short-term storage of large files, but it does not guarantee long-term backup or permanence. Files may be automatically deleted after a certain period of time. Additionally, you should transfer your output files before submitting your next DAGMan workflow, because by default the workflow will generate output files with the same names. If the files remain in staging, they will be overwritten by the new run unless you manually rename them or follow the same procedure to make a new `.dag` file with a new `project` folder name. One recommended way to transfer files to local is shown below:

To do so, open a new Terminal window.

In terminal, navigate to the location you want the files to go on your device:

```
cd ~/Downloads
mkdir -p my_chtc_results
cd my_chtc_results
```

```
sftp netid@ap2002.cthc.wisc.edu
cd /staging/username/project
get -r *
exit
```

**Another** method to transfer the outputs files are:
```
# Make the output folders wherever you want:
cd ~/Downloads
mkdir -p my_chtc_results
cd my_chtc_results
# replace the netid and the file paths as appropriate, the ./ means transfer these files to the current directory, which would be my_chtc_results in this case 
scp -r bbadger@ap2002.chtc.wisc.edu:/staging/bbadger/project ./
```

## Next steps

The `.qza` (artefacts) and `qzv` (vizualisations) can be opened using the Qiime2 View website (https://view.qiime2.org/). 
From your laptop, where you downloaded your CHTC results files, drag and drop them onto the qiime2 View website to view the plots, tables, etc.
The `qza` files are actually zipped files, so you can also unzip them like a regular .zip file.

