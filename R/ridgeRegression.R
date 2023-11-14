#' A fast implementation of ridge regression without intercept term
#' @param X A n * p design matrix
#' @param Y A size n vector
#' @param lambdas A size m vector of non-negative values
#' @return A list containing beta for each lambda
#' @examples
#' y = rnorm(100)
#' x = matrix(rnorm(100 * 20), 100, 20)
#' fit = ridgeRegression(x, y, seq(0, 1, 0.1))
#' @export

ridgeRegression <- function(X, Y, lambdas) {
  # Error handling
  stopifnot(is.matrix(X))
  stopifnot(is.vector(Y))
  stopifnot(is.vector(lambdas))
  stopifnot(all(lambdas >= 0))
  stopifnot(nrow(X) == length(Y))
  # Standardize the data
  X = scale(X, T, T)
  Y = scale(Y, T, T)
  coefs = list()
  for(lambda in lambdas) {
    if ((ncol(X) - nrow(X)) > 10^2) {
      # Faster operation if p >> n in X
      U <- chol(tcrossprod(X) + diag(lambda, nrow(X)))
      z <- forwardsolve(U, Y, upper.tri=TRUE, transpose=TRUE)
      beta <- t(X) %*% backsolve(U, z)
      coefs = c(coefs, list(beta))
    } else {
      # Cholesky decomposition can be faster than manually calculating the inverse
      tXY <- crossprod(X, Y)
      U <- chol(crossprod(X) + diag(lambda, ncol(X)))
      z <- forwardsolve(U,tXY,upper.tri=TRUE,transpose=TRUE)
      beta <- backsolve(U,z)
      coefs = c(coefs, list(beta))
    }
  }
  names(coefs) = lambdas
  return(coefs)
}
