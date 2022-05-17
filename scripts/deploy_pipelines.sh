#!/bin/bash

# Created: 14/10/2020
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

####### Setup environment #######

echo "#############################"
echo "## Setting up environment ###"
echo "#############################"
echo ""

# create conda environemnt required for pipeline runs
# if a conda environment already exists under the name "pipeline_run_env", it will be overwritten
cd $workingdir/human_genomics_pipeline/workflow/
mamba env create --force -q -f pipeline_run_env.yml

# activate conda environment
source activate pipeline_run_env

####### Run pipelines #######

echo "#############################"
echo "##### Running pipelines #####"
echo "#############################"
echo ""

# run human_genomics_pipeline
cd $workingdir/human_genomics_pipeline/workflow/

bash $run_script

# create report
bash report.sh

# run vcf_annotation_pipeline
cd $workingdir/vcf_annotation_pipeline/workflow/

bash $run_script

# create report
bash report.sh

