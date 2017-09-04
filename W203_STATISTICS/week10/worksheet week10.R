
setwd("C:/Users/K/Desktop/Berkeley/00_Academics/W203 STATS/week10")
set.seed(898)

# y = 1 + 0.5 * x + u

# generate x values
x = rnorm(100, 10, 5)

# generate errots
u = rnorm(100, 0, 1)

# generate y values
y = 1 + 0.5 * x + u

plot(x, y, main = "Simulated Data from Linear Population Model")

# use lm to fit a linear model

(simmodel1 = lm(y ~ x))

# output: intercept 0.7754, coefficients for x is 0.5187

summary(simmodel1)$r.square

# notice that the r-squared for our regression is .835.
# interpretation is that 83.5% of the variation in our y is
# explained by our x variables
# the rest of the variation comes from our error

# examine the residuals

u_hat = simmodel1$residuals
head(cbind(u, u_hat))

# u_hat are similar to the erros, but they are not the same
# our residuals are our estimates of the errors

plot(x, u_hat, main = "Residual versus Predictor Simulated Data")

##################################################################
# part 2:

load("GPA1.rdata")
ls()

desc

head(data)

# our model looks like
# colGPA = beta_0 + beta_1 ACT + u

summary(data$ACT)
hist(data$ACT, breaks = 16:36 - 0.5,
     main = "HIstogram of ACT scores", xlab = NULL)

summary(data$colGPA)
hist(data$colGPA, breaks = 20, main = "Histogram of College GPA",
     xlab = NULL)

plot(jitter(data$ACT), jitter(data$colGPA), xlab = "ACT score",
     ylab = "college GPA", main = "College GPA verus ACT score")

# fit the linear model
(model1 = lm(colGPA ~ ACT, data = data))
abline(model1) ## abline!

# slope coefficient 0.02706
# interpretation: each additional point on the ACT is associated
# with .027 more GPA points
# A student that scores 4 points higher would be expected to have
# a GPA just over 0.1 points higher

summary(model1)$r.square

# the R-square is 0.04275: the interpretaion is that just 4.3% of 
# the variation in GPA can be explained by ACT score.



###################################################################################


library(BSDA)
attach(Gpa)
summary(Gpa)
hist(HSGPA) 
hist(CollGPA)
Y <- CollGPA
x <- HSGPA

cor(x, Y)



model = lm(Y~ x)

mean(x)
mean(Y)

b1 <- sum((x- mean(x))*(Y-mean(Y)))/ sum((x-mean(x))^2)
mean(Y) - b1 * mean(x)
    
plot(x, Y)
abline(model,col="blue",lwd=2)


u_hat = model$residuals
summary(model)$r.square

(cor(x, Y)) ^2


cor(u_hat, x)

var(model$fitted.values)/var(Y)

tmp1 <- rnorm(10, 0, 10)
model2 <- lm(Y~x+tmp1)

summary(model2)$r.square

y_out <- c(Gpa$CollGPA, 1.5)
x_out <- c(Gpa$HSGPA,3.4)
cor(x_out,y_out)
model_out <- lm(y_out ~ x_out)


x_nl<-seq(-25,25,1)
y_nl<-x_nl^2+rnorm(51,0,100)
plot(x_nl,y_nl)



