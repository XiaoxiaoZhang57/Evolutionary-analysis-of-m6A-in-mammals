# Evolutionary analysis of m6A RNA modification in mammals

This repository contains the main scripts used for the analyses presented in the manuscript:

**Evolutionary Landscape of m6A RNA Modification in Mammals**

The scripts include analyses for m6A site alignment, tissue- and species-level m6A modification comparisons, transcript-level m6A statistics, and phylogenetic generalized least squares analyses.

## Repository contents

| File | Description |
|---|---|
| `F5_to_FQ.sh` | Shell script for converting FAST5 files to FASTQ format. |
| `m6A_site_alignment_getlist.py` | Script for preparing input lists for cross-species m6A site alignment. |
| `m6A_site_alignment_get_cdna_fa.py` | Script for extracting cDNA sequences for m6A site alignment. |
| `m6A_site_alignment.py` | Script for aligning m6A sites across transcripts/species. |
| `m6A_site_alignment_get_nexget.py` | Script for generating alignment-related files for downstream evolutionary analyses. |
| `tissue_species_mod.R` | R script for analyzing tissue- and species-level m6A modification patterns. |
| `transcript_num_m6a.R` | R script for summarizing the number of m6A-modified transcripts. |
| `Gene_Expression_vs_Tissue_Modification_Level_PGLS.R` | R script for phylogenetic generalized least squares analysis between gene expression and tissue-level m6A modification. |
| `requirements.txt` | Python package requirements. |
| `R_packages.txt` | R package requirements. |
| `LICENSE` | License information for this repository. |

## System requirements

The scripts were run on a Linux server.

The Python scripts require Python 3.

The R scripts require R 4.x or a compatible recent R version.

Some scripts may require external command-line tools depending on the analysis step. For example, `m6A_site_alignment.py` calls Clustal Omega through Biopython.

## Dependencies

### Python dependencies

The Python scripts use standard Python modules and Biopython.

The required Python package is listed in `requirements.txt`.

To install the Python dependency, run:

```bash
pip install -r requirements.txt

