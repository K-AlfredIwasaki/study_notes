setwd("C:/Users/K/Desktop/Berkeley/00_Academics/01_2017 Summer/W203 STATS/week09")
#closeAllConnections()
#rm(list=ls())


# 9.13 parametric t-Tests -----------------------------
# -----------------------------------------------------

set.seed(898)
library(effsize)
load("elem94_95.RData")

head(Schools)

# desc contains descriptions of each variable
desc

# the bs variable represents the benefits-to-salary ratio

summary(Schools$bs)
hist(Schools$bs, breaks = 50,
     main = "Histrogram of Benefits-to-Salary Ratio",
     xlab = NULL)

# look at the data points points with unusually high bs ratios
head(Schools[order(Schools$bs, decreasing = T), ])

head(Schools[ order(Schools$avgsal), ])

# create a binary variable to represent schools with 
# a high benefits-to-salary ratio

Schools$ben = factor(ifelse(Schools$bs > mean(Schools$bs),
                            "high benefits", "low benefits"))

summary(Schools$ben)

# examine the math4 variable
desc

summary(Schools$math4)
hist(Schools$math4, breaks = 50, 
     main = "Percentage of Students Passing Math Exam",
     xlab = NULL)

# t.test for two samples --- independent t-test ------------------
# ----------------------------------------------------------------

t.test(math4 ~ ben, data = Schools)

# same thing
high_bs_scores = Schools$math4[Schools$ben == "high benefits"]
low_bs_scores = Schools$math4[Schools$ben == "low benefits"]


t.test(high_bs_scores, low_bs_scores)

# interpret the reuslt
# t is high, p-value is very small => reject null

by(Schools$avgsal, Schools$ben, mean)

cohen.d(math4 ~ ben, data = Schools)

cor(Schools$math4, as.numeric(Schools$ben)) # fairly small correlation


##########################################################
# smaller samples

small_samp = Schools[sample(nrow(Schools),25), ]
summary(small_samp)


hist(small_samp$math4, breaks = 20, 
     main = "Math Passing Rate in Small Sample", xlab = NULL)

qqnorm(small_samp$math4, 
       main = "Normal Q-Q Plot for Math Exam Passing Rate")

# Wilcoxon rank-sum test --------------------------------
#--------------------------------------------------------

wilcox.test(math4 ~ ben, data = Schools)

# p-value is small. reject the null hypothesis


#########################################################

# first, we'll examine the means directly
c(mean(Schools$math4), mean(Schools$story4))

hist(Schools$story4 - Schools$math4, breaks = 50,
     main = "Difference Passing Rates for Reading and Math",
     xlab = "reading passing rate minus math passing rate")

# dependent samples t-test ---------------------------------
# ----------------------------------------------------------

t.test(Schools$math4, Schools$story4, paird = T)

t.test(Schools$math4, Schools$story4, paird = F)


