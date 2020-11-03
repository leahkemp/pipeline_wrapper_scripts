#!/bin/bash

# Created: 09/10/2020
# Author: Leah Kemp

###### User configuration #####

# Set working directory
workingdir="/NGS/scratch/KSCBIOM/HumanGenomics/GA_clinical_genomics/run_1"

# Optional - choose a version of the pipeline by specifying a specific version or git commit
human_genomics_pipeline_version="v1.0.0"
vcf_annotation_pipeline_version="v1.0.0"

####### Clone pipelines #######

echo "#############################"
echo "##### Cloning pipelines #####"
echo "#############################"
echo ""

# human_genomics_pipeline
cd $workingdir

git clone https://github.com/ESR-NZ/human_genomics_pipeline.git

if [ -z "${human_genomics_pipeline_version}" ]
then
echo "...Using the lastest version of human_genomics_pipeline..."
else
cd human_genomics_pipeline
git checkout $human_genomics_pipeline_version
cd $workingdir
echo "...Using this version of human_genomics_pipeline: $human_genomics_pipeline_version..."
fi

# vcf_annotation_pipeline
git clone https://github.com/ESR-NZ/vcf_annotation_pipeline.git

if [ -z "${vcf_annotation_pipeline_version}" ]
then
echo "...Using the lastest version of vcf_annotation_pipeline..."
else
cd vcf_annotation_pipeline
git checkout $vcf_annotation_pipeline_version
cd $workingdir
echo "...Using this version of vcf_annotation_pipeline: $vcf_annotation_pipeline_version..."
fi
