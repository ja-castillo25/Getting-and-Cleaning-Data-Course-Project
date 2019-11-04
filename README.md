# Getting and Cleaning Data Final Project

First, we download the data from  this [url](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) given by the instructors, the we create the run_analysis.R file to:

0) Download the data and create a special directory for the project

1) Load the train and test data and joined them with `rbind()` and calling it "dataset"

2) read the features.txt to name the variables in the dataset

3) Load the activities data from y_train.txt and y_test.txt and merging them, then with the activity_labels.txt we named and put the corresponding labels to the activities with `match()` finally we added the column to the dataset.

4) We change some of the column names from the dataset to be more readeble, using `gsub()`

5) Finally with dplyr library, we group the activities and the subjects (adding the subject variable in the dataset) and we calculate the mean and saving it in a new data frame called Tidy, and we write a table with the tidy data frame.
