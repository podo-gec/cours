## NOTE: This R script assumes that kallisto data are already available.
##
## Kallisto will produce counts and TPM values in a TSV file (as well as
## an HDF5 file). Here is an example of Kallisto output:
##
## target_id length eff_length est_counts tpm
## jgi|Podans1|100005|CE99640_2373 1994 1895 1407 51.6298
## jgi|Podans1|100060|CE99695_1372 3146 3047 504 11.502
## jgi|Podans1|10015|CE9650_8706 1582 1483 1156 54.2042

library("DESeq2")
library("tximport")
library(pheatmap)

datadir <- dir(".", pattern = "out.\\.*")
files <- file.path(datadir, "abundance.h5")
names(files) <- gsub("out.", "", datadir)

samples <- data.frame(run = names(files), condition = c("4h", "48h", " 24h"))

txi <- tximport(files, "kallisto", txOut = TRUE)
dds <- DESeqDataSetFromTximport(txi, colData = samples, design = ~condition)

## sanity checking
gene_counts <- counts(dds)
counts_per_sample <- apply(gene_counts, 1, function(x) all(x) > 0)
cat(sum(counts_per_sample), "out of", nrow(dds), "\n")

## sample clustering
rld <- rlogTransformation(dds, blind = TRUE)
dd <- as.matrix(dist(t(assay(rld))))
pheatmap(dd)
plotPCA(rld, intgroup = c("condition"))

## differential analysis
ddstab <- estimateDispersions(estimateSizeFactors(dds))
r <- results(nbinomWaldTest(ddstab), pAdjustMethod = "BH")
table(r$padj < 0.1)
## r@metadata$filterThreshold

## top genes
plotMA(r)
names(dds)[which(r$padj < 0.1)]
