### Problem 3 -----------------------------------------------------------------------
base <- seq(0, 1, 0.001)
length(base)
p.base <- rep(1/1001, 1001)

a1 <- sample(base, size = 100000, prob = p.base, replace = T)
a2 <- sample(base, size = 100000, prob = p.base, replace = T)

samples <- data.frame(a1, a2)
samples$x <- ifelse(samples$a1 > samples$a2, samples$a1, samples$a2)
samples$y <- ifelse(samples$a1 > samples$a2, samples$a2, samples$a1)
samples$xy <- samples$x * samples$y

plot(samples$x, samples$y)


e.x <- mean(samples$x)
e.y <- mean(samples$y)
e.xy <- mean(samples$xy)
cov(samples$x, samples$y)


### Problem 4 -----------------------------------------------------------------------
# e. n = 100, plot X, Y and cacluate D1, D2, ,,,Dn
base <- seq(-1, 1, 0.01)
length(base)
p.base <- rep(1/201, 201)

x.values <- sample(base, size = 100, prob = p.base, replace = T)
y.values <- sample(base, size = 100, prob = p.base, replace = T)

samples <- data.frame(x.values, y.values)
samples$xy <- samples$x.values^2 + samples$y.values^2
samples$d.values <- 0
samples$d.values[samples$xy < 1] <- 1

plot(samples$x.values, samples$y.values, col=samples$d.values+1, asp=1)

mean(samples$d.values)
pi/4 # 0.7853982
3/4

#g. replicate this 10,000 times -----------------------------------------------
# store the mean each time

samples.trials <- c()
for (i in 1:10000) {
  x.values <- sample(base, size = 100, prob = p.base, replace = T)
  y.values <- sample(base, size = 100, prob = p.base, replace = T)
  
  samples <- data.frame(x.values, y.values)
  samples$xy <- samples$x.values^2 + samples$y.values^2
  samples$d.values <- 0
  samples$d.values[samples$xy < 1] <- 1
  samples.trials[i] = mean(samples$d.values)
}

mean(samples.trials) # 0.776976

# plot the histogram of the sample means --------------------------------------
hist(samples.trials, breaks = 20)

#h. calcualte the standard deviation of the sample mean ------------------------
sd(samples.trials)

#i. calculate the fraction of samples averages that are larger than 3/4 ---------
sum(sapply(samples.trials, function(x) {ifelse( x > 3/4, 1, 0)}))/10000
