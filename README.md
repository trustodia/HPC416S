# HackFest HPC416S
			SOP 16SrRNA microbial diversity : large data analysis
This is the analysis for amplicon shot gun sequences without sample barcodes, meta-data information and mapping file. In this situation the reads are already multiplexed, without barcode labels. This can affect downstream analysis. In this situation, analysis can only be done at a sequence level.

# Objectives
Here, we show how to overcome the above challenge by relabeling sequence identifiers and achieve  the following objectives: (1) assign taxonomy (2) compare phylogenetic relationship among sequences (3) predict genes and functions. This SOP focuses on overcoming memory cap issues with USEARCH 32-bit version.

# Equipment:
Linux or Unix 64-bit OS, > 20GB RAM and > 4 CPU cores.

# Tools:
1. 	USEARCH 7.0.1001: http://www.drive5.com/usearch/download.html and 
    	usearch version 6.1.554 # rename USEARCH61
	Make sure usearch version 6.1.554 is installed in your path (moved to /usr/bin) or you run it your dir
	sudo chmod 777 /usr/bin/usearch61  #make executable 
	
2. 	QIIME: 64-bit of the latest qiime should be installed along with its dependencies.
   	Cent OS installation guide: http://www.chenlianfu.com/?p=2362  https://gist.github.com/alanorth/100dd95f809223ae0100

3.	download http://drive5.com/uchime/gold.fa

4. 	download UPARSE scripts: http://drive5.com/python/python_scripts.tar.gz

5 	download Faster_splitter: http://kirill-kryukov.com/study/tools/fasta-splitter/ 
