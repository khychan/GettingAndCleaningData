# Getting and Cleaning Data - Course Project

## Code Book

This Code Book should be read after the 'README.md' file located in the same repository for submission pertaining to the Course Project "Getting and Cleaning Data" as part of the Data Science Specialisation at Coursera.

## Raw Data Set

Data was sourced from the Human Activity Recognition Using Smartphones Dataset which is part of the UCI Machine Learning Repository. It consists of sensor signals (variables) collected when 30 subjects performed different activities. Further information can be found at the following [website](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on his/her waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The following text files were used from the '/UCI HAR Dataset' folder which was downloaded from this [website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

'activity_labels.txt': Links the numbers (1 to 6) for the observations in 'y_train.txt' and 'y_test.txt' with their activity name (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

'features.txt': Describes the readings taken when subjects were carrying out their activities (561 in total).

'train/X_train.txt': Training set of observations for each reading (7352 observations x 561 readings).

'train/y_train.txt': Training set of activity labels (7352 observations of activities (1 to 6)).

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. (7352 observations of subjects with range 1 to 30). 

'test/X_test.txt': Test set of observations for each reading (2947 observations x 561 readings).

'test/y_test.txt': Test set of activity labels (2947 observations of activities (1 to 6)).

'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. (2947 observations of subjects with range 1 to 30).

## Methodology

The 'run_analysis.R' script takes the following steps to transform the Raw Data Set to an interim Tidy Data Set.

1. Checks that the directory '/UCI HAR Dataset' is in the working directory, if not it downloads and unzips the folder from the [website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

2. Reads in datasets for A) activity labels; B) descriptions of variables collected from the sensor; C) observations for each variable reading (split into training and test subjects); D) which subject the observation was taken from; E) which activity the observation refers to.  

  **Mapping to tables in R**
  'activity_labels.txt': activityLabels 
  
  'features.txt': features
  
  'train/X_train.txt': XTrain
  
  'train/y_train.txt': yTrain
  
  'train/subject_train.txt': subjectTrain
  
  'test/X_test.txt': XTest
  
  'test/y_test.txt': yTest
  
  'test/subject_test.txt': subjectTest 

3. Attaches variable names to the observations.

  'features' was applied as column names for 'XTrain' and 'XTest'.

4. Binds the subject to the activity and observation.

  New datasets 'trainData' and 'testData' were column binded e.g. for the training set, bind the subject number 'subjectTrain' to the activity number 'yTrain' and the readings 'XTrain'.

5. Combines the training and test data sets.

  Use a row bind to combine the training and test datasets in previous step.

6. Extracts the required variables from the combined data set.

  Now there are two extra columns due to the column bind in step 4, apply the column names "Subject" and "Activity" to the first and second columns respectively.

  The instructions require only the mean and standard deviations to be extracted. This was interpreted as requiring only columns where either mean() or std() featured as these are statistical summaries of the underlying readings. Other instances of 'mean' do not feature a 'std' paired reading.

  The 'filteredData' set was the result.

7. Applies descriptive activity and variable names.

  Activity numbers in "Activity" column were matched with that in 'activityLabels' and the descriptive names (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) were applied to the 'filteredData' set.

  From the information provided in the UCI documentation, 't' refers to 'Time' and 'f' refers to 'FFT' or Fast Fourier Transform. These were transformed in the data set.

  '-mean()-' and '-std()-' were simplified to '.mean.' and '.std.'.
  
  '-mean()' and '-std()' were simplified to '.mean' and '.std'.

  A check was performed in R using
  ```
  table(is.na(filteredData))
  ```
  to ensure no NAs were present.

8. Creates the tidy data set per specifications requested.

  The tidy data set calls for the average of each variable for each activity and each subject.

  This can be achieved by taking means of the 'filteredData' set grouped by 'Subject' and 'Activity'.

  A check was performed in R using 
  ```
  aggregate(filteredData[,3] ~ Subject + Activity, data=filteredData, FUN=mean)
  ```
  to test respective averages by groupings.

9. Outputs the tidy data set to 'tidy_data.txt'.

## Format of Tidy Data

180 observations of Subject, Activity plus the average of readings in 66 columns featuring either mean() or std() in the original data set.

Subject numbers ranges from 1 to 30.

Activity includes the following 6 descriptors (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
