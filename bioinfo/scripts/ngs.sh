#!/usr/bin/env bash

#
# Simple toolchain for gene quantisization using kallisto.
# (feat. a comparison to BEDtools multicov.)
#

PREPROCESS=1

if [ "$PREPROCESS" -eq 1 ]; then
	## SRA -> Fasta (parallel runs)
	for file in *.sra; do
		fastq-dump "$file" &
	done

	## Build index of genome
	kallisto index -i Podans1_GeneCatalog_transcripts_20171002.nt.idx \
		Podans1_GeneCatalog_transcripts_20171002.nt.fas
fi

## Quantification
for file in *.fastq; do
	kallisto quant -i Podans1_GeneCatalog_transcripts_20171002.nt.idx \
		-o out."${file%.*}" \
		--single -l 100 -s 5 -b 20 --seed 101 --threads=4 "$file"
	# --pseudobam
done

# BEDtools multicov
# samtools sort out/pseudoalignments.bam -o out/pseudoalignments.sorted.bam
# samtools index out/pseudoalignments.sorted.bam

# faidx --transform bed Podans1_GeneCatalog_transcripts_20171002.nt.fasta \
#     > Podans1_GeneCatalog_transcripts_20171002.nt.bed
# bedtools multicov -bams out/pseudoalignments.sorted.bam \
#     -bed Podans1_GeneCatalog_transcripts_20171002.nt.bed \
#     > out/multicov.out
