## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
options(tibble.print_min = 4L, tibble.print_max = 4L)
require(bench)
require(MASS)
library(ridgeRegression)
set.seed(123)

## -----------------------------------------------------------------------------
x <- matrix(rnorm(100 * 20), 100, 20)
y <- rnorm(100)
fit <- ridgeRegression(x, y, 0.5)
fit_standard <- lm.ridge(scale(y, T, T)~scale(x, T, T) -1, lambda = 0.5 * 100 / 99)
all.equal(as.vector(fit$`0.5`), as.vector(coef(fit_standard)))

## -----------------------------------------------------------------------------
result = bench::mark(ridgeRegression(x, y, 0.5),
                     lm.ridge(scale(y, T, T)~scale(x, T, T) - 1, lambda = 0.5*100/99), 
                     check=FALSE)
print(result)

## -----------------------------------------------------------------------------
fit1 <- ridgeRegression(x, y, seq(0, 1, 0.1))
fit1$`0.2`

