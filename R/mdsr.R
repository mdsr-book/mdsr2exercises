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
      package = "mdsr2exercises"
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

knit_mdsr_exercises_print <- function(...) {
  mdsr_exercise_ls(...) %>%
    dplyr::filter(!grepl("onlineonly", tags)) %>%
    knit_mdsr_exercises(show_answers = FALSE)
}

#' @rdname mdsr
#' @export

knit_mdsr_exercises_onlineonly <- function(...) {
  mdsr_exercise_ls(...) %>%
    dplyr::filter(grepl("onlineonly", tags)) %>%
    knit_mdsr_exercises(show_answers = FALSE)
}

#' @rdname mdsr
#' @export

knit_mdsr_exercises_solutions <- function(...) {
  mdsr_exercise_ls(...) %>%
    knit_mdsr_exercises(show_answers = TRUE)
}
