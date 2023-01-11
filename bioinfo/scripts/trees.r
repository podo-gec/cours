library(phytools)

tree_2gc <- read.tree("2gc.nwk")
tree_4gc <- read.tree("4gc.nwk")

tips <- tree_2gc$tip.label
assoc <- data.frame(tips, tips)
names(assoc) <- c("2gc", "4gc")

cp <- cophylo(tree_2gc, tree_4gc, assoc = assoc)

pdf("cophylogeny.pdf", width = 8, height = 8)
plot(cp,
  fsize = .5,
  link.type = "curved", link.lwd = 4,
  link.lty = "solid", link.col = make.transparent("red", 0.25)
)
dev.off()
