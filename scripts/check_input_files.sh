#!/bin/bash

# Created: 16/05/2022
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

##### Check input files exist in expected location #####

echo "############################################"
echo "##### Check pipeline input files exist #####"
echo "############################################"
echo ""

# check for presence of several input files and mention if they or don't exist
if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/human_g1k_v37.fasta" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/human_g1k_v37.fasta"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/human_g1k_v37.fasta"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/dbsnp_138.b37.vcf" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/dbsnp_138.b37.vcf"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/dbsnp_138.b37.vcf"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/Mills_and_1000G_gold_standard.indels.b37.vcf" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/Mills_and_1000G_gold_standard.indels.b37.vcf"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/Mills_and_1000G_gold_standard.indels.b37.vcf"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/1000G_phase1.indels.b37.vcf" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/1000G_phase1.indels.b37.vcf"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/1000G_phase1.indels.b37.vcf"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/hapmap_3.3.b37.vcf" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/hapmap_3.3.b37.vcf"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/hapmap_3.3.b37.vcf"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/Mills_and_1000G_gold_standard.indels.b37.vcf" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/Mills_and_1000G_gold_standard.indels.b37.vcf"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/Mills_and_1000G_gold_standard.indels.b37.vcf"
fi

if test -d "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/vep/GRCh37/" ;
then
echo "Directory exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/vep/GRCh37/"
else
echo "Directory DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/vep/GRCh37/"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/dbNSFP/GRCh37/dbNSFPv4.0a.hg19.custombuild.gz" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/dbNSFP/GRCh37/dbNSFPv4.0a.hg19.custombuild.gz"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/dbNSFP/GRCh37/dbNSFPv4.0a.hg19.custombuild.gz"
fi

if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/CADD/GRCh37/whole_genome_SNVs.tsv.gz" ;
then
echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/CADD/GRCh37/whole_genome_SNVs.tsv.gz"
else
echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/CADD/GRCh37/whole_genome_SNVs.tsv.gz"
fi

# there is an additional input file for the pipelines for cohort runs
if [[ $data == 'Cohort' || $data == 'cohort' ]]; then

    if test -f "/NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/1000G_omni2.5.b37.vcf" ;
    then
    echo "File exists: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/1000G_omni2.5.b37.vcf"
    else
    echo "File DOESN'T exist: /NGS/scratch/KSCBIOM/HumanGenomics/publicData/b37/1000G_omni2.5.b37.vcf"
    fi

fi
