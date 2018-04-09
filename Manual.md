Note:The below workflow is for sequence level analysis for RNAseq data (16SrRNA).

# Objectives
Here, we show how to (1) assign taxonomy (2) compare phylogenetic relationship among sequences (3) predict genes and functions. This SOP focuses on overcoming memorycap issues with USEARCH 32-bit version. The included scripts can be used to perform these objectives.

# Equipment:
Linux or Unix 64-bit OS, > 20GB RAM and > 4 CPU cores.

# Script-flow:
convert_fq_fa.sh -> merge-paired-reads.sh -> creat_OTU.sh -> create_phylo.sh -> pred_genes.sh

# Tools/requirements:
1. USEARCH 7.0.1001: http://www.drive5.com/usearch/download.html and 
usearch version 6.1.554 # rename USEARCH61
Make sure usearch version 6.1.554 is installed in your path (moved to /usr/bin) or you run it your dir
sudo chmod 777 /usr/bin/usearch61  #make executable . Both USEARCH are required

2. QIIME 64-bit of the latest qiime should be installed along with its dependencies.
  Cent OS installation guide: http://www.chenlianfu.com/?p=2362 and  https://gist.github.com/alanorth/100dd95f809223ae0100

3. download reference database http://drive5.com/uchime/gold.fa

4. download UPARSE scripts: http://drive5.com/python/python_scripts.tar.gz

5. download Faster_splitter: http://kirill-kryukov.com/study/tools/fasta-splitter/ 

6. download Greengenes Database ftp://greengenes.microbio.me/greengenes_release/gg_13_5/gg_13_8_otus.tar.gz
