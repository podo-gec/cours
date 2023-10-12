# BiocManager::install("topGO")

library(topGO)

## Load data
gego <- readMappings("gene2go.map")
load("cds-rna-seq-pval.rda")


