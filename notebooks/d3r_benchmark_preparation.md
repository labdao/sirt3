# Preparing Benchmark Data

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
      mutate(gene = "BACE1") %>% 
      mutate(unit = "") %>% 
      mutate(metric = "ic50") %>%
      mutate(method = "") %>%
      mutate(pdb = NA) %>%
      drop_na(affinity, ligand, ligand_id)

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
      mutate(gene = "CTSS") %>%
        mutate(unit = "") %>% 
      mutate(metric = "") %>%
      mutate(method = "") %>%
      mutate(pdb = NA) %>%
      drop_na(affinity, ligand, ligand_id)

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
      mutate(gene = "JAK2") %>% 
        mutate(unit = "uM") %>% 
      mutate(metric = "kd") %>%
      mutate(method = "") %>%
      mutate(pdb = NA) %>%
      drop_na(affinity, ligand, ligand_id)

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
      mutate(gene = "MAPK14") %>% 
        mutate(unit = "uM") %>% 
      mutate(metric = "kd") %>%
      mutate(method = "") %>%
      mutate(pdb = NA) %>%
      drop_na(affinity, ligand, ligand_id)

    ## Rows: 73 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (4): Ligand_ID, Smiles, Target, Subchallenge
    ## dbl (1): Kd(uM)
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    vegfr2 <- read_csv(here("data/external/d3r_benchmark/VEGFR2/VEGFR2_score_compounds_D3R_GC3.csv")) %>%
      dplyr::select(ligand_id = Ligand_ID,
                  ligand = Smiles,
                  affinity = `Kd(uM)`) %>%
      mutate(gene = "VEGFR2") %>%
      mutate(unit = "uM") %>% 
      mutate(metric = "kd") %>%
      mutate(method = "") %>%
      mutate(pdb = NA) %>%
      drop_na(affinity, ligand, ligand_id)

    ## Rows: 86 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (4): Ligand_ID, Smiles, Target, Subchallenge
    ## dbl (1): Kd(uM)
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    cdk2 <- read_excel(here("data/external/d3r_benchmark/CDK2_Binding_Data_Corrected_2016AUG18.xlsx.xlsx")) %>%
      filter(is.na(ActiveInactive)) %>%
      dplyr::select(ligand_id = Compound_ID,
                  ligand = SMILES,
                  affinity = `Experimental Result, Average Value`,
                  pdb = `PDB ID`) %>%
      mutate(gene = "CDK2") %>% 
      mutate(unit = "nM") %>% 
      mutate(metric = "kd") %>%
      mutate(method = "biolayer interferometry") %>%
      drop_na(affinity, ligand, ligand_id)

    chk1 <- read_excel(here("data/external/d3r_benchmark/Chk1_Binding_Data.xlsx.xlsx")) %>%
      filter(is.na(ActiveInactive)) %>%
      dplyr::select(ligand_id = Compound_ID,
                  ligand = SMILES,
                  affinity = `Experimental Result, Value`,
                  pdb = `PDB ID`) %>%
      mutate(gene = "CHK1") %>% 
      mutate(unit = "nM") %>% 
      mutate(metric = "ic50") %>%
      mutate(method = "radiometric ligand binding") %>%
      drop_na(affinity, ligand, ligand_id)

    erk2 <- read_excel(here("data/external/d3r_benchmark/ERK2_Binding_Data.xlsx.xlsx")) %>%
      #filter(is.na(ActiveInactive)) %>%
      dplyr::select(ligand_id = Compound_ID,
                  ligand = SMILES,
                  affinity = `Experimental Results, Average Value`,
                  pdb = `PDB ID`) %>%
      mutate(gene = "ERK2") %>% 
      mutate(unit = "") %>% 
      mutate(metric = "Ki") %>%
      mutate(method = "FRET") %>%
      drop_na(affinity, ligand, ligand_id)

    hsp90 <- read_excel(here("data/external/d3r_benchmark/HSP90-CDD Export - 2016-08-31.xls.xls")) %>% 
      dplyr::select(ligand_id = `Compound ID`,
                  ligand = SMILES,
                  affinity = `FRET Assay 1: IC50 (nM)`,
                  pdb = `PDB ID`) %>% 
      mutate(gene = "HSP90") %>% 
      mutate(unit = "nM") %>% 
      mutate(metric = "ic50") %>%
      mutate(method = "FRET") %>%
      drop_na(affinity, ligand, ligand_id)
      
    syk <- read_excel(here("data/external/d3r_benchmark/SYK_Binding_Data.xlsx.xlsx")) %>% 
      dplyr::select(ligand_id = `Compound_ID`,
                  ligand = SMILES,
                  affinity = `Experimental Result, Average Value`,
                  pdb = `PDB ID`) %>% 
      mutate(gene = "SYK") %>% 
      mutate(unit = "nM") %>% 
      mutate(metric = "ic50") %>%
      mutate(method = "FRET") %>%
      drop_na(affinity, ligand, ligand_id)

    rbind(cdk2,
          p38a,
          jak2,
          cats,
          bace
          )

    ## # A tibble: 802 × 8
    ##    ligand_id ligand                      affin…¹ pdb   gene  unit  metric method
    ##    <chr>     <chr>                       <chr>   <chr> <chr> <chr> <chr>  <chr> 
    ##  1 CS1       Brc1ccc(cc1)C(=O)Nc1n[nH]c… 33200   4EK4  CDK2  nM    kd     biola…
    ##  2 CS2       O=C(Nc1n[nH]c(c1)C1CC1)CCC… 1840    <NA>  CDK2  nM    kd     biola…
    ##  3 CS3       O=C(Nc1n[nH]c(c1)C1CC1)c1c… 808     4EK5  CDK2  nM    kd     biola…
    ##  4 CS4       O=C(Nc1n[nH]c(c1)C1CC1)c1c… 21200   4FKG  CDK2  nM    kd     biola…
    ##  5 CS9       FC(F)(F)Oc1ccc(cc1)CC(=O)N… 58300   4FKI  CDK2  nM    kd     biola…
    ##  6 CS10      s1cccc1-c1ccc(cc1)CC(=O)Nc… 910     4EK6  CDK2  nM    kd     biola…
    ##  7 CS11      O(CC[NH+]1CCCC1)c1ccc(cc1)… 280     4FJK  CDK2  nM    kd     biola…
    ##  8 CS12      s1c(-c2nc(ncc2)N)c(nc1C)C … ND      4FKL  CDK2  nM    kd     biola…
    ##  9 CS13      Cc1c(c2ccnc(Nc3ccc(Cl)cc3)… 965     <NA>  CDK2  nM    kd     biola…
    ## 10 CS14      FC(C=C1)=CC=C1NC2=NC=CC(C3… 1430    <NA>  CDK2  nM    kd     biola…
    ## # … with 792 more rows, and abbreviated variable name ¹​affinity

\#todo - complete units \#todo - check for dynamic range of measurement
