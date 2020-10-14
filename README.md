# Wrapper script workflow

The wrapper scripts `setup_pipelines.sh` and `deploy_pipelines.sh` can be used to automate the process of analysing WGS clinical data on ESR's cluster (ORAC). This document describes how to use these wrapper scripts. This workflow will take you from cloning the pipelines to where the WGS data is location, activating the pipeline conda environment, analysing the WGS data (running human_genomics_pipeline and vcf_annotation_pipeline), creating the final reports and moving the final output files to be uploaded into scout (and moving/backing up the whole pipeline run) to `/NGS/clinicalgenomics/GA_clinicalWGS/wellington/` on ORAC.

Note. sex/ancestry checks with peddy/somalier will still need to be manually undertaken

## Assumptions:

- GATK resource bundle and other databases already downloaded
- The pipeline_run_env conda environment has been created (see how to do this [here](https://github.com/ESR-NZ/human_genomics_pipeline#7-create-and-activate-a-conda-environment-with-python-and-snakemake-installed))
- Recommended to run this within [screen](https://linux.die.net/man/1/screen)

## 1. Setup pipelines

In the `setup_pipelines.sh` script, set:

- The working directory (where your data to be analysed is) `workingdir=""`
- The version of the pipelines to use (a git commit) `human_genomics_pipeline_version=""` and `vcf_annotation_pipeline_version=""` (leave blank to use the lastest version of the pipelines)

Setup the pipelines

```bash
bash setup_pipelines.sh
```

## 2. Configure pipelines

Configure the appropriate files in:
- `./human_genomics_pipeline/config/`
- `./human_genomics_pipeline/workflow/`
- `./vcf_annotation_pipeline/config/`
- `./vcf_annotation_pipeline/workflow/`

## 3. Deploy pipelines

```bash
bash deploy_pipelines.sh
```
