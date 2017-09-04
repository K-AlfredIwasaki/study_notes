# setwd("C:/Users/K/Desktop/Berkeley/00_Academics/01_2017 Summer/W203 STATS/week1")
# closeAllConnections()
# rm(list=ls())

?log # show a help page for log
log(100, base = 10)
args(log) # show arguments for log

x = 5
y = 10

objects() # show what are the objects in the workspace

# bascis of a vector

c(2, 3, 4, 3) # this is a vector
1:4 # this is also a vector
4:-1 
seq(2, 8, by = 2) # this is a vector: 2 4 6 8
seq(0, 1, by = 0.1)
seq(0, 1, length = 11)

x = c(2, 3, 4, 5)
x
x/2

summary(x) # get the summary such as Min, Median, Quantile,...

y = c(1, 2, 3, 4)

# it's vectorized! Essentially it means element by element
x + y

x * y

z = c(1, 2)

x + z # even this works although x is length 4, z is length 2. z is cycled through

x + c(1, 2, 4) # this doesn't work

names = c("Paul", "Coye", "Steve", "Andy")

paste(names, collapse = "**") # this produces "Paul**Coye**Steve**Andy"


# logical vectors
TRUE
FALSE

v = c(T, T, F, T)
v

x > 4 # FALSE FALSE FALSE  TRUE

x %% 3 == 0 # FALSE  TRUE FALSE FALSE

!v # FALSE FALSE  TRUE FALSE

sum(v) # TRUE as 1 and FALSE as 0

sum(!v)

### warning ############################
###  a vector has to be all one time ###

c(x, 3)
c(x, "a") # all the integers in the vector x are turned into a string


# 1.10 Indexing and Functions --------------------------------------------------------------------------

x
x[1] # this is acutally the first element, not the second
x[2]
length(x)
x[length(x)]

x[c(1,2)] # get the first two vectors

x[1:3]

x[4:1] # super easy way to reverse vectors

x[-1] # show everything except the first

x[-c(1, 2)]

x[c(T, T, F, F)]

v # this is TRUE  TRUE FALSE  TRUE

x[v]

x > 3 # this creates a logical vector

x[x > 3]

x[x >= 3]

x[x == 4]

x[x != 4]

# and, or operator

x[x >= 4 & x %% 2 == 0]

x[x >= 4 | x %% 2 == 0]


w = c(2, 3, 4, 5, 6)

w * 2 

# demonstration of functions

add1 = function(x) x + 1

add1(w)

rescale = function(x) {
  upper = max(x)
  lower = min(x)
  (x - lower) / (upper - lower)
}

rescale(w)

objects()

#quit()

##############################################################################################

# factors

chef = c("Coye", "Deirdre", "Judd", "Anno", "Steve")
spiciness = c("Medium", "Mild", "Hot", "Hot", "Medium")

class(spiciness)


sp = factor(spiciness)
(sp = factor(spiciness)) ### small trick: adding () enables to diplay the factor that just converted


# under the hood, R numbers all the different categories,
# then stores an integer for each observation

as.numeric(sp)

levels(sp)

# if don't like the order of levels,

(sp = factor(sp, levels = c("Mild", "Medium", "Hot")))

(sp = factor(spiciness, levels = c("Mild", "Medium", "Hot")))

levels(sp) = c("Mild", "Spicy", "Extra Spicy")
sp

as.numeric(sp)

(sp = factor(spiciness, levels = c("Mild", "Medium", "Hot"),
             labels = c("Mild", "Spicy", "Extra Spicy")))

########################################################################################################

# a common error with factors

rating = c(5, 6, 3, 5, " ")
rating

r = factor(rating)

r

mean(r)

mean(as.numeric(r)) # this throws completely wrong number

as.numeric(r)

levels(r)

levels(r)[r]
as.numeric(levels(r)[r])


######################################################################################################

chef = c("Coye", "Deirdre", "Judd", "Anno", "Steve")
spiciness = c("Medium", "Mild", "Hot", "Hot", "Medium")
score = c(5, 6, 3, 5, 5)

Chilli = data.frame(chef, spiciness, score)
Chilli

head(Chilli)

summary(Chilli) # generic function

Chilli = data.frame(cook = chef, spiciness, rating = score)
Chilli

names(Chilli)[3]
names(Chilli)[3] = "score1"
summary(Chilli)
names(Chilli)

Chilli$Score2 = c(4, 3, 3, 4, 5)
Chilli

setwd("C:/Users/K/Desktop/Berkeley/00_Academics/01_2017 Summer/W203 STATS/week1")
getwd()

load("Chilli.RData")


Chili = read.csv("Chili.csv")
head(Chili)
summary(Chili)

levels(Chili$score1)

Chili = read.table("Chili.csv", sep = ",", header = TRUE)

summary(Chili)

as.numeric(levels(Chili$score1)[Chili$score1]) # fix NA

(score1.fixed = as.numeric(levels(Chili$score1)[Chili$score1]))
Chili$score1 = score1.fixed
summary(Chili)


(Chili = read.table("Chili.csv", sep = ",", header = TRUE,
                   na.string = "na"))


Chili$mean_score = (Chili$score1 + Chili$score2) /2
Chili

(grand_mean = mean(Chili$mean_score, na.rm = TRUE))

var(Chili$mean_score, na.rm = TRUE) 
sd(Chili$mean_score, na.rm = TRUE) # standard deviation

hist(Chili$mean_score, main = "Mean Score for Chili Contestants",
     xlab = "mean score")

plot(Chili$score1, Chili$score2, main = "Score1 and Score2 for Chili")

Chili$above_av = Chili$mean_score >= grand_mean
Chili

########################################################
# Indexing Data Frames

Chili[2, 1] # row, column
Chili[1, "cook"]
Chili[2:5, c(3, 4)] # gettting subdata

Chili[1, ] # all the first row
Chili[, c("spiciness", "mean_score")]

Chili[ Chili$above_av == T, c(2, 5)]
Chili[ Chili$spiciness %in% c("Medium", "Hot"),]

########################################################
# Attach

attach(Chili)

score1 + score2 # don't need to write Chili



































