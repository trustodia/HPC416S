#!/bin/bash

#Author: Trust Odia

#This script performs Quality test on the sequence reads. This is done before merging and conversion
fastqc -o ./output_dir  --noextract -f fastq *.fastq 
 
