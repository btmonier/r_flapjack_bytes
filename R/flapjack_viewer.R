#' Flapjack Viewer
#'
#' @importFrom htmlwidgets createWidget
#'
#' @export
flapjackViewer <- function(tasObj, width = NULL, height = NULL, elementId = NULL) {
    flpjkPrefix <- "flapjack_out"
    tmpDir <- tempdir()

    exportGenotypeTable(tasObj, paste0(tmpDir, "/", flpjkPrefix), format = "flapjack")

    mapPath <- paste0(tmpDir, "\\", flpjkPrefix, ".flpjk.map")
    genPath <- paste0(tmpDir, "\\", flpjkPrefix, ".flpjk.geno")

    mapStr <- readChar(mapPath, file.info(mapPath)$size)
    genStr <- readChar(genPath, file.info(genPath)$size)


    # forward options using x
    x = list(
        map = mapStr,
        gen = genStr
    )

    # create widget
    htmlwidgets::createWidget(
        name      = 'flapjack_viewer',
        x         = x,
        width     = width,
        height    = height,
        package   = 'mywidget',
        elementId = elementId
    )
}


#' Shiny bindings for flapjack viewer
#'
#' Output and render functions for using mywidget within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a mywidget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name mywidget-shiny
#'
#' @export
flapjackViewerOutput <- function(outputId, width = '100%', height = '400px'){
    htmlwidgets::shinyWidgetOutput(outputId, 'mywidget', width, height, package = 'mywidget')
}

#' @rdname mywidget-shiny
#' @export
renderFlapjackViewer <- function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) { expr <- substitute(expr) } # force quoted
    htmlwidgets::shinyRenderWidget(expr, mywidgetOutput, env, quoted = TRUE)
}


