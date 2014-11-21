# Introduction

The script `run_analysis.R`
- downloads the data for this project from
  [Cloudfront](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
- merges the training and test sets to create one data set
- extracts only the measurements on the mean and standard deviation
  for each measurement
- replaces `activity` values in the dataset with descriptive activity names
- appropriately labels the columns with descriptive names
- creates a second, independent tidy dataset with an average of each variable
  for each each activity and each subject. In other words, same type of
  measurements for a particular subject and activity are averaged into one value
  and the tidy data set contains these mean values only. The processed tidy data
  set is also exported as csv file.
  
# The original data set

The original data set is split into training and test sets (70% and 30%,
respectively) where each partition contains:
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject  

# Getting and Cleaning data

Once download the zip file, unzip it and store in the R working directory. Under 
'UCI HAR Dataset' folder, there are test and train folders, along with 'activity label' and 'features' text file. 
- 'activity label' links the 6 activity number with activity name, it will be used in 'activity' replacement.
- 'features' lists 561 features, it will be used as column names for full data set

First step of processing is to merge the X_train and X_test files. There are 10,299 instances where each instance contains 561 features. After
appending subject_test, subject_train and y_test, y_train, the table contains 563 columns (561 measurements, subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

Next, labels the data set with descriptive variable names by using subject identifier.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. 10299 instances are split into 180 groups (30
subjects and 6 activities) and 66 mean and standard deviation features are
averaged for each group. The resulting data table has 180 rows and 68 columns.
The tidy data set is exported to `tidy.csv`.