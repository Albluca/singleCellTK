#' Get data to use as input clustering algorithms
#'
#' @param inSCE Input SCtkExperiment object. Required
#' @param inputData A string ("Raw Data", "PCA Components", "tSNE Components")
#' @param useAssay Indicate which assay to use for PCA. Default is "logcounts"
#' @param reducedDimName If clustering on PCA or t-SNE data, dimension name.
#' The toolkit will store data with the pattern <ASSAY>_<ALGORITHM>.
#'
#' @return Cluster input data
#' @export
#' @examples
#' data("mouseBrainSubsetSCE")
#' getClusterInputData(mouseBrainSubsetSCE, "PCA Components",
#'                     useAssay = "logcounts", reducedDimName = "PCA_logcounts")
#'
getClusterInputData <- function(inSCE, inputData, useAssay="logcounts",
                                reducedDimName=NULL){
  if (inputData == "Raw Data"){
    e <- SummarizedExperiment::assay(inSCE, useAssay)
  } else if (inputData == "PCA Components") {
    if (is.null(reducedDimName)){
      stop("You must supply a PCA dim name")
    }
    if (is.null(SingleCellExperiment::reducedDim(inSCE, reducedDimName))) {
      inSCE <- getPCA(inSCE, useAssay = useAssay,
                      reducedDimName = reducedDimName)
    }
    e <- SingleCellExperiment::reducedDim(inSCE, reducedDimName)
  } else if (inputData == "tSNE Components") {
    if (is.null(reducedDimName)){
      stop("You must supply a tSNE dim name")
    }
    if (is.null(SingleCellExperiment::reducedDim(inSCE, "TSNE"))) {
      inSCE <- getTSNE(inSCE, useAssay = useAssay,
                           reducedDimName = reducedDimName)
    }
    e <- SingleCellExperiment::reducedDim(inSCE, reducedDimName)
  }
  return(e)
}
