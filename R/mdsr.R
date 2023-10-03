globalVariables(c("id", "difficulty", "exercise", "tags"))

#' List, filter, and show MDSR2e exercises
#' @export
#' @rdname mdsr
#' @inheritParams etude::new_etude
#' @seealso \code{\link[etude]{new_etude}}
#' @examples
#' \dontrun{
#' mdsr_exercise_new()
#' }

mdsr_exercise_new <- function(directory = here::here("inst", "Exercises"),
                               learnr = FALSE) {
  if (fs::is_dir(directory) && !grepl("/$", directory)) {
    directory <- paste0(directory, "/")
  }
  etude::new_etude(directory, learnr)
}

#' @export
#' @rdname mdsr
#' @importFrom dplyr %>%
#' @param ... arguments passed to \code{\link[dplyr]{filter}}
#' @seealso \code{\link[etude]{etude_dir}}, \code{\link[dplyr]{filter}}
#' @examples
#' mdsr_exercise_ls()

mdsr_exercise_ls <- function(...) {
  mdsr_exercise_all() %>%
    dplyr::filter(...)
}


#' @rdname mdsr
#' @export

mdsr_exercise_all <- function() {
  etude::etude_dir(system.file("Exercises", package = "mdsr2exercises"))
}

#' @rdname mdsr
#' @param x data frame of exercises
#' @param show_answers Should the answers be shown?
#' @export

knit_mdsr_exercises <- function(x, show_answers = FALSE) {
  helpsort <- dplyr::tibble(
    difficulty = c("Easy", "Medium", "Hard"),
    order = c(0, 1, 2)
  )
  ex <- x %>%
    dplyr::left_join(helpsort, by = "difficulty") %>%
    dplyr::select(exercise = id, difficulty, order) %>%
    dplyr::arrange(order) %>%
    dplyr::select(-order) %>%
    # mdsr-specific formatting
    dplyr::mutate(
      # name = paste0("**Problem ", dplyr::row_number(), " (", difficulty, ")** [", exercise, "]:"),
      name = paste0("**Problem ", dplyr::row_number(), " (", difficulty, ")**:"),
      answers = show_answers,
      documentation  = FALSE,
      package = "mdsr2exercises",
      latex_solution_start = "**SOLUTION:** \n",
      latex_solution_end = "\n---"
    )
  if (nrow(ex) < 1) {
    return(I("No exercises found"))
  } else {
    ex %>%
      etude::etude_list()
  }
}

#' @rdname mdsr
#' @export

knit_mdsr_exercises_filter <- function(..., show_answers = FALSE) {
  mdsr_exercise_ls(...) %>%
    knit_mdsr_exercises(show_answers = show_answers)
}

#' @rdname mdsr
#' @export

knit_mdsr_exercises_print <- function(..., show_answers = FALSE) {
  mdsr_exercise_ls(...) %>%
    dplyr::filter(!grepl("onlineonly", tags)) %>%
    knit_mdsr_exercises(show_answers = show_answers)
}

#' @rdname mdsr
#' @export

knit_mdsr_exercises_onlineonly <- function(..., show_answers = FALSE) {
  mdsr_exercise_ls(...) %>%
    dplyr::filter(grepl("onlineonly", tags)) %>%
    knit_mdsr_exercises(show_answers = show_answers)
}

#' @rdname mdsr
#' @export

knit_mdsr_exercises_solutions <- function(...) {
  mdsr_exercise_ls(...) %>%
    knit_mdsr_exercises(show_answers = TRUE)
}

#' @rdname mdsr
#' @param url URL of an image from the Internet
#' @export
#' @examples
#' include_mdsr_img("hickey-denzel-1.png")
#' include_mdsr_img("dplyr-arrange.png")
#'

include_mdsr_img <- function(img) {
  file_name <- basename(img)
  pkg_img <- system.file(
    "extdata", file_name, package = "mdsr2exercises"
  )
  gh_img <- paste0(
    "https://raw.githubusercontent.com/mdsr-book/mdsr2exercises/main/inst/extdata/",
    file_name
  )
  if (knitr::is_latex_output() && file.exists(pkg_img)) {
    knitr::include_graphics(pkg_img)
  } else {
    knitr::include_graphics(gh_img)
  }
}
