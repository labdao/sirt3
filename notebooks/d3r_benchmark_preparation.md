    library(tidyverse)

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.3.6     ✔ purrr   0.3.4
    ## ✔ tibble  3.1.8     ✔ dplyr   1.0.9
    ## ✔ tidyr   1.2.0     ✔ stringr 1.4.1
    ## ✔ readr   2.1.2     ✔ forcats 0.5.2
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    library(janitor)

    ## 
    ## Attaching package: 'janitor'
    ## 
    ## The following objects are masked from 'package:stats':
    ## 
    ##     chisq.test, fisher.test

    library(here)

    ## here() starts at /Users/rindtorff/zettelkasten/projects/sirt3

    library(readxl)

The D3R challenge is a competition for models of small-molecule protein
interaction. The challenge consists of a pose prediction as well as a
\[\[affinity ranking\]\] task.

We focus on the affinity ranking task and curate an oppinionated
benchmark dataset that spans all data in which more than 100 ligands are
available for a given protein target.

In the spirit of zero-shot predictions, we store the FASTA file of the
protein target as well as a reference PDB file that is publicly
available from the PDB.

    # formatting varies widely between the data sets, as they are from different years
    bace <- read_csv(here("data/external/d3r_benchmark/BACE1/BACE_score_compounds_D3R_GC4_answers.csv")) %>% dplyr::select(ligand_id = Cmpd_ID,
                  ligand = SMILES,
                  affinity = Affinity) %>% 
      mutate(gene = "BACE1")

    ## Rows: 154 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Cmpd_ID, SMILES
    ## dbl (1): Affinity
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    cats <- read_csv(here("data/external/d3r_benchmark/CatS/CatS_score_compounds_D3R_GC4_answers.csv")) %>% dplyr::select(ligand_id = Cmpd_ID,
                  ligand = SMILES,
                  affinity = Affinity) %>% 
      mutate(gene = "CTSS")

    ## Rows: 459 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Cmpd_ID, SMILES
    ## dbl (1): Affinity
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    jak2 <- read_csv(here("data/external/d3r_benchmark/JAK2_SC2/JAK2_SC2_score_compounds_D3R_GC3.csv")) %>%
      dplyr::select(ligand_id = Ligand_ID,
                  ligand = Smiles,
                  affinity = `Kd(uM)`) %>%
      mutate(gene = "JAK2")

    ## Rows: 90 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (4): Ligand_ID, Smiles, Target, Subchallenge
    ## dbl (1): Kd(uM)
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    p38a <- read_csv(here("data/external/d3r_benchmark/p38a/p38a_score_compounds_D3R_GC3.csv")) %>%
      dplyr::select(ligand_id = Ligand_ID,
                  ligand = Smiles,
                  affinity = `Kd(uM)`) %>%
      mutate(gene = "MAPK14")

    ## Rows: 73 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (4): Ligand_ID, Smiles, Target, Subchallenge
    ## dbl (1): Kd(uM)
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    cdk2 <- read_excel(here("data/external/d3r_benchmark/CDK2_Binding_Data_Corrected_2016AUG18.xlsx.xlsx")) %>%
      dplyr::select(ligand_id = Compound_ID,
                  ligand = SMILES,
                  affinity = `Experimental Result, Average Value`,
                  pdb = `PDB ID`) %>%
      mutate(gene = "CDK2") %>% 
      mutate(unit = "nM") %>% 
      drop_na()

    #todo import all datasets, check methods and units of affinity
