#!/bin/bash

# Created: 09/10/2020
# Author: Leah Kemp

###### User configuration #####

# Set working directory
workingdir="/NGS/scratch/KSCBIOM/HumanGenomics/GA_clinical_genomics/run_1"

# Optional - choose a version of the pipeline by specifying a specific git commit
human_genomics_pipeline_version="a4dc43d7557df41f95f8f5963642b53f5cded99e"
vcf_annotation_pipeline_version="f50944f5aee9e022671a74cd466d763397c6686b"

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
