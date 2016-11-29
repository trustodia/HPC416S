#!/bin/bash

#Author: Trust Odia
#This script converts fastq file to fasta

for i in $(ls -d ./*.fastq); do perl fastq2fasta.pl -a $i; done 

#for i in $(ls -d ./*.fastq); do sed -n '1~4s/^@/>/p;2~4p' ./*.fastq > forward_read.fasta; done
