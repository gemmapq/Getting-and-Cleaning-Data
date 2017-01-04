library(dplyr)
library(data.table)
fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip", exdir = getwd())
}

setwd("./UCI HAR Dataset")

#Read train and test data
dataTrain.X <- read.table("./train/X_train.txt")
dataTrain.Subject <- read.table("./train/subject_train.txt")
dataTrain.Y <- read.table("./train/y_train.txt")
dataTest.X <- read.table("./test/X_test.txt")
dataTest.Subject <- read.table("./test/subject_test.txt")
dataTest.Y <- read.table("./test/y_test.txt")

#Read feature and activity labels
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

#Merge data train and label it
dataTrain <- data.frame(dataTrain.Subject, dataTrain.Y, dataTrain.X)

#Merge data test
dataTest <- data.frame(dataTest.Subject, dataTest.Y, dataTest.X)

#Merge all data
mergedData <- rbind(dataTrain,dataTest)
names(mergedData) <- c(c("subject", "activity"), as.character(features$V2))

#Extract data containing mean and std
dataMeanStd <- grep('mean|std', names(mergedData))
dataMeanStd <- mergedData[,c(1,2,dataMeanStd)]
dataMeanStd$activity <- activity_labels$V2[dataMeanStd$activity]

#Set more descriptive names
descriptionNames <- names(dataMeanStd)
descriptionNames <- tolower(descriptionNames)
descriptionNames <- gsub("-","_",descriptionNames)
descriptionNames <- gsub("\\(|\\)","",descriptionNames)
descriptionNames <- gsub("bodybody","body",descriptionNames)
descriptionNames <- gsub("std","standard_deviation",descriptionNames)
descriptionNames <- gsub("acc","_accelerometer",descriptionNames)
descriptionNames <- gsub("gyro","_gyroscope",descriptionNames)
descriptionNames <- gsub("freq","_frequency",descriptionNames)
descriptionNames <- gsub("std","standard_deviation",descriptionNames)
descriptionNames <- gsub("^f","frequency_",descriptionNames)
descriptionNames <- gsub("^t","time_",descriptionNames)
descriptionNames <- gsub("mag","_magnitude",descriptionNames)
descriptionNames <- gsub("jerk","_jerk",descriptionNames)
names(dataMeanStd) <- descriptionNames

#Create a tidy data set with the average of each variable for each activity and each subject

tidyData <- aggregate(dataMeanStd[,3:ncol(dataMeanStd)], by = list(activity = dataMeanStd$activity, subject = dataMeanStd$subject),FUN = mean)
write.table(x = tidyData, file = "tidyData.txt", row.names = FALSE)
