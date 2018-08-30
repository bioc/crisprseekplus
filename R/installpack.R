#' installpack
#'
#' install packages if they don't exist display.
#'
#' @note \code{installpack}
#' @return install package
#' @param package_name, package name to be installed
#'
#' @examples
#'     x<- installpack()
#'
#'
#' @export
#


installpack <- function(package_name = NULL) {
  if (is.null(package_name)) return(NULL)
  if(isTRUE(package_name %in% .packages(all.available=TRUE))) {
    eval(parse(text = sprintf("require(\"%s\")", package_name)))
  } else {
    eval(parse(text = sprintf("install.packages(\"%s\", 
                              dependencies = TRUE)",  package_name)))
  }
  if(isTRUE(package_name %in% .packages(all.available=TRUE))) {
    eval(parse(text = sprintf("require(\"%s\")", package_name)))
  } else {
    if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")
    BiocManager::install(character(), ask=FALSE) #update installed packages.
    eval(parse(text = sprintf("biocLite(\"%s\")", package_name)))
    eval(parse(text = sprintf("require(\"%s\")", package_name)))
  }
}
