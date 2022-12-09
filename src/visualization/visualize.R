library(readr)
library(janitor)
library(magrittr)
library(ggplot2)
library(pheatmap)

docking_scores_equibind <- read_csv("data/processed/equibind_scores/4x4_Sample_Comparison_2_Scores.csv")
# docking_scores_vina <- read_csv("data/processed/equibind_scores/4x4_Sample_Comparison_2_Scores.csv")


cross_docking_scores %>% 
  dplyr::select(Receptor, Ligand, Score) %>% 
  tidyr::spread(Receptor, Score) %>% 
  tibble::column_to_rownames("Ligand") %>%
  pheatmap()

