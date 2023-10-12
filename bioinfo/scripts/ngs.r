## Kallisto will produce counts and TPM values in a TSV file (as well as
## an HDF5 file). Here is an example of Kallisto output:
##
## target_id length eff_length est_counts tpm
## jgi|Podans1|100005|CE99640_2373 1994 1895 1407 51.6298
## jgi|Podans1|100060|CE99695_1372 3146 3047 504 11.502
## jgi|Podans1|10015|CE9650_8706 1582 1483 1156 54.2042

## NOTE: This R script assumes that kallisto data are already available.
## Sample data are available in file kallisto.tar.gz.
## Update path to reflect the correct location of Kallisto output on your HD
WD <- "~/cwd/gec-cours/bioinfo/data/out"
setwd(WD)

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

BiocManager::install(c("DESeq2", "tximport", "pheatmap", "BiocParallel"))

# If required (Windows):
# BiocManager::install("rhdf5")

library(DESeq2)
library(tximport)
library(pheatmap)

library(BiocParallel)
register(MulticoreParam(2))

datadir <- dir(".", pattern = "out.\\.*")
files <- file.path(datadir, "abundance.h5")
names(files) <- gsub("out.", "", datadir)

samples <- data.frame(
  run = names(files),
  condition = c("soyb4", "corn4", "soyb4", "soyb4", "corn4", "corn4")
)

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

## differential analysis (1)
ddstab <- estimateDispersions(estimateSizeFactors(dds))
r <- results(nbinomWaldTest(ddstab), pAdjustMethod = "BH")
table(r$padj < 0.1)
# r@metadata$filterThreshold

## top genes
plotMA(r)
names(dds)[which(r$padj < 0.1)]

## differential analysis (2)
dds <- DESeq(dds)
res <- results(dds)
res

summary(res)

sum(res$padj < 0.1, na.rm = TRUE)

plotMA(res, ylim = c(-10, 10))

topGene <- rownames(res)[which.min(res$padj)]
with(res[topGene, ], {
  points(baseMean, log2FoldChange, col = "dodgerblue", cex = 2, lwd = 2)
  text(baseMean, log2FoldChange, topGene, pos = 2, col = "dodgerblue")
})

plotCounts(dds, gene = which.min(res$padj), intgroup = "condition")

dists <- dist(t(assay(dds)))
dists

dd <- as.matrix(dists)
pheatmap(dd,
  clustering_distance_rows = dists,
  clustering_distance_cols = dists
)
