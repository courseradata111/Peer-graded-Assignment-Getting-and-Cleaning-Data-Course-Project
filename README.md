# Getting and Cleaning Data Course Project

## Quick Start
To reproduce the final data, clone this repository, then run the following commands.
```
source('run_analysis.R')
get_raw_data() # if you haven't downloaded the original data and unzip it
data <- run_analysis()
write.table(data, file = 'tidy_averaged_data.txt', row.names = FALSE)
```

This repository contains a few files, including:

## README.md
This file. It's a markdown file explaining the contain of this repository.

## run_analysis.R

This is the R script to perform the following tasks.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately label1.s the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## CodeBook.md
This markdown file explains how the data is transformed and cleaned up.