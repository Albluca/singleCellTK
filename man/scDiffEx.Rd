% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scDiffEx.R
\name{scDiffEx}
\alias{scDiffEx}
\alias{scDiffExDESeq2}
\alias{scDiffExlimma}
\alias{scDiffExANOVA}
\title{Perform differential expression analysis on a SCtkExperiment object}
\usage{
scDiffEx(inSCE, useAssay = "logcounts", condition, covariates = NULL,
  significance = 0.05, ntop = 500, usesig = TRUE, diffexmethod,
  levelofinterest = NULL, analysisType = NULL, controlLevel = NULL,
  adjust = "fdr")

scDiffExDESeq2(inSCE, useAssay = "counts", condition,
  analysisType = "biomarker", levelofinterest = NULL, controlLevel = NULL,
  covariates = NULL, adjust = "fdr")

scDiffExlimma(inSCE, useAssay = "logcounts", condition,
  analysisType = "biomarker", levelofinterest = NULL, covariates = NULL,
  adjust = "fdr")

scDiffExANOVA(inSCE, useAssay = "logcounts", condition, covariates = NULL,
  adjust = "fdr")
}
\arguments{
\item{inSCE}{Input SCtkExperiment object. Requireds}

\item{useAssay}{Indicate which assay to use. Default is "logcounts" for limma
and ANOVA, and "counts" for DESeq2.}

\item{condition}{The name of the condition to use for differential
expression. Must be a name of a column from colData that contains at least
two labels. Required}

\item{covariates}{Additional covariates to add to the model. Default is NULL}

\item{significance}{FDR corrected significance cutoff for differentially
expressed genes. Required}

\item{ntop}{Number of top differentially expressed genes to display in the
heatmap. Required}

\item{usesig}{If TRUE, only display genes that meet the significance cutoff,
up to ntop genes. Required}

\item{diffexmethod}{The method for performing differential expression
analysis. Available options are DESeq2, limma, and ANOVA. Required}

\item{levelofinterest}{If the condition has more than two labels,
levelofinterest should contain one factor for condition. The differential
expression results will use levelofinterest depending on the analysType
parameter.}

\item{analysisType}{For conditions with more than two levels, limma and
DESeq2 can be run using multiple methods. For DESeq2, choose "biomarker" to
compare the levelofinterest to all other samples. Choose "contrast" to
compare the levelofinterest to a controlLevel (see below). Choose
"fullreduced" to perform DESeq2 in LRT mode. For limma, Choose "biomarker" to
compare the levelofinterest to all other samples. Choose "coef" to select a
coefficient of interset with levelofinterest (see below). Choose "allcoef" to
test if any coefficient is different from zero.}

\item{controlLevel}{If the condition has more than two labels, controlLevel
should contain one factor from condition to use as the control.}

\item{adjust}{Method for p-value correction. See options in p.adjust().
The default is fdr.}
}
\value{
A data frame of gene names and adjusted p-values
}
\description{
Perform differential expression analysis on a SCtkExperiment object
}
\section{Functions}{
\itemize{
\item \code{scDiffExDESeq2}: Perform differential expression analysis with DESeq2

\item \code{scDiffExlimma}: Perform differential expression analysis with limma

\item \code{scDiffExANOVA}: Perform differential expression analysis with ANOVA
}}

\examples{
data("mouseBrainSubsetSCE")
res <- scDiffEx(mouseBrainSubsetSCE,
                useAssay = "logcounts",
                "level1class",
                diffexmethod = "limma")

data("mouseBrainSubsetSCE")
#sort first 100 expressed genes
ord <- rownames(mouseBrainSubsetSCE)[
  order(rowSums(assay(mouseBrainSubsetSCE, "counts")),
        decreasing = TRUE)][1:100]
#subset to those first 100 genes
subset <- mouseBrainSubsetSCE[ord, ]
res <- scDiffExDESeq2(subset, condition = "level1class")

data("mouseBrainSubsetSCE")
res <- scDiffExlimma(mouseBrainSubsetSCE, condition = "level1class")

data("mouseBrainSubsetSCE")
res <- scDiffExANOVA(mouseBrainSubsetSCE, condition = "level1class")

}
