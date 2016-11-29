# HackFest
SOP 16SrRNA microbial diversity : large data analysis
This is the analysis for amplicon shot gun sequences without sample barcodes, meta-data information and mapping file. In this situation the reads are already multiplexed, without barcode labels. This can affect downstream analysis. In this situation, analysis can only be done at a sequence level.

Objectives
Here, we show how to overcome the above challenge by relabeling sequence identifiers and achieve  the following objectives: (1) assign taxonomy (2) compare phylogenetic relationship among sequences (3) predict genes and functions. This SOP focuses on overcoming memory cap issues with USEARCH 32-bit version.

Equipment:
Linux or Unix 64-bit OS, > 20GB RAM and > 4 CPU cores.

Tools:
1. USEARCH 7.0.1001: http://www.drive5.com/usearch/download.html and 
    usearch version 6.1.554 # rename USEARCH61
# Make sure usearch version 6.1.554 is installed in your path (moved to /usr/bin) or you run it your dir
sudo chmod 777 /usr/bin/usearch61  #make executable 
2. QIIME: 64-bit of the latest qiime should be installed along with its dependecies.
   Cent OS installation guide: http://www.chenlianfu.com/?p=2362          https://gist.github.com/alanorth/100dd95f809223ae0100

3. download http://drive5.com/uchime/gold.fa

4. download UPARSE scripts: http://drive5.com/python/python_scripts.tar.gz

5 download Faster_splitter: http://kirill-kryukov.com/study/tools/fasta-splitter/ 

FYI: put each of your fastq files in each folder and run this script !!!!

To create OTU table of sequence counts
#be in your working directory
#if data is in fastq, do:
for i in $(ls -d ./*.fastq); do sed -n '1~4s/^@/>/p;2~4p' ./*.fastq > file.fasta; done

1. create two folders R1 and R2 in a main folder in your home directory.
    mkdir ~/main/R1; mkdir ~/main/R2

2. move the forward and reverse reads to folders R1 and R2 respectively
    mv R1_reads.fasta ~/main/R1; mv R2_reads.fasta ~/main/R2

3. relabel multiplexed reads for USEARCH compatibility
for i in $(ls -d ~/main/*/); do awk -v k=$(basename ${i}) '/^>/{$0=">barcodelabel="k";S"(++i)}1' < $i/*_reads.fasta; done > multiplexed.fasta

4. Linearize multiplexed.fasta
    awk 'NR==1 {print ; next} {printf /^>/ ? "\n"$0"\n" : $1}END {print}' multiplexed.fasta > multiplexed_linearized.fasta





5. Dereplicate the sequences
     grep -v "^>" multiplexed_linearized.fasta > grep.txt
     grep -v [^ACGTacgt] grep.txt > grep_acgt.txt
     sort -d grep_acgt.txt > grep_sorted.txt
     uniq -c grep_sorted.txt > grep_uniq.txt
     cat grep_uniq.txt while read abundance sequence ;
     do hash=$(printf "${sequence}" | sha1sum);
     hash=${hash:0:40};printf ">%s;size=%d;\n%s\n" "${hash}" "${abundance}" "${sequence}";
     done      > multiplexed_linearized_dereplicated.fasta


6. Abundance sort and discard singleton
./usearch7.0.1001_i86linux32 -sortbysize multiplexed_linearized_dereplicated.fasta -output multiplexed_linearized_dereplicated_sorted.fasta -minsize 2

7. OTU Clustering
./usearch7.0.1001_i86linux32 -cluster_otus multiplexed_linearized_dereplicated_sorted.fasta -otus otus1.fa

8. Chimera filtering with reference database
    ./usearch7.0.1001_i86linux32  -uchime_ref otus1.fa -db gold.fa -strand plus -nonchimeras otus2.fa

9. Label OTU sequences
    python fasta_number.py otus2.fa OTU_ > otus.fa

10. map reads (including singletons) to OTU
      mkdir split_files
     mkdir uc_files
#In split_files, break the FASTA files into 100 equal parts:
     cd split_files/
    perl ./fasta_splitter.pl -n-parts-total 100 multiplexed_linearized.fasta

cd uc_files/
for i in $(ls *.fasta); do ../usearch7.0.1001_i86linux32 -usearch_global $i -db ../otus.fa -strand plus -id 0.97 -uc ./$i.map.uc; done    

#And combine all the map.uc files together 
 cat * > map.uc

11. generate tab-delimited OTU table without taxonomic information. OTU table of sequence counts
      python uc2otutab.py map.uc > otu_table.txt 

12. convert tab-delimited OTU table to CSV file
      tr "\\t" "," < otu_table.txt > otu_table.csv

#otu_table.csv: Frequency file
#otu.fa :      OTU sequences
next we generate OTU table with taxonomic information (objective 1 above) and phylogenetic tree (objective 2 above) 

1. create a parameter file
    echo "pick_otus:enable_rev_strand_match True"  >> params.txt
    echo "pick_otus:similarity 0.90" >> params.txt

2. wget ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz 
    #download greengenes database (latest release)

3. perform “open reference” OTU picking
pick_open_reference_otus.py -i $PWD/multiplexed.fasta -r $PWD/97_otus.fasta -o $PWD/otu_output/ -s 0.1  -m usearch61 -p $PWD/params.txt

#outfiles:
a) ./otu_output/rep_set.tre : phylogenetic tree describing relationship of all sequences
b) ./otu_output/rep_set.fna : the second is the list of representative sequences for each OTU (one sequence describing the most likely sequence for each OTU).
c) ./otu_output/otu_table_mc2_w_tax.biom: OTU table with taxonomic assignment.
