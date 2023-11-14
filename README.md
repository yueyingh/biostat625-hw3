## Overview
ridgeRegression is a fast implementation for multiple linear regression with L2 regularization. It includes no intercept term, and it performs column scaling for the design matrix and response vector. Mathematically, we consider a multiple linear regression:
y = X\beta + \epsilon, where y is an n*1 vector of response variables, X is an n*p design matrix; \beta is a p*1 vector of regression coefficients, and \epsilon is an n*1 vector of random errors. We assume that E(\epsilon) = 0_{n} and Var(\epsilon) = \sigma^2 I_{n}, where 0_{n} is an n*1 vector of zeros and I_{n} is an n*n identity matrix. Our regularization approach to estimating \beta is the ridge regression method, which minimizes the penalized residual sum of squares: (y-X\beta)^{T}(y-X\beta)+\lambda\beta^T\beta, where \lambda > 0 is a pre-specified tuning parameter. The closed form of the ridge regression estimator is given by \beta_{hat} = (X^{T}X + \lambdaI_{p})^{-1}X^{T}y.

## Installation
install.packages("ridgeRegression")

## Usage
Please refer to doc/ridgeRegression.html for example usage or consult function help page.