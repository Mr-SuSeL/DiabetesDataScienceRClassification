# https://www.kaggle.com/datasets/mathchi/diabetes-data-set
library(dplyr)
library(class) #knn
library(ggplot2)
#install.packages('skimr')
library(skimr)

cukrzyca <- read.csv("diabetes.csv")
head(cukrzyca)

cukrzyca %>% is.na() %>% sum()
length(cukrzyca)
skim(cukrzyca)

# all zeros replace by NA's without Outcome
df <- cukrzyca[-9] # minus outcome column
df[df == 0] <- NA
skim(df)

 # All NA replace by mean value of each column
for(i in 1:ncol(df)){
  df[is.na(df[,i]), i] <- mean(df[,i], na.rm = TRUE)
}

skim(df)



































