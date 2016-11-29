#!/bin/bash

#Author: Trust Odia
#
#This script creates an OTU Table of the reads
#
#FYI:each of your fasta files. ie R1 forward and R2 reverse have to be in each separate folders to run this script
wget http://drive5.com/uchime/gold.fa #download microbial reference genome
wget http://kirill-kryukov.com/study/tools/fasta-splitter/files/fasta-splitter-0.2.5.zip
unzip fasta-splitter-0.2.5.zip 
#Be in your working directory where your reads are! 
#create two folders in current workig directory and move each fasta file into the folders i.e forward and reverse respectively
#
#mkdir R1_fasta
#mkdir R2_fasta 
#for i in $(ls *.fa); do mv $i R1_fasta/; done
#for i in $(ls *.fa): do mv $i R2_
#
#
# create main folder in home directory
mkdir ~/main
#
# create two folders R1 and R2 in a main folder in your home directory.
mkdir ~/main/R1; mkdir ~/main/R2
#
# move the forward and reverse reads to folders R1 and R2 respectively
cd R1_fasta/
for i in $(ls *.fa); do mv $i ~/main/R1/; done
cd ../
cd R2_fasta/ 
for i in $(ls *.fa); do mv $i ~/main/R2/; done
cd ../ 
#
# relabel multiplexed reads for USEARCH compatibility
for i in $(ls -d ~/main/*/); do awk -v k=$(basename ${i}) '/^>/{$0=">barcodelabel="k";S"(++i)}1' < $i/*.fa; done > multiplexed.fasta
#
# Linearize multiplexed.fasta
awk 'NR==1 {print ; next} {printf /^>/ ? "\n"$0"\n" : $1}END {print}' multiplexed.fasta > multiplexed_linearized.fasta
#
#
#
#
#
#
# Dereplicate the sequences
grep -v "^>" multiplexed_linearized.fasta > grep.txt
grep -v [^ACGTacgt] grep.txt > grep_acgt.txt
sort -d grep_acgt.txt > grep_sorted.txt
uniq -c grep_sorted.txt > grep_uniq.txt
cat grep_uniq.txt| while read abundance sequence ;
do hash=$(printf "${sequence}" | sha1sum);
hash=${hash:0:40};printf ">%s;size=%d;\n%s\n" "${hash}" "${abundance}" "${sequence}";
done > multiplexed_linearized_dereplicated.fasta
#
#
# Abundance sort and discard singleton
usearch61 -sortbysize multiplexed_linearized_dereplicated.fasta -fastaout multiplexed_linearized_dereplicated_sorted.fasta -minsize 2
#
#OTU Clustering
usearch61 -cluster_otus multiplexed_linearized_dereplicated_sorted.fasta -otus otus1.fa
#
#Chimera filtering with reference database
usearch61  -uchime_ref otus1.fa -db gold.fa -strand plus -nonchimeras otus2.fa
#
# Label OTU sequences
python fasta_number.py otus2.fa OTU_ > otus.fa
#
# map reads (including singletons) to OTU
mkdir split_files
mkdir uc_files
#In split_files, break the FASTA files into 100 equal parts:
cd split_files/
perl ./fasta-splitter.pl -n-parts-total 100 multiplexed_linearized.fasta
#
cd uc_files/
for i in $(ls *.fasta); do ../usearch7.0.1001_i86linux32 -usearch_global $i -db ../otus.fa -strand plus -id 0.97 -uc ./$i.map.uc; done    
#
#And combine all the map.uc files together 
cat * > map.uc
#
# generate tab-delimited OTU table without taxonomic information. OTU table of sequence counts
python uc2otutab.py map.uc > otu_table.txt 
#
# convert tab-delimited OTU table to CSV file
tr "\\t" "," < otu_table.txt > otu_table.csv
#
#otu_table.csv: Frequency file
#otu.fa :      OTU sequences 
