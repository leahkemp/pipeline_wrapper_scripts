# Pipeline wrapper scripts

This repo contains scripts and pre-configured configuration files used in the analysis of clinical genomes as a part of the [genomics aotearoa clinical genomics project](https://www.genomics-aotearoa.org.nz/projects/clinical-genomics) on ESR's production network.

Descriptions of how to use these scripts/config files is described in a the following document: [Standard operating procedure (SOP) for transferring, analysing and loading genomes into WDHB production scout instance](https://github.com/leahkemp/WDHB_production_scout/blob/dev/phase_2/SOP/sop.md)

## Wrapper scripts

The wrapper scripts  can be used to automate the process of analysing WGS clinical data on ESR's production network. There are three bash scripts which automate the following steps:

- `./scripts/setup_pipelines.sh`
    - Clone [human_genomics_pipeline](https://github.com/ESR-NZ/human_genomics_pipeline/blob/master/docs/running_on_a_hpc.md#2-take-the-pipeline-to-the-data-on-the-hpc)
    - Clone [vcf_annotation_pipeline](https://github.com/ESR-NZ/vcf_annotation_pipeline/blob/master/docs/running_on_a_hpc.md#2-take-the-pipeline-to-the-data-on-the-hpc)
  - Put pipeline configuration files in place for standard pipeline runs on ESR's production cluster for this project
- `./scripts/check_input_files.sh`
  - Check input files for the pipelines are downloaded and in the expected location
- `./scripts/deploy_pipelines.sh`
  - Create and activate a conda environment to run the pipelines in
  - Run [human_genomics_pipeline](https://github.com/ESR-NZ/human_genomics_pipeline)
  - Run [vcf_annotation_pipeline](https://github.com/ESR-NZ/vcf_annotation_pipeline)

These wrapper scripts utilise user input values from the small configuration file at `./config/config.yaml`.

## Pipeline configuration files

Pre-configured configuration files and runscripts for both [human_genomics_pipeline](https://github.com/ESR-NZ/human_genomics_pipeline) and [vcf_annotation_pipeline](https://github.com/ESR-NZ/vcf_annotation_pipeline) that are standard for analysing whole genomes on ESR production network. The files are available for both [single](./pipeline_config_files/single/) and [cohort](./pipeline_config_files/cohort/) pipeline runs.
