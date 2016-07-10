# Getting and Cleaning Data - Course Project

## Introduction

This repository contains the files to be submitted for the Course Project "Getting and Cleaning Data" as part of the Data Science Specialisation at Coursera. The following notes outline the sources of data and methodology I used to complete the project.

## Raw Data Set

Data was sourced from the Human Activity Recognition Using Smartphones Dataset which is part of the UCI Machine Learning Repository. It consists of sensor signals (variables) collected when 30 subjects performed different activities. Further information can be found at the following [website](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Contents of Repository

'Readme.md' : explains the analysis

'CodeBook.md' : describes in greater detail the raw data and transformations performed

'run_analysis.R' : script to be run in RStudio

'tidy_data.txt' : an independent tidy data set with the average of each variable for each activity and each subject

## Methodology of Analysis

To collect data from the UCI Machine Learning Repository, transform the data to required specifications and output a tidy data set.

**Contents of 'run_analysis.R'**

To run 'run_analysis.R', open a session in RStudio with the script in the working directory.

The script completes the actions below:
1. Checks that the directory '/UCI HAR Dataset' is in the working directory, if not it downloads and unzips the folder from the [website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

2. Reads in datasets for A) activity labels; B) descriptions of variables collected from the sensor; C) observations for each variable reading (split into training and test subjects); D) which subject the observation was taken from; E) which activity the observation refers to.  

3. Attaches variable names to the observations.

4. Binds the subject to the activity and observation.

5. Combines the training and test data sets.

6. Extracts the required variables from the combined data set.

7. Applies descriptive activity and variable names.

8. Creates the tidy data set per specifications requested.

9. Outputs the tidy data set to 'tidy_data.txt'.

## Tidy Data Set

To read the data set, ensure the file is in the working directory and run the following command in RStudio.
```
data <- read.table("tidy_data.txt", header = TRUE)
View(data)
```
### Why is the data set tidy?

The data set is tidy as it meets the principles of tidy data as described by [Hadley Wickham](https://www.jstatsoft.org/article/view/v059i10/v59i10.pdf).

**Principles**
- Each variable forms a column.
- Each observation forms a row.
- Each type of observational unit forms a table.

In addition, each column has a descriptive heading (read CodeBook.md for more details)

## Code Book

Please read the CodeBook.md file which describes in greater detail the raw data and transformations performed.
