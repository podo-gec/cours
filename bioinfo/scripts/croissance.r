# Time-stamp: <2020-12-26 18:26:28 chl>

#
# Courbes de croissance (diamètre du thalle) en fonction de la souche
# et du mileu.
# Souches : A = S, B = delta GUN2, C = GUN2-SG
# Note : la séquence de réplicat est 1 1 1 2 2 2 ..., et pas 1 2 3 1 2 3 ...
#

library(ggplot2)
library(hrbrthemes)

theme_set(theme_ipsum(base_size = 11))

plot_ <- FALSE

## Data processing
d <- read.csv("data.csv", header = TRUE)

## Little fix + check expected values
d$replicat <- rep(1:3, each = 3)

d$souche <- factor(d$souche,
  levels = LETTERS[1:3],
  labels = c("S", "ΔGUN2", "GUN2-SG")
)

d$milieu <- factor(d$milieu,
  levels = c(" M0", " M2", " M3", " M0+At", " M0+Ao"),
  labels = c("M0", "M2", "M3", "M0 + Acétate", "M0 + A. oléique")
)

d <- d[order(d$milieu), ]
d$id <- factor(c(
  rep(1:3, 12), rep(4:6, 12), rep(7:9, 12),
  rep(10:12, 12), rep(13:15, 12)
))

(dm <- aggregate(value ~ souche + jour + milieu, data = d, mean))

dw <- cbind(
  subset(d, replicat == 1, c(1, 2, 3, 5)),
  subset(d, replicat == 2, 5),
  subset(d, replicat == 3, 5)
)

cor(dw[, 4:6])

## Descriptive trellis display
p <- ggplot(data = dm, aes(x = jour, y = value, color = souche))
p <- p + geom_line(aes(group = souche))
p <- p + facet_wrap(~milieu, nrow = 1)
p <- p + guides(col = guide_legend(title = ""))
p <- p + labs(
  x = "Jour", y = "Diamètre moyen du thalle",
  caption = "Données expérimentales (3 réplicats)"
)
p <- p + theme(legend.position = "top")

if (plot_) {
  ggsave("out/fig-growth-curve.pdf", p,
    width = 8, height = 4, device = cairo_pdf
  )
}
