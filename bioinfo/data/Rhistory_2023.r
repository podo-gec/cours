library(phyloseq)
obj = readRDS("mgo.rds")
obj = readRDS("data/mgo.rds")
obj
tax_table(obj)
setwd("~/tmp")
read.table("P1SD_S2_L001_001.fastq.taxonomy", header = TRUE, sep = "\t")
read.table("P1SD_S2_L001_001.fastq.taxonomy", header = FALSE, sep = "\t")
d = read.table("P1SD_S2_L001_001.fastq.taxonomy", header = FALSE, sep = "\t")
d$V14
table(d$V14)
prop.table(d$V14)
prop.table(table(d$V14))
prop.table(table(d$V14)) * 100
table(d$V14[d$V14 != "n"])
prop.table(table(d$V14[d$V14 != "n"])) * 100
setwd("~/cwd/gec-cours/bioinfo/data")
library(phyloseq)
library(vegan)
library(ggplot2)
theme_set(theme_bw())
obj = readRDS("mgo.rds")
obj
tax_table(obj)
tax_table(obj)$Order
tax_table(obj)$order
class(tax_table(obj))
?tax_table
data.frame(tax_table(obj))
data.frame(tax_table(obj))$Order
taxonomy = data.frame(tax_table(obj))
colnames(taxonomy)
table(taxonomy$order)
table(taxonomy$Order)
taxonomy[taxonomy$Order == "Sordariales"]
taxonomy[taxonomy$Order == "Sordariales",]
subset(taxonomy, Order == "Sordariales")
subset(taxonomy, Order == "Sordariales", "Family")
table(sordariales$Family)
sordariales = subset(taxonomy, Order == "Sordariales")
table(sordariales$Family)
sordariales[is.na(Sordariales$Family),]
sordariales[is.na(sordariales$Family),]
sordariales[sordariales$Family == "",]
# alpha diversity
plot_richness(obj, measures = c("Observed", "Shannon"))
r <- estimate_richness(obj)
r
estimateR(t(otu_table(obj)))
# beta diversity
betadiver(t(otu_table(obj)), "w")
help(betadiver)
# ordination plots
ord <- ordinate(obj, "MDS", "bray")
ord
plot_ordination(obj, ord, type = "taxa", color = "Order", title = "taxa")
plot_ordination(obj, ord, type = "samples", color = "digestat", label = "id")
plot_ordination(obj, ord, type = "biplot", color = "Order", shape = "spot")
plot_ordination(obj, ord, type = "samples",  label = "id")
plot_ordination(obj, ord, type = "biplot", shape = "spot")
plot_ordination(obj, ord, type = "biplot", color = "spot")
obj
sample_data(obj)
plot_ordination(obj, ord, type = "samples", color = "Digestate", label = "id")
plot_ordination(obj, ord, type = "biplot", color = "Order", shape = "Spot")
