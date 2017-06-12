# Intructions for using ChipSeq

##Set up environment

Install the following softares firstly:

1. ngsplt(https://github.com/shenlab-sinai/ngsplot)

2. MACS(https://github.com/taoliu/MACS)

# set Path

emacs .bashrc

export PYTHONPATH=/nethome/axy148/MACS-1.4.2-1/lib/python2.7/site-packages:$PYTHONPATH

export PATH=/nethome/axy148/MACS-1.4.2-1/bin:$PATH

export PATH=$HOME/NGS_tools/ngsplot/bin:$PATH

source .bashrc

#Install ChipSeq

## install from github directly
```{r or bash}
#In R console, you need to have devtools,it is ideal to have R installed in your directory:
#For example: 

> .libPaths()
[1] "/nethome/axy148/R/lib64/R/library"

#install 0.99.0 version
#In R console
library(devtools)
install_github("aiminy/ChipSeq",ref='0.99.0',dependencies = T , force = T)

#If you use command line in pegasus terminal
R -e 'library(devtools);install_github("aiminy/ChipSeq",ref = "0.99.0",dependencies = T , force = T)'
```

## You can run ChipSeq using interactive model by follwing hints:

```{bash}
Rscript /nethome/axy148/R/lib64/R/library/ChipSeq/bin/Run_Chip_Seq_interactive_model.r
Your operating system is:  linux 

#Do you want to perform peak calling, annotation, and coverage visualization?
Yes
[1] "Yes"

#Do you have input bam file for control ?
Yes

#please define the sample information file:
/projects/scratch/bbc/aiminy_project/SampleID_INFO_ChIP_new_Danny.csv

#please define the Bam files information file:
/projects/scratch/bbc/aiminy_project/DannyNewDataHQ.txt

#please define genome name:
hs

#Which peakcaller you want to use, please choose: macs14 or macs2 
macs2

#The peakcaller you choose is : macs2 please define p value threshold for peak calling: 
0.1

#Please define the name of output directory for peaks: 
PeakCallDefault4HQ

```
# Perform analysis in the streamlined batch model

You run this job on the linux cluster(pegasus)

```{bash eval=FALSE}

sh ~/R/lib64/R/library/ChipSeq/bin/BashRun.sh /projects/scratch/bbc/Project/Danny_chip/Alignment/BWA/ /scratch/projects/bbc/aiminy_project/ "Hs" 

#To check output 
ls -lrth /scratch/projects/bbc/aiminy_project/

You will find the follwing latest directories that was created with a timestamp

#For example,

#Peak call is located in  
/scratch/projects/bbc/aiminy_project/ReadBam_at_2016-12-01-18-58-57_PeakCall/
 
#Peak call is located in  
/scratch/projects/bbc/aiminy_project/ReadBam_at_2016-12-01-18-58-57_PeakAnnotation/

#Peak call is located in  
/scratch/projects/bbc/aiminy_project/ReadBam_at_2016-12-01-18-58-57_visualization/
```