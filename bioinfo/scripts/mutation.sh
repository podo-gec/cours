#!/usr/bin/env bash

WD="/home/podo/tmp/data_M2"

cd "$WD" || exit
mkdir mutation

# Build the index for the reference genome and save aligned and unaligned reads
bowtie2-build Podospora_anserina_S_mat.fna mutation/Podospora_anserina_S_mat
bowtie2 --quiet \
	-x mutation/Podospora_anserina_S_mat \
	-1 spoD1_R1_001.fastq.gz \
	-2 spoD1_R2_001.fastq.gz \
	--un-conc-gz mutation/unaligned \
	--al-conc-gz mutation/aligned \
	-S mutation/out.sam

# Create BAM file
samtools view -b mutation/out.sam >mutation/tmp.bam
samtools sort mutation/tmp.bam >mutation/out.bam
rm mutation/tmp.bam

# mpileup
samtools mpileup -B -f Podospora_anserina_S_mat.fna mutation/out.bam >mutation/out.pileup

# varscan
varscan pileup2cns mutation/out.pileup \
	--min-coverage 20 \
	--min-reads2 10 \
	--min-var-freq 0.9 \
	--output-snp mutation/snp \
	--output-indel mutation/indel
