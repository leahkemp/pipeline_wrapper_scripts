#!/bin/bash

# Created: 14/10/2020
# Author: Leah Kemp

###### User configuration #####

# Set working directory
workingdir="/NGS/scratch/KSCBIOM/HumanGenomics/GA_clinical_genomics/run_1"

# Specify the runscript to use
run_script="run_hpc.sh"

####### Setup environment #######

echo "#############################"
echo "## Setting up environment ###"
echo "#############################"
echo ""

# Activate conda environment
source activate pipeline_run_env

####### Run pipelines #######

echo "#############################"
echo "##### Running pipelines #####"
echo "#############################"
echo ""

# Run human_genomics_pipeline
cd $workingdir/human_genomics_pipeline/workflow/

bash $run_script

# Create report
bash report.sh

# Run vcf_annotation_pipeline
cd $workingdir/vcf_annotation_pipeline/workflow/

bash $run_script

# Create report
bash report.sh

####### Moving files #######

echo "#############################"
echo "####### Moving files ########"
echo "#############################"
echo ""

# Move final bam output
cp $workingdir/human_genomics_pipeline/results/mapped/*_recalibrated.bam* /NGS/clinicalgenomics/GA_clinicalWGS/wellington/bams/

# Move final vcf output
cp $workingdir/vcf_annotation_pipeline/results/readyforscout/*_filtered_annotated_readyforscout.vcf.gz /NGS/clinicalgenomics/GA_clinicalWGS/wellington/vcf/

# Move full pipeline runs
mv $workingdir /NGS/clinicalgenomics/GA_clinicalWGS/wellington/runs/
