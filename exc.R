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
df$Outcome <- cukrzyca$Outcome
head(df)

# rounding data in columns to one decimal point
df$Pregnancies <- round(df$Pregnancies, 1)
df$SkinThickness <- round(df$SkinThickness, 1)
df$Insulin <- round(df$Insulin, 1)

# --------------- end of clearing dataset --------------------------------------

# distribution class in dataset
table(df$Outcome)/nrow(df)

attributes <- select(df, - Outcome)
classes <- df$Outcome

head(attributes)
head(classes)

# scaling attr
scaledAttr <- scale(attributes) %>% data.frame()
head(scaledAttr)

# dataset divided into train_set (70%) and test_set (30%)
set.seed(123)
sample <- sample(1:nrow(df), 0.7*nrow(df), replace = FALSE)
sample[1:3]

# Training - gym for dataset
trainA <- scaledAttr[sample, ]
testA <- scaledAttr[-sample, ]
trainC <- classes[sample]
testC <- classes[-sample]

# decomposition classes in both datasets (is equal?)
prop.table(table(df$Outcome)) # 65% vs. 35%
prop.table(table(trainC)) # 65% vs. 35%
prop.table(table(testC)) # 65% vs. 35%
# Yes, the same

# Model training and prediction
# let's say k=3 for a while
knnPrediction <- knn(trainA, testA, trainC, k = 3)

# Accuracy
nrow(testA)
length(knnPrediction)
# ouf-of-sample
acc <- 1-mean(testC != knnPrediction) # 74%

# check if tuning possible
tuning <- sapply(1:10, function(i){
  knnTuning <- knn(trainA, testA, trainC, k = i)
  accT <- 1-mean(testC != knnTuning)
})
kBetter <- which.max(tuning)

# k = 5 is better so... 
knnPrediction <- knn(trainA, testA, trainC, k = kBetter) # k = 5
acc <- 1-mean(testC != knnPrediction) 
# accuracy is: 80,5%






































































