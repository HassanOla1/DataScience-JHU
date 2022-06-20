# Download and extract data
filename <- "projectfiles_UCI_HAR_Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists(filename)) {
  download.file(fileURL, destfile = filename)
  unzip(filename)  
}
library(data.table)
library("dplyr")
library(reshape2)
# Read in the data from files
#Imports features.txt
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
#Imports activity_labels.txt
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
#Imports train
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
#Imports test
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)

colnames(features) <- c("id", "feature")
colnames(activity_labels) <- c("labels", "activityN")
colnames(subject_train) <- "subject"
colnames(y_test) <- "activity"
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]
colnames(subject_test) <- "subject"
colnames(y_train) <- "activity"

# Create the final training set by merging y_train, subject_train, and x_train
training <- bind_cols(x_train,subject_train,y_train)
# Create the final training set by merging y_test, subject_test, and x_test
testing <- bind_cols(x_test,subject_test,y_test)
# merge training and test data to create a final data set
Mdata <- bind_rows(training,testing)
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extracted_data <- select(Mdata, subject,activity, grep(".*mean.*|.*std.*", names(Mdata), ignore.case=TRUE,value=TRUE))


# 3. Use descriptive activity names to name the activities in the data set
extracted_data$activity <- activity_labels[extracted_data$activity, 2]

#4 Appropriately labels the data set with descriptive variable names
names(Mdata)<-gsub("^t", "time", names(Mdata))
names(Mdata)<-gsub("^f", "frequency", names(Mdata))
names(Mdata)<-gsub("Acc", "Accelerometer", names(Mdata))
names(Mdata)<-gsub("Gyro", "Gyroscope", names(Mdata))
names(Mdata)<-gsub("BodyBody", "Body", names(Mdata))
names(Mdata)<-gsub("Mag", "Magnitude", names(Mdata))
names(Mdata)<-gsub("tBody", "TimeBody", names(Mdata))
names(Mdata)<-gsub("-mean", "Mean", names(Mdata), ignore.case = TRUE)
names(Mdata)<-gsub("-std", "STD", names(Mdata), ignore.case = TRUE)
names(Mdata)<-gsub("-freq", "Frequency", names(Mdata), ignore.case = TRUE)
names(Mdata)<-gsub("\\(\\)", "", names(Mdata))
names(Mdata)<-gsub("\\-", "", names(Mdata))

#5 From the data set in step 4, 
# creates a second, independent tidy data set with the average of each variable for each activity and each subject
extracted_data$subject <- as.factor(extracted_data$subject)
tidydata <- melt(data = extracted_data, id = c("subject", "activity"))
tidydata <- dcast(data = tidydata, subject + activity ~ variable, fun.aggregate = mean)
write.table(tidydata, file = "Tidy.txt", row.names = FALSE)
