library(testthat)
library(MASS)
library(ridgeRegression)

test_that("when n > p", {
  x <- matrix(rnorm(100, 20), 100, 20)
  y <- rnorm(100)
  fit <- ridgeRegression(x, y, 0.5)
  xs <- scale(x, T, T)
  ys <- scale(y, T, T)
  fit_standard <- lm.ridge(ys~xs-1, lambda=0.5*100/99)
  expect_equal(as.vector(fit$`0.5`), as.vector(coef(fit_standard)))
})

test_that("another n > p", {
  x <- matrix(rnorm(500, 10), 500, 10)
  y <- rnorm(500)
  fit <- ridgeRegression(x, y, 0.5)
  xs <- scale(x, T, T)
  ys <- scale(y, T, T)
  fit_standard <- lm.ridge(ys~xs-1, lambda=0.5*500/499)
  expect_equal(as.vector(fit$`0.5`), as.vector(coef(fit_standard)))
})

test_that("when p >> n", {
  x <- matrix(rnorm(10, 200), 10, 200)
  y <- rnorm(10)
  fit <- ridgeRegression(x, y, 0.5)
  xs <- scale(x, T, T)
  ys <- scale(y, T, T)
  fit_standard <- lm.ridge(ys~xs-1, lambda=0.5*10/9)
  expect_equal(as.vector(fit$`0.5`), as.vector(coef(fit_standard)))
})