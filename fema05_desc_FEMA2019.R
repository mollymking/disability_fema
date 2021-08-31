# project:	Disability and Information about Climate Disaster
# task:     Basic descriptives
# github:   fema_disability
# author:   Molly King & Brooke Rose

# --- Load packages ---
library("tidyverse")  #contains ggplot2

# --- Descriptives by Income Level ---

# Unweighted count of how many answered the question per income level
svyby(~infoPrep, ~d13, design = nhsw, FUN = unwtd.count, na.rm = TRUE)
# Proportion consumed information by income level
svyby(~infoPrep, ~d13, design = nhsw, FUN = svymean, na.rm = TRUE)

#Can also do for several questions at once: e.g., info and confidence, function of income
RQs_income <- svyby(~infoPrep+c2, ~d13, design = nhsw, FUN = svymean, na.rm = TRUE)
RQs_income <- as.data.frame(RQs_income)


#What proportion of each income category reported information?
info_inc <- svyby(~infoPrep, ~d13, nhsw, svymean, na.rm = TRUE)
#format as data frame and remove error columns
info_inc <- as.data.frame(info_inc)
info_inc_rounded <- round(info_inc, digits = 4)
#write_csv(info_inc_rounded, path = "results/info_inc")

#create new column with income categories spelled out
incomes <- c("Under $60", "$60 to $499", "$500 to $999", "$1,000 to $1,999", "$2,000 to $2,999", "$3,000 to $3,999", "$4,000 to $4,999", "$5,000 to $7,499", "$7,500 to $9,999", "$10,000 to $14,999", "$15,000 to $19,999", "$20,000 and over", "Don't know", "Refused")
info_inc$income <- incomes


#visualizations
#dot plot
ggplot(data = info_inc, mapping = aes(x = d13, y = infoPrep)) +
  geom_point() + 
  labs(title = "Proportion of respondents reporting reading, seeing, or hearing info about preparation for disaster", 
       x = "Income Category", y = "", color = "Proportion Reporting Information")

#Bar chart code for an individual question
ggplot(data = info_inc, mapping = aes(x = d13, y=infoPrep)) +
  geom_col() 







plot_income_proportion <- ggplot2(data = income, x = income, aes(fl))