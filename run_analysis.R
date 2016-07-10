## Code for Getting and Cleaning Data Course Project
## Written by khychan on 10 JUL 2016

## initialise library
library(dplyr)

# download and unzip folder if it does not exist in working directory
dir.name <- "./UCI HAR Dataset"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
smartphoneDataZip <- "./smartphoneData.zip"

# Check if the data is downloaded and if not, download and unzip the file
if (!dir.exists(dir.name)) {
        download.file(url,destfile = smartphoneDataZip)
        unzip(smartphoneDataZip)
        file.remove(smartphoneDataZip)
}

## read data in

# activity labels [6:2] includes descriptions of activities
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# features [561:2] includes descriptions of various readings off the activities
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# x.train [7352:561] has readings
XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")

# y.train [7352,1] has labels [1 to 6]
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

# subject.train [7352,1] has subject numbers [1 to 30]
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# x.test [2947:561] has readings
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt")

# y.test [2947,1] has labels [1 to 6]
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")

# subject.test [2947,1] has subject numbers [1 to 30]
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## clean and tidy data

# attach column names with features dataset
names(XTrain)=features
names(XTest)=features

# bind subject numbers with activity numbers and readings dataset
trainData <- cbind(subjectTrain,yTrain,XTrain)
testData <- cbind(subjectTest,yTest,XTest)

# combine training and test datasets
combinedData <- rbind(trainData,testData)

# replace column names for Subject and Activity numbers
names(combinedData)[1] <- "Subject"
names(combinedData)[2] <- "Activity"

# select only required columns (Subject, Activity, variables with mean() or std())
selectVariables <- c(1:2,as.numeric(grep("(mean|std)[(]",names(combinedData))))
filteredData <- combinedData[,selectVariables]

# replace activity numbers with descriptive activity names
filteredData$Activity <- activityLabels[match(filteredData$Activity,activityLabels$V1),2]

# replace column names with descriptive variable names or tidy names
names(filteredData) <- gsub("tBody","Time.Body",names(filteredData),fixed=TRUE)
names(filteredData) <- gsub("tGravity","Time.Gravity",names(filteredData),fixed=TRUE)
names(filteredData) <- gsub("fBody","FFT.Body",names(filteredData),fixed=TRUE)
names(filteredData) <- gsub("fGravity","FFT.Gravity",names(filteredData),fixed=TRUE)

names(filteredData) <- gsub("-mean()-",".Mean.",names(filteredData),fixed=TRUE)
names(filteredData) <- gsub("-std()-",".Std.",names(filteredData),fixed=TRUE)
names(filteredData) <- gsub("-mean()",".Mean",names(filteredData),fixed=TRUE)
names(filteredData) <- gsub("-std()",".Std",names(filteredData),fixed=TRUE)

## create tidy dataset
tidyData <- filteredData %>%
        group_by(Subject, Activity) %>%
        summarise_each(funs(mean))

## write tidy data to file
write.table(tidyData, file = "./tidy_data.txt", row.names = FALSE)

