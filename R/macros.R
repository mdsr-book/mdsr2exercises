#' Macros for typesetting in the MDSR2 exercises
#'
#' Provides inline hooks for packages, data frames, and ....
#'
#' @param word the word you want to use the macro on
#'
#' @export
pkg_macro <- function(word) {
  word <- substitute(word)
  I(glue::glue("`{word}`"))
}

#' @export
#' @rdname pkg_macro
df_macro <- function(word) {
  word <- substitute(word)
  I(glue::glue("`{word}`"))
}

#' @export
#' @rdname pkg_macro
var_macro <- function(word) {
  word <- substitute(word)
  I(glue::glue("`{word}`"))
}

#' @export
#' @rdname pkg_macro
val_macro <- function(word) {
  word <- substitute(word)
  I(glue::glue("*{word}*"))
}

#' @export
#' @rdname pkg_macro
func_macro <- function(word) {
  word <- substitute(word)
  I(glue::glue("`{word}()`"))
}


