#!/bin/bash

# Created: 09/10/2020
# Author: Leah Kemp

##### Setup #####

# a bash-only parser that leverages sed and awk to parse simple yaml files
# grabbed from here: https://stackoverflow.com/questions/5014632/how-can-i-parse-a-yaml-file-from-a-linux-shell-script
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

# parse and create bash variables out of everything in the configuration file
eval $(parse_yaml ./config/config.yaml)

# capture where pipeline_wrapper_scripts repo is located
wrapper_script_dir=$(pwd)

##### Clone pipelines #####

echo "#############################"
echo "##### Cloning pipelines #####"
echo "#############################"
echo ""

# human_genomics_pipeline
cd $fastq_dir/../

git clone https://github.com/ESR-NZ/human_genomics_pipeline.git

if [ -z "${human_genomics_pipeline_version}" ]
then
echo ""
echo "Using the lastest version of human_genomics_pipeline"
echo ""
else
cd human_genomics_pipeline
git checkout $human_genomics_pipeline_version
cd $fastq_dir/../
echo ""
echo "Using this version of human_genomics_pipeline: $human_genomics_pipeline_version"
echo ""
fi

# vcf_annotation_pipeline
git clone https://github.com/ESR-NZ/vcf_annotation_pipeline.git

if [ -z "${vcf_annotation_pipeline_version}" ]
then
echo ""
echo "Using the lastest version of vcf_annotation_pipeline"
echo ""
else
cd vcf_annotation_pipeline
git checkout $vcf_annotation_pipeline_version
cd $fastq_dir/../
echo ""
echo "Using this version of vcf_annotation_pipeline: $vcf_annotation_pipeline_version"
echo ""
fi

##### Configure pipelines #####

echo "###############################"
echo "##### Configure pipelines #####"
echo "###############################"
echo ""

if [ $data == 'Single' ] || [ $data == 'single' ]
then
echo ""
echo "Setting up standard configuration files and runscripts for a single sample run on ESR's cluster"
echo ""
fi

cp -f $wrapper_script_dir/pipeline_config_files/single/human_genomics_pipeline/cluster.json $fastq_dir/../human_genomics_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/single/human_genomics_pipeline/config.yaml $fastq_dir/../human_genomics_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/single/human_genomics_pipeline/dryrun_hpc.sh $fastq_dir/../human_genomics_pipeline/workflow/
cp -f $wrapper_script_dir/pipeline_config_files/single/human_genomics_pipeline/run_hpc.sh $fastq_dir/../human_genomics_pipeline/workflow/
cp -f $wrapper_script_dir/pipeline_config_files/single/vcf_annotation_pipeline/cluster.json $fastq_dir/../vcf_annotation_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/single/vcf_annotation_pipeline/config.yaml $fastq_dir/../vcf_annotation_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/single/vcf_annotation_pipeline/dryrun_hpc.sh $fastq_dir/../vcf_annotation_pipeline/workflow/
cp -f $wrapper_script_dir/pipeline_config_files/single/vcf_annotation_pipeline/run_hpc.sh $fastq_dir/../vcf_annotation_pipeline/workflow/

if [ $data == 'Cohort' ] || [ $data == 'cohort' ]
then
echo ""
echo "Setting up standard configuration files and runscripts for a cohort run on ESR's cluster"
echo ""

cp -f $wrapper_script_dir/pipeline_config_files/cohort/human_genomics_pipeline/cluster.json $fastq_dir/../human_genomics_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/human_genomics_pipeline/config.yaml $fastq_dir/../human_genomics_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/human_genomics_pipeline/dryrun_hpc.sh $fastq_dir/../human_genomics_pipeline/workflow/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/human_genomics_pipeline/run_hpc.sh $fastq_dir/../human_genomics_pipeline/workflow/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/vcf_annotation_pipeline/cluster.json $fastq_dir/../vcf_annotation_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/vcf_annotation_pipeline/config.yaml $fastq_dir/../vcf_annotation_pipeline/config/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/vcf_annotation_pipeline/dryrun_hpc.sh $fastq_dir/../vcf_annotation_pipeline/workflow/
cp -f $wrapper_script_dir/pipeline_config_files/cohort/vcf_annotation_pipeline/run_hpc.sh $fastq_dir/../vcf_annotation_pipeline/workflow/
fi
