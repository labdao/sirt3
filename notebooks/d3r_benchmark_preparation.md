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

The \[\[D3R challenge\]\] is a competition for models of small-molecule
protein interaction. The challenge consists of a \[\[pose\]\] prediction
as well as a \[\[affinity ranking\]\] task.

We focus on the affinity ranking task and curate an oppinionated
benchmark dataset that spans all data in which more than 100 ligands are
available for a given protein target.

In the spirit of zero-shot predictions, we store the FASTA file of the
protein target as well as a reference PDB file that is publicly
available from the \[\[PDB\]\].

    bace <- read_csv(here("data/external/d3r_benchmark/BACE1/BACE_score_compounds_D3R_GC4_answers.csv")) %>% janitor::clean_names()

    ## Rows: 154 Columns: 3
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): Cmpd_ID, SMILES
    ## dbl (1): Affinity
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    list.files(here("data/external/d3r_benchmark/"), recursive = TRUE, pattern = "_score_")

    ## [1] "BACE1/BACE_score_compounds_D3R_GC4_answers.csv"
    ## [2] "CatS/CatS_score_compounds_D3R_GC4_answers.csv"
