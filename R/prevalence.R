################################################################################
#
#'
#' Function to calculate sample size for estimating prevalence/proportional
#' indicators from a simple random sample (SRS) or a random cluster sample (RCS)
#' survey. This function has an option to apply a finite population correction
#' (FPC) to the sample size calculations.
#'
#' @param z The z-score/z-value for a 95\% confidence interval. Typical vaues
#'     for \code{z} are 1.645 for a 90\% confidence interval, 1.75 for a 92\%
#'     confidence interval, 1.96 for a 95\% confidence interval and 2.05 for a
#'     96\% confidence interval. Default is 1.96.
#' @param p The numeric value of the expected prevalence/proportion. Default is
#'     0.5 (for 50\% prevalence/proportion) as this gives the highest sample
#'     size estimate. If previous prevalence/proportion is known, this value
#'     can be used for \code{p}.
#' @param c The numeric value of the desired precision of the resulting
#'     prevalence/proportion estimate. For coverage surveys, default is set at
#'     ±10\% (0.1).
#' @param deff The numeric for design effect (\code{deff}) to account for
#'     suvey design. For simple random sample (SRS) surveys, a \code{deff} of
#'     1 is used. For a random cluster survey (RCS), a \code{deff} of 2 is
#'     usually used. If survey data from previous cluster surveys is available,
#'     \code{deff} can be calculated using \code{deff()} function from
#'     \code{Hmisc} package.
#' @param fpc Logical. Default FALSE. If TRUE, finite population correct (FPC)
#'     is applied.
#' @param pop Population size from which sample has been drawn from. If
#'     \code{fpc} is TRUE, \code{pop} is required.
#'
#' @return A numeric value for sample size required to estimate the required
#'     prevalence/proportion.
#'
#' @examples
#'   # Calculate sample size to estimate a proportion with 95% confidence
#'   # interval, an expected proporition of 50%, precision of 10% and a design
#'   # effect of 2
#'   get_ss_prevalence(z = 1.96, p = 0.5, c = 0.1, deff = 2)
#'
#' @export
#'
#
################################################################################

get_ss_prevalence <- function(z = 1.96, p = 0.5, c = 0.1,
                              deff = 2, fpc = FALSE, pop = NULL) {

  ss <- z ^ 2 * ((p * (1 - p)) / c ^ 2) * deff

  if(fpc == TRUE) {
    ss <- z ^ 2 * ((p * (1 - p)) / c ^ 2)

    ss <- ss * sqrt(((pop - ss) / (pop - 1))) * deff
  }

  return(ss)
}
