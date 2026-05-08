# Evolutionary analysis of m6A RNA modification in mammals

This repository contains the main scripts used for the analyses presented in the manuscript:

**Evolutionary Landscape of m6A RNA Modification in Mammals**

The scripts include analyses for m6A site alignment, tissue/species-level m6A modification comparisons, transcript-level m6A statistics, and phylogenetic generalized least squares analyses between gene expression and tissue modification levels.

## Repository structure

| File | Description |
|---|---|
| `F5_to_FQ.sh` | Shell script for converting FAST5 files to FASTQ format. |
| `m6A_site_alignment.py` | Script for aligning m6A sites across transcripts/species. |
| `m6A_site_alignment_get_cdna_fa.py` | Script for extracting cDNA sequences for m6A site alignment. |
| `m6A_site_alignment_getlist.py` | Script for generating input lists for m6A site alignment. |
| `m6A_site_alignment_get_nexget.py` | Script for generating NEXUS-related files for downstream evolutionary analyses. |
| `tissue_species_mod.R` | R script for analyzing tissue- and species-level m6A modification patterns. |
| `transcript_num_m6a.R` | R script for summarizing m6A-modified transcript numbers. |
| `Gene_Expression_vs_Tissue_Modification_Level_PGLS.R` | R script for PGLS analysis between gene expression and tissue-level m6A modification. |

## Requirements

The scripts were run on a Linux server.

### Python

Tested with Python 3.x.

Required Python packages include:

```bash
pandas
numpy
biopython
