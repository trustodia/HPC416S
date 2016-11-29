#!/bin/bash

#Author: Trust Odia

#this script creates phylogenetic tree and assigns taxonomy to an OTU table
# be in your working directory 
#create a parameter file
echo "pick_otus:enable_rev_strand_match True"  >> params.txt
echo "pick_otus:similarity 0.90" >> params.txt
# download the microbial reference database
wget ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz
tar -xvf gg_13_8_otus.tar.gz 
#download greengenes database (latest release)
#
# perform “open reference” OTU picking 
mkdir otu_output 
pick_open_reference_otus.py -i ./multiplexed.fasta -r ./gg_13_8_otus/rep_set/97_otus.fasta -o ./otu_output/ -s 0.1  -m usearch61 -p ./params.txt

#outfiles:
#./otu_output/rep_set.tre : phylogenetic tree describing relationship of all sequences
# ./otu_output/rep_set.fna : the second is the list of representative sequences for each OTU (one sequence describing the most likely sequence for each OTU).
# ./otu_output/otu_table_mc2_w_tax.biom: OTU table with taxonomic assignment. 
