## ---------------------------
##
## Script name: WP_getColoredPathways.R
##
## Purpose of script: Color specific data nodes in a WikiPathways pathway using identifiers or GraphIds
##
## Author: Martina Kutmon
##
## Date Created: 2020-01-20
##
## Session info:
## R version 3.6.3 (2020-02-29)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 10 x64 (build 17763)
## Packages: RCy3 (2.6.3), rstudioapi (0.11)
##

## ---------------------------
# Required libraries
library(RCy3)
library(rstudioapi)

## ---------------------------
# set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

## ---------------------------
# check connection to Cytoscape (needs to be started and WikiPathways app needs to be installed)
RCy3::cytoscapePing()
RCy3::getAppStatus("wikipathways")

# Open pathway in Cytoscape and load data
RCy3::commandsRun('wikipathways import-as-pathway id=WP554') 
toggleGraphicsDetails()

node.table <- RCy3::getTableColumns("node", c("SUID", "Ensembl", "XrefId", "GraphID"))

# CHANGE Ensembl column to GraphID or XrefID if needed
ace.nodes <- node.table[which(node.table$Ensembl=="ENSG00000159640"),]$SUID
ace2.nodes <- node.table[which(node.table$Ensembl=="ENSG00000130234"),]$SUID
RCy3::setNodeColorBypass(node.names = ace.nodes, new.colors = "#5499C7")
RCy3::setNodeColorBypass(node.names = ace2.nodes, new.colors = "#EB984E")


full.path=paste(getwd(),RCy3::getNetworkName(),sep='/')
exportImage(filename=full.path, type='PDF') #.pdf
exportImage(filename=full.path, type='PNG', zoom=300)
