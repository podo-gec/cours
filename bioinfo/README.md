## Supports pédagogiques pour les TD et TP de bioinformatique du M2 de mycologie

Le répertoire [dist][] contient les diaporamas (version écran ou imprimable, avec le suffixe 2x2). Les documents sont également lisibles au format HTML depuis le répertoire [src][] (sans références bibliographiques). Les scripts utilisés lors des TP sont disponibles dans le répertoire [scripts][]. Le répertoire [data][] contient la plupart des données utilisées pour les TP de phylogénie et de RNA-Seq.

## Logiciels utilisés

- [Galaxy](https://usegalaxy.eu) (serveur Europe)
- [R](https://cran.r-project.org/) et [Rstudio](https://posit.co/download/rstudio-desktop/)
- [Artemis](https://sanger-pathogens.github.io/Artemis/Artemis/), [Jalview](https://www.jalview.org/), [Seaview](https://doua.prabi.fr/software/seaview), [Mega](https://megasoftware.net/)
- Outils en ligne : [Mafft](https://mafft.cbrc.jp/alignment/software/), [PhyML](https://www.atgc-montpellier.fr/phyml/)

## Ressources externes

### Cours de biostatistiques

- [Bioconductor](https://bioconductor.org/)
- [Méthodes biostatistiques](https://even4void.github.io/rstats-biostats/)

### Outils pour la phylogénie

- R : Task View [Phylogenetics](https://cran.r-project.org/web/views/Phylogenetics.html) (packages `ape`, `phangorm`, `phytools`)
- Galaxy : [Preparing genomic data for phylogeny reconstruction](https://training.galaxyproject.org/training-material/topics/ecology/tutorials/phylogeny-data-prep/tutorial.html)

### Outils pour le RNA-Seq

- R : [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html) et [kallisto](https://pachterlab.github.io/kallisto/)
- Galaxy : [Reference-based RNA-Seq data analysis](https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/ref-based/tutorial.html)

### Outils pour la méta-génomique

- R : [dada2 pipeline](https://benjjneb.github.io/dada2/tutorial.html), [phyloseq](https://bioconductor.org/packages/release/bioc/html/phyloseq.html) (avec [Kraken](https://ccb.jhu.edu/software/kraken/))
- [FROGS](https://sepsis-omics.github.io/tutorials/modules/frogs/)
- Galaxy : [Analyses of metagenomics data - The global picture](https://training.galaxyproject.org/training-material/topics/metagenomics/tutorials/general-tutorial/tutorial.html)

[dist]: https://github.com/podo-gec/cours/tree/master/bioinfo/dist
[src]: https://github.com/podo-gec/cours/tree/master/bioinfo/src
[scripts]: https://github.com/podo-gec/cours/tree/master/bioinfo/scripts
[data]: https://github.com/podo-gec/cours/tree/master/bioinfo/data
