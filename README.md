
<!-- The README.md file is auto-generated from README.Rmd.  Please be sure to make changes in that file -->

# mdsr2exercises

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
![R-CMD-check](https://github.com/beanumber/mdsr2exercises/workflows/R-CMD-check/badge.svg)
![Render
README](https://github.com/beanumber/mdsr2exercises/workflows/Render%20README/badge.svg)
<!-- badges: end -->

The goal of the **mdsr2exercises** packages is to provide exercises for
the 2nd edition of *Modern Data Science with R*.

## Installation

Install from [GitHub](https://github.com):

``` r
#install.packages("remotes")
remotes::install_github("beanumber/etude")
remotes::install_github("beanumber/mdsr2exercises")
```

## Summary

This package contains the following set of exercises:

``` r
library(mdsr2exercises)
library(dplyr)
library(tidyr)
```

``` r
summary_table <- mdsr_exercise_all() %>%
  group_by(chapter, difficulty) %>%
  filter(!grepl("onlineonly", tags)) %>%
  count() %>%
  pivot_wider(names_from = difficulty, values_from = n) %>%
  rowwise() %>%
  mutate(N = sum(c_across(where(is.numeric)), na.rm = TRUE)) %>%
  arrange(desc(N)) %>%
  relocate(chapter, Easy, Medium) %>%
  janitor::adorn_totals("row") 
knitr::kable(summary_table)
```

| chapter      | Easy | Medium | Hard |   N |
|:-------------|-----:|-------:|-----:|----:|
| data-I       |    6 |      8 |   NA |  14 |
| appR         |   11 |      2 |   NA |  13 |
| reproducible |   10 |      2 |   NA |  12 |
| text         |    6 |      5 |    1 |  12 |
| data-II      |    3 |      8 |   NA |  11 |
| sqlI         |    4 |      6 |    1 |  11 |
| dataviz-II   |    2 |      7 |    1 |  10 |
| dataviz-III  |    1 |      7 |    2 |  10 |
| ethics       |    1 |      8 |    1 |  10 |
| simulation   |   NA |      9 |   NA |   9 |
| algorithmic  |    1 |      6 |    1 |   8 |
| sqlII        |    1 |      2 |    5 |   8 |
| foundations  |    2 |      5 |   NA |   7 |
| learning-II  |   NA |      4 |    3 |   7 |
| dataviz-I    |    1 |      5 |   NA |   6 |
| iteration    |    2 |      3 |    1 |   6 |
| join         |    1 |      4 |    1 |   6 |
| learning-I   |    1 |      4 |    1 |   6 |
| modeling     |    2 |      3 |    1 |   6 |
| regression   |    1 |      4 |   NA |   5 |
| spatial-I    |    1 |      1 |    3 |   5 |
| spatial-II   |   NA |      2 |    2 |   4 |
| netsci       |   NA |      1 |    2 |   3 |
| not working  |   NA |      1 |   NA |   1 |
| Total        |   57 |    107 |   26 | 190 |

Here is the summary of the online only exercises:

``` r
summary_table <- mdsr_exercise_all() %>%
  group_by(chapter, difficulty) %>%
  filter(grepl("onlineonly", tags)) %>%
  count() %>%
  pivot_wider(names_from = difficulty, values_from = n) %>%
  rowwise() %>%
  mutate(N = sum(c_across(where(is.numeric)), na.rm = TRUE)) %>%
  arrange(desc(N)) %>%
  relocate(chapter, Easy, Medium) %>%
  janitor::adorn_totals("row") 
knitr::kable(summary_table)
```

| chapter     | Easy | Medium | Hard |   N |
|:------------|-----:|-------:|-----:|----:|
| data-I      |    6 |     NA |    1 |   7 |
| dataviz-I   |    3 |      2 |   NA |   5 |
| dataviz-II  |    3 |     NA |    1 |   4 |
| join        |    3 |     NA |    1 |   4 |
| data-II     |    3 |     NA |   NA |   3 |
| text        |   NA |      2 |    1 |   3 |
| algorithmic |    2 |     NA |   NA |   2 |
| dataI       |    1 |     NA |    1 |   2 |
| foundations |   NA |      2 |   NA |   2 |
| sqlII       |    1 |     NA |    1 |   2 |
| ethics      |   NA |      1 |   NA |   1 |
| not-working |   NA |     NA |    1 |   1 |
| regression  |   NA |      1 |   NA |   1 |
| simulation  |   NA |     NA |    1 |   1 |
| spatial     |   NA |     NA |    1 |   1 |
| Total       |   22 |      8 |    9 |  39 |

## Example

We can build a `tibble` of exercises that you want to show. Also specify
any options, as documented in `etude::etude_list()`. Here, we show how
to display the first two exercises associated with a particular chapter.

``` r
exercises <- mdsr_exercise_ls(chapter == "data-I") %>%
  select(-author, -date) %>%
  head(2)
knitr::kable(exercises)
```

| chapter | difficulty | version | tags                        | id              | status | file                                                                                          | output | depends |
|:--------|:-----------|:--------|:----------------------------|:----------------|:-------|:----------------------------------------------------------------------------------------------|:-------|:--------|
| data-I  | Easy       | 0.1     | first:::second:::onlineonly | cow-make-vase   | OK     | /home/bbaumer/R/x86\_64-pc-linux-gnu-library/4.0/mdsr2exercises/Exercises/cow-make-vase.Rmd   | NA     | NA      |
| data-I  | Easy       | 0.1     | babynames:::join:::third    | crow-burn-sheet | OK     | /home/bbaumer/R/x86\_64-pc-linux-gnu-library/4.0/mdsr2exercises/Exercises/crow-burn-sheet.Rmd | NA     | NA      |

Second, give the in-line command `knit_mdsr_exercises(exercises)`:

## Exercises

**Problem 1 (Easy)**: Which `dplyr` operation is depicted below?

<img src="/home/bbaumer/R/x86_64-pc-linux-gnu-library/4.0/mdsr2exercises/extdata/dplyr-arrange.png" width="50%" />

**Problem 2 (Easy)**: Here is a random subset of the `babynames` data
frame in the `babynames` package:

``` r
Random_subset
#> # A tibble: 10 x 5
#>     year sex   name           n      prop
#>    <dbl> <chr> <chr>      <int>     <dbl>
#>  1  2003 M     Bilal        146 0.0000695
#>  2  1999 F     Terria        23 0.0000118
#>  3  2010 F     Naziyah       45 0.0000230
#>  4  1989 F     Shawana       41 0.0000206
#>  5  1989 F     Jessi        210 0.000105 
#>  6  1928 M     Tillman       43 0.0000377
#>  7  1981 F     Leslee        83 0.0000464
#>  8  1981 F     Sherise       27 0.0000151
#>  9  1920 F     Marquerite    26 0.0000209
#> 10  1941 M     Lorraine      24 0.0000191
```

For each of the following tables wrangled from `Random_subset`, figure
out what `dplyr` wrangling statement will produce the result.

1.  Hint: Both rows and variables are missing from the original

<!-- -->

    #> # A tibble: 4 x 4
    #>    year sex   name        n
    #>   <dbl> <chr> <chr>   <int>
    #> 1  2010 F     Naziyah    45
    #> 2  1989 F     Shawana    41
    #> 3  1928 M     Tillman    43
    #> 4  1981 F     Leslee     83

1.  Hint: the `nchar()` function is used in the statement.

<!-- -->

    #> # A tibble: 2 x 5
    #>    year sex   name       n      prop
    #>   <dbl> <chr> <chr>  <int>     <dbl>
    #> 1  1999 F     Terria    23 0.0000118
    #> 2  1981 F     Leslee    83 0.0000464

1.  Hint: Note the new column, which is constructed from `n` and `prop`.

<!-- -->

    #> # A tibble: 2 x 6
    #>    year sex   name        n      prop    total
    #>   <dbl> <chr> <chr>   <int>     <dbl>    <dbl>
    #> 1  1989 F     Shawana    41 0.0000206 1992225.
    #> 2  1989 F     Jessi     210 0.000105  1991843.

1.  Hint: All the years are still there, but there are only 8 rows as
    opposed to the original 10 rows.

<!-- -->

    #> # A tibble: 8 x 2
    #>    year total
    #>   <dbl> <int>
    #> 1  1920    26
    #> 2  1928    43
    #> 3  1941    24
    #> 4  1981   110
    #> 5  1989   251
    #> 6  1999    23
    #> 7  2003   146
    #> 8  2010    45

## Exercises with answers

To display answers, add the `show_answers = TRUE` option.

## Creating new exercises

Exercises are stored in `inst/Exercises`. To create a new exercise, call
`mdsr_exercise_new()`.

Please also see the [**etude** template
vignette](https://github.com/dtkaplan/etude/blob/master/vignettes/templates.Rmd)

## Quizzes

**mdsr2exercises** also contains quiz and exam questions in the
**exams** format.

The `write_moodle()` function wraps `exams::exams2moodle()` to create
XML files that can be imported into Moodle.

``` r
write_moodle(
  pattern = "wrangling", 
  quiz_name = "wrangling", 
  dir = tempdir()
)
```

## Version and last updated

``` r
citation(package = "mdsr2exercises")
#> 
#> To cite package 'mdsr2exercises' in publications use:
#> 
#>   Benjamin S. Baumer, Nicholas Horton, Jessica Yu and Daniel Kaplan
#>   (NA). mdsr2exercises: Exercises for the 2nd edition of MDSR. R
#>   package version 0.6.3.2.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {mdsr2exercises: Exercises for the 2nd edition of MDSR},
#>     author = {Benjamin S. Baumer and Nicholas Horton and Jessica Yu and Daniel Kaplan},
#>     note = {R package version 0.6.3.2},
#>   }
```

The file was last updated Mon Dec 21 22:13:26 2020 GMT.
