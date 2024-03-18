##### Michael Bond
##### March 18 2024
##### Project Day 1

#Libraries

library(tidyverse)
library(magrittr)
library(useful)
library(scales)
library(ggthemes)
library(ggrepel)
library(taigr)
options(taigaclient.path=path.expand("/opt/miniconda3/envs/taigapy/bin/taigaclient"))
library(ggpubr)
library(uwot)
library(ggpubr)

# Cell line metadata 
Model <- load.from.taiga(data.name='internal-23q4-ac2b', data.version=68, data.file='Model')

Model

glimpse(Model)

Model_ID_Names <- Model %>%
  dplyr::select(ModelID, CellLineName)

Model_ID_Names

#Onc_ref compound names
Compound_Names <- load.from.taiga(data.name='prism-oncology-reference-set-23q4-1a7c', data.version=14, data.file='PRISM_Oncology_Reference_23Q4-Compound_List')

#AUC data
AUC <- load.from.taiga(data.name='prism-oncology-reference-set-23q4-1a7c', data.version=13, data.file='AUC_matrix') %>%
  t() 

#Loading Somatic Mutation Data
OmicsSomaticMutations <- load.from.taiga(data.name='internal-23q4-ac2b', data.version=68, data.file='OmicsSomaticMutations')
Omics_Damaging <- load.from.taiga(data.name='internal-23q4-ac2b', data.version=68, data.file='OmicsSomaticMutationsMatrixDamaging')

#Simply Damaging Column names
colnames(Omics_Damaging)  %<>% word()

view(Omics_Damaging)

#Filter on TP53
TP53 <- Omics_Damaging %>% 
  dplyr::filter(str_detect(Target, "MDM2"),
                screen == "REP.PRIMARY") 

#Unique ModelID with P53 mutation
Unique_Mut_TP53_lines <- 

view(Unique_Mut_TP53_lines)

#Cell Lines with TP53 mutants


#Cell Lines without TP53 mutants












  
  