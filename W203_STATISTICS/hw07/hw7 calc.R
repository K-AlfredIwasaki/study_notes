
### class exercise  - maximum likelihood - poisson

obs = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 17, 42, 43)
freq = c(1392, 1711, 914, 468, 306, 192, 96, 56, 35, 17, 15, 6, 2, 2, 1, 1)
x <- rep(obs, freq)
plot(table(x), main="Count data")

lik.poisson <- function(x, lambda) lambda^x/factorial(x) * exp(-lambda)

log.lik.poisson <- function(x, lambda) {
  -sum(x * log(lambda) - log(factorial(x) - lambda))
}

optim(par = 2.0, log.lik.poisson, x = x, method = "Brent", lower = 2.0, upper = 3.0)$par

