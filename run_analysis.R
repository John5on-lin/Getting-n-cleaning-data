## Download file from web
furl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname <- "./data/eproj2"
download.file(furl,destfile=fname,method="curl")
###################################
## 1. Merge training and test data
###################################
## build test data
## read x.test
##
x.test <- read.table("./test/X_test.txt",stringsAsFactors = FALSE)
## change column name to feature name
feature <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
colnames(x.test) <- c(feature[,2])
## add subject column
##
tt.subject <- read.table("./test/subject_test.txt",stringsAsFactors = FALSE)
x.test$subject <- c(tt.subject[,1])
## add activity column
##
y.test <- read.table("./test/y_test.txt",stringsAsFactors = FALSE)
x.test$activity <- c(y.test[,1])
## build training data
## read x.train
##
x.train <- read.table("./train/X_train.txt",stringsAsFactors = FALSE)
## change column name to feature name
##
colnames(x.train) <- c(feature[,2])
## add suject column
##
tn.subject <- read.table("./train/subject_train.txt",stringsAsFactors = FALSE)
x.train$subject <- c(tn.subject[,1])
## add activity column
##
y.train <- read.table("./train/y_train.txt",stringsAsFactors = FALSE)
x.train$activity <- c(y.train[,1])
## merge training and test data, make a full dataset
##
data <- rbind(x.test, x.train)
## make the column name unique for later filter
##
names(data) <- make.names(names(data),unique = TRUE)
##
##############################################################
## 2. extract measurement on mean and std for each measurement
##############################################################
## call dplyr filter the mean and standard deviation fields
library(dplyr)
##
## get measurement on the mean for each measurement
sub.mean <- select(data, contains(".mean.."))
## get measurement on the std for each measurement
sub.std <- select(data, contains(".std.."))
##
## combine to the required data
data2 <- cbind(sub.mean, sub.std)
##
##############################################################
## 3. to name the activity in dataset
##############################################################
## add activity back to dataset
activity <- data$activity
data3 <- cbind(activity, data2)
## read activity name from txt
activity.name <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                       stringsAsFactors = FALSE)
## simply hard-code to change the name
data3$activity[data3$activity == 1] <- "WALKING"
data3$activity[data3$activity == 2] <- "WALKING_UPSTAIRS"
data3$activity[data3$activity == 3] <- "WALKING_DOWNSTAIRS"
data3$activity[data3$activity == 4] <- "SITTING"
data3$activity[data3$activity == 5] <- "STANDING"
data3$activity[data3$activity == 6] <- "LAYING"
##
##############################################################
## 4. labels the the data set
##############################################################
## add subject back to dataset
subject <- data$subject
data4 <- cbind(subject, data3)
##
#############################################################
## 5. create tidy data
#############################################################
##
library(plyr)
tidy <- ddply(data4, .(subject, activity), function(x) colMeans(x[,3:68]))
## Write out tidy dataset
write.csv(tidy, "tidy.csv", row.names=FALSE)


