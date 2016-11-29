#!/bin/bash

#Author: Trust Odia

#This script predicts genes from the representative sequences
#
#merges all fastq files in the current directory
bash bash merge-paired-reads.sh *.fastq merged.fastq
# converts all fastq files in the directory to fasta 
perl fastq2fasta.pl -a *.fastq
pick_otus.py -i seqs.fasta -o picked_otus # assigns similar sequences into OTU by clustering 
pick_rep_set.py  -i picked_otus.txt  -f seqs.fasta -o rep_set1.fasta #pick reps from each OTU
# download Greengenes reference OTU builds (latest)
wget ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz 
#unpack the this
tar -xvf gg_13_8_otus.tar.gz
#assigns taxonomy to each representative sequence 
assign_taxonomy.py -i rep_set1.fasta -r ./gg_13_8_otus/rep_set/97_otus.fasta -t ./gg_13_8_otus/taxonomy/97_otu_taxonomy.txt  -o tax/
#use Prodigal to predict genes and proteins from representative sequences.
prodigal -i rep_set1.fasta -o genes  -a proteins.fasta

#End 
