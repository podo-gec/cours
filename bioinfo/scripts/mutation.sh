#!/usr/bin/env bash

WD="/home/podo/tmp/data_M2"

cd "$WD" || exit
mkdir mutation

# Build the index for the reference genome and save aligned and unaligned reads
echo -e "\033[0;32m[+] [bowtie2] Build index for reference genonme\033[0m"
bowtie2-build Podospora_anserina_S_mat.fna mutation/Podospora_anserina_S_mat
echo -e "\033[0;32m[+] [bowtie2] Compute aligned and unaligned reads\033[0m"
bowtie2 -p 12 \
	-x mutation/Podospora_anserina_S_mat \
	-1 spoD1_R1_001.fastq.gz \
	-2 spoD1_R2_001.fastq.gz \
	--un-conc-gz mutation/unaligned \
	--al-conc-gz mutation/aligned \
	-S mutation/out.sam >/dev/null 2>&1

# Create BAM file
echo -e "\033[0;32m[+] [samtools] Create BAM file, sort and index\033[0m"
samtools view -b mutation/out.sam >mutation/tmp.bam
samtools sort mutation/tmp.bam >mutation/out.bam
rm mutation/tmp.bam
samtools index mutation/out.bam mutation/out.bai

# mpileup
echo -e "\033[0;32m[+] [samtools] Create mpileup file\033[0m"
samtools mpileup -B -f Podospora_anserina_S_mat.fna mutation/out.bam >mutation/out.pileup

# varscan
# NOTE: check read coverage to adjust default parameters below
echo -e "\033[0;32m[+] [varscan] Check for SNPs and indels\033[0m"

varscan mpileup2snp mutation/out.pileup -v \
	--min-coverage 40 \
	--min-reads2 20 \
	--min-var-freq 0.9 \
	--min-avg-qual 15 \
	--p-value 0.9 \
	>mutation/snp.varscan

varscan mpileup2indel mutation/out.pileup -v \
	--min-coverage 40 \
	--min-reads2 20 \
	--min-var-freq 0.9 \
	--min-avg-qual 15 \
	>mutation/indel.varscan
