#!/usr/bin/env Rscript

packages <- c("optparse","ChIPpeakAnno","ChIPseeker","EnsDb.Mmusculus.v75","DBI","tidyverse","annotate",
              "reactome.db","dplyr")

null<-lapply(packages, function(xxx) suppressMessages(require(xxx, character.only = TRUE,quietly=TRUE,warn.conflicts = FALSE)))

option_list = list(make_option(c("-i", "--input_file_dir"), type="character", default=NULL,
                               help="Input file dir", metavar="character"),
                   make_option(c("-p", "--input_file_pattern"), type="character", default=NULL,
                               help="Input file pattern", metavar="character"),
                   make_option(c("-g", "--genome"), type="character", default=NULL,
                               help="Genome to be used", metavar="character"),
                   make_option(c("-o", "--out_dir"), type="character", default=".",
                               help="output fir[default= %default]", metavar="character")
);

example.use <- 'Example:
Rscript $HOME/Aimin/HomeAtCluster/Project/ChipSeqUMASS/inst/bin/Rscript/ChipSeqUMASS.r -i ~/Aimin/DropboxUmass/NADfinder/BedFiles -p ".bed$" -g "Mm" -o ~/Aimin/DropboxUmass/NADfinder/Aimin/Output'

opt_parser = OptionParser(option_list=option_list,epilogue=example.use);
opt = parse_args(opt_parser);

if (is.null(opt$input_file_dir)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file dir)", call.=FALSE)
}

input.file.dir <- opt$input_file_dir
input.file.pattern <- opt$input_file_pattern
input.genome <- opt$genome
out.dir <- opt$out_dir

if(!dir.exists(out.dir)){dir.create(out.dir,recursive = TRUE)}

initial.options <- commandArgs(trailingOnly = FALSE)
file.arg.name <- "--file="
script.name <- sub(file.arg.name, "", initial.options[grep(file.arg.name, initial.options)])
script.basename <- dirname(dirname(dirname(dirname(script.name))))
other.name <- file.path(script.basename, "R/ChipSeq.R")
print(paste("Sourcing",other.name,"from",script.name))
source(other.name)

print(input.file.dir)
print(out.dir)

AnnotatePeakUMASS(input.file.dir,input.file.pattern,out.dir,genome=input.genome)