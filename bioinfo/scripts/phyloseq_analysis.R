library(phyloseq)
library(vegan)
library(ggplot2)
theme_set(theme_bw())

readRDS("mgo.rds")

## design
## lineage <- c(
##   "kingdom", "subkingdom", "phylum", "clade",
##   "clade", "class", "subclass", "order", "genus",
##   "species group", "species"
## )
## spl <- data.frame(
##   id = colnames(otu),
##   digestat = c("no", "yes", "no", "yes", "no", "yes", "no", "yes"),
##   profondeur = c("haut", "haut", "bas", "bas", "haut", "haut", "bas", "bas"),
##   spot = c("1", "1", "1", "1", "2", "2", "2", "2")
## )
## obj <- phyloseq(
##   otu_table(otu, taxa_are_rows = TRUE),
##   tax_table(as.matrix(tax)),
##   sample_data(spl)
## )


# alpha diversity
plot_richness(obj, measures = c("Observed", "Shannon"))
r <- estimate_richness(obj)
estimateR(t(otu_table(obj)))

pairwise.wilcox.test(r$Observed, sample_data(obj)$spot)

# beta diversity
betadiver(t(otu_table(obj)), "w")

# ordination plots
ord <- ordinate(obj, "MDS", "bray")

plot_ordination(obj, ord, type = "taxa", color = "Order", title = "taxa")

plot_ordination(obj, ord, type = "samples", color = "digestat", label = "id")

plot_ordination(obj, ord, type = "biplot", color = "Order", shape = "spot")
