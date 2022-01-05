globalVariables(c("modification_time", "path"))

#' Capture HTML output to clipboard
#' @description Copy the HTML output from a particular question to the clipboard
#' @param file path to an exercise file
#' @export
#' @examples
#' file <- mdsr_exercise_ls()$file[4]
#' render_html(file)

render_html <- function(file) {
  if (!fs::file_exists(file)) {
    stop("File not found")
  }
  path_html <- rmarkdown::render(file, output_dir = tempdir())
  html <- readr::read_lines(path_html)
  clipr::write_clip(html)
}


#' R/exams integration
#' @param pattern Regular expression passed to \code{\link[fs]{dir_ls}}.
#' The expression is matched to the file names in the \code{exams} directory
#' @param quiz_name Character giving the name of the quiz
#' @param dir Directory where you want the quiz file to go
#' @param ... arguments passed to \code{\link[exams]{exams2moodle}}
#' @export
#' @seealso \code{\link[exams]{exams2moodle}}
#' @examples
#' \dontrun{
#' write_moodle(pattern = "ethics", "mdsr_ethics", dir = tempdir())
#' }

write_moodle <- function(pattern = "*.Rmd", quiz_name = "mdsr_quiz", dir = ".", ...) {
  q_dir <- system.file("exams", package = "mdsr2exercises")
  questions <- q_dir %>%
    fs::dir_ls(regexp = pattern)

  message(paste("Building quiz:", quiz_name, "with", length(questions), "questions"))
  out <- exams::exams2moodle(
    file = questions,
    name = quiz_name,
    mchoice = list(shuffle = TRUE),
    schoice = list(shuffle = TRUE),
    dir = dir,
    ...
  )
  out_path <- fs::path(dir, paste0(quiz_name, ".xml"))
  if (fs::file_exists(out_path)) {
    return(out_path)
  } else {
    stop(paste("Output file", out_path, "not created"))
  }
}

#' @rdname write_moodle
#' @export
#' @param ... arguments passed to \code{\link[dplyr]{filter}}
#' @examples
#' filter_exam_questions(grepl("sql_", path))
#' filter_exam_questions(as.Date(modification_time) > Sys.Date() - 1)

filter_exam_questions <- function(...) {
  system.file("exams", package = "mdsr2exercises") %>%
    fs::dir_info() %>%
    dplyr::mutate(mod_date = as.Date(modification_time)) %>%
    dplyr::filter(...) %>%
    dplyr::pull(path)
}
