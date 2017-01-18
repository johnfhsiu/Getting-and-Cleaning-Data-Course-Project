Course Project for Coursera Data Science Getting And Cleaning Data

This README aim to explain how the run_analysis.R script works 

The run_analysis.R script aims to accomplish the followings:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Please see run_analysis.R script for detailes, the following will elaborate how to achieve each goals.

Task 1
Downloads and extract raw data
Reads in the X_test.txt, y_test.txt, and subject_test.txt files into data frames and combine columns into one data frame.
Reads in the train data.
Concatenates the rows of the test and train data.


Task 2
Reads the feature labels from features.txt.
Filter the feature labels to only those containing 'mean' or 'std'
Select the columns from the data set that match the selected features.

Task 3
Read in the activity labels and corresponding numeric codes from activity_labels.txt.
Transform the numeric activity column into a factor column

Task 4
Use the gsub command to change the column names.

Task 5
use aggregate command to melt data frame and write into a file