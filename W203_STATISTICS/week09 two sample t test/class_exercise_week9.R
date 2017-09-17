setwd("C:/Users/K/Desktop/Berkeley/00_Academics/01_2017 Summer/W203 STATS/week09")
#closeAllConnections()
#rm(list=ls())

data = read.csv("united_states_senate_2014_v2.csv")
summary(data)
head(data)

#######################################################################################################
# Room 1: Is there a difference between the amount of money a senator raises and the amount spent? ####
#######################################################################################################

# dependent test --------------------------------------------------------------------------
# There is a clear pairing in this case. 
# Each senator corresponds to one measurement of money raised and one of moeny spent

# step 1: hypothesis is that there is no difference between the amount of money spent 
# and raised for a senator

# step 2: Make sure that test's assumption are met
# confirmed a normality for the difference in two vectors

raised  = data$Campaign.Money.Raised..millions.of...
spent = data$Campaign.Money.Spent..millions.of...
diff = raised - spent

hist(diff, breaks = 50) # confirm normality of the difference

# step 3: check the statistical significance

t.test(raised, spent, paired = T)

# or 

t.test(diff)


##########################################################################################################
# Room 2: Do female Democratic senators raise more or less money than female Republican senators? ########
##########################################################################################################

### step 1: State hypothesis
# this is not paired well and sample size is small. Let's use Wilcoxon rank-sum test
# null hypothesis is there is no difference between two group means
                                               
table(data$Party)
### step 2: Confirm assumptions:
library(dplyr)
female_democrat_sen = data %>%
  filter(Party == 'Democrat', Gender == 'Female') %>% 
  select(Campaign.Money.Raised..millions.of...)
# this is only 16 samples

class(female_democrat_sen)

hist(female_democrat_sen$Campaign.Money.Raised..millions.of..., breaks = 20)

female_republican_sen = data %>%
  filter(Party == 'Republican', Gender == 'Female') %>% 
  select(Campaign.Money.Raised..millions.of...)
# this is only 4 samples

hist(female_republican_sen$Campaign.Money.Raised..millions.of..., breaks = 20)

# step 3: Check the statistical significance:
wilcox.test(Campaign.Money.Raised..millions.of... ~ Party, data = data[data$Gender == "Female",])

########################################################################################################
# Room 3: Do protestant Senators spend more or less money than non-protestant senators? ################
########################################################################################################

### step1: state hypothesis
# there is no difference between two group means
# the two groups are not paird and sample sizes are large enough, thus do independent t-test

### step2: confirm assumptions

table(data$Religion) # Protestant, # non-Protestant
protestant_spend = data$Campaign.Money.Spent..millions.of...[data$Religion == 'Protestant']
nonprotestant_spend = data$Campaign.Money.Spent..millions.of...[data$Religion != 'Protestant']

hist(protestant_spend, breaks = 20)
hist(nonprotestant_spend, breaks = 20)

### step3: check the statistical significance

t.test(protestant_spend, nonprotestant_spend)

t.test(data$Campaign.Money.Spent..millions.of... ~ data$Religion == "Protestant")



########################################################################################################
# Room 4: Does the NRA prefer male senators or female senators? ########################################
########################################################################################################



