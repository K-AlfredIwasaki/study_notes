

library(car)
library(lmtest)
library(sandwich)

data = mtcars

# Q1.1: Using the mtcars data, run a multiple linear regression to find the effect of displacement (disp), gross horsepower (hp), weight (wt), 
# and rear axle ratio (drat) on the miles per gallon (mpg).

model1 = lm(mpg ~ disp + hp + wt + drat, data = data)
plot(model1)


# Q1.2: For each of the 6 CLM assumptions, assess whether the assumption holds. 
# Where possible, demonstrate multiple ways of assessing an assumption. 
# When an assumption appears violated, state what steps you would take in response.
 
# 1. Linear population model --- ok

# 2. Random Sampling --- not sure. depending on the data and the collection methods. 

# 3. No perfect multicollinearity --- "perfect". no need to test, because R will throw an error if violated

plot(data$disp, data$hp)
plot(data$hp, data$wt)

# 4. Zero-conditional mean --- E(u|x).  Residuals vs. Fitted. if violated, the OLS estimators are biased. 
# Response: transformation. use EDA to try to isolate cause of the non-linearity.
# 4' exogeniety assumption => 
# for consistency CLM 1-3, CLM 4' exogeniety cov(xj, u) = 0 for all j.

# 5. Homoskedasticity --- Residuals vs. Fitted. thickness of the band
# Scale-Location. Red line reasonably straight
# response - if violated, use robust standard errors

# 6. Normality of Errors --- q-q plot, shapiro wilkes test, look at the residuals directly. large sample => rely on asymptotics
# 

# Q1.3: In addition to the above, assess to what extent (imperfect) multicollinearity is affecting your inference.


# 
# Q1.4 Interpret your slope coefficients, and note which ones are significantly different from zero. 
# Whether or not you detected heteroskedasticity above, be conservative in this step and use robust standard errors.