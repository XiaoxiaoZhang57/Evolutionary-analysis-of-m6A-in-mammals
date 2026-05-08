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
```

The current `requirements.txt` contains:

```text
biopython
```

### R dependencies

The required R packages are listed in `R_packages.txt`.

The current R package list includes:

```text
ape
nlme
ggplot2
ggimage
rsvg
dplyr
```

These packages can be installed in R using:

```r
install.packages(c("ape", "nlme", "ggplot2", "ggimage", "rsvg", "dplyr"))
```

## Input data

Large raw sequencing files and large intermediate data files are not included in this repository.

The scripts require processed input files, including:

- m6A site prediction results
- transcript annotation files
- cDNA FASTA files
- orthologous transcript or gene lists
- species-level trait tables
- phylogenetic trees

Please refer to the comments in each script for the expected input files and file formats.

## Usage

Example commands for running the Python scripts:

```bash
python m6A_site_alignment_getlist.py
python m6A_site_alignment_get_cdna_fa.py
python m6A_site_alignment.py
python m6A_site_alignment_get_nexget.py
```

Example commands for running the R scripts:

```bash
Rscript tissue_species_mod.R
Rscript transcript_num_m6a.R
Rscript Gene_Expression_vs_Tissue_Modification_Level_PGLS.R
```

## Script-to-analysis mapping

| Script | Related analysis |
|---|---|
| `F5_to_FQ.sh` | Conversion of raw ONT FAST5 files to FASTQ files. |
| `m6A_site_alignment_getlist.py` | Preparation of transcript lists for m6A site alignment. |
| `m6A_site_alignment_get_cdna_fa.py` | Extraction of cDNA sequences for aligned transcripts. |
| `m6A_site_alignment.py` | Cross-species m6A site alignment. |
| `m6A_site_alignment_get_nexget.py` | Generation of alignment-related files for downstream evolutionary analysis. |
| `tissue_species_mod.R` | Tissue- and species-level m6A modification comparison. |
| `transcript_num_m6a.R` | Summary of m6A-modified transcript numbers across tissues/species. |
| `Gene_Expression_vs_Tissue_Modification_Level_PGLS.R` | Phylogenetic generalized least squares analysis between gene expression and tissue-level m6A modification. |

## Data availability

This repository contains the code and documentation used for the analyses in the manuscript.

The version of the code associated with the publication will be archived in Zenodo.

Zenodo DOI: to be added after deposition.

Raw and processed sequencing data are available from the data repositories described in the manuscript.

## Citation

If you use this code, please cite:

Zhang et al. **Evolutionary Landscape of m6A RNA Modification in Mammals**. Nucleic Acids Research.

## Contact

For questions, please contact:

Xiaoxiao Zhang
