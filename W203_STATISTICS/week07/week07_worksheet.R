# bernoulli distribution as a special case of 
# the binomial distribution

rbinom(3, size=1, prob=0.5)


# the fair coin -----------------------------------------
# initialize
n = 10
p = 0.5
myvector <- vector("numeric", 10L) 

for(i in 1:1000) {
  myvector[i] <- mean(sample(c(0,1), size=n, prob = c(1-p, p), replace= TRUE))
}

# histogram
hist(myvector, breaks = seq(from = 0, to = 1, by = 0.1))

# standard deviation
sd(myvector)

# a skewed distribution ---------------------------------

library(moments)
skewness(rbinom(100000, size = 1, prob = .001))

# initialize
n = 3
p = 0.001
myvector <- vector("numeric", 10L) 

for(i in 1:1000) {
  myvector[i] <- mean(sample(c(0,1), size=n, prob = c(1-p, p), replace= TRUE))
}

# histogram
hist(myvector, breaks = seq(from = 0, to = 1, by = 0.1))

skewness(myvector)
# skewness less than -1 or greater than 1 is 
# considered substantially skewed


# normal distribution -----------------------------------
---------------------------------------------------------
  
set.seed(898)
?faithful

eruptions = faithful$eruptions
str(eruptions)

hist(eruptions, breaks = 50, xlim=c(1,6))

mean(eruptions)???# 3.49

n1 <- 3
samp1 <- sample(eruptions, size = n1, replace = T)
samp1

# now that we have a sample, we can compute statistics from it
mean(samp1) # sample mean

draws <- replicate(1000, mean(sample(eruptions, size = n1, replace=T))) # replicate command

hist(draws, breaks = 50, xlim=c(1, 6), 
     main = "simulated sample means from repeated sampling")




# t-distribution ----------------------------------------
---------------------------------------------------------
  

setwd("C:/Users/K/Desktop/Berkeley/00_Academics/01_2017 Summer/W203 STATS/week07")
load("sleep.Rdata")
sleep$min


# optimization ------------------------------------------
---------------------------------------------------------
  
f <- function(p) {
  -p^2 + p + 2
}


optimize(f, interval = c(0, 100), maximum = TRUE)





