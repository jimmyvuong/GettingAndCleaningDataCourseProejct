
## 1. Merges the training and the test sets to create one data set.
## Assume you have downloaded the data, unzipped, and current working directory is "UCI HAR Dataset"

## create file path since data exists in multiple directories, use root of directory
file_path <- file.path("./")

## Load Activty Test/Train dataset
activity_test_data  <- read.table(file.path(file_path, "test" , "Y_test.txt" ),header = FALSE)
activity_train_data <- read.table(file.path(file_path, "train", "Y_train.txt"),header = FALSE)

## Load Subject Test/Train dataset
subject_test_data <- read.table(file.path(file_path, "test", "subject_test.txt"),header = FALSE)
subject_train_data <- read.table(file.path(file_path, "train", "subject_train.txt"),header = FALSE)

## Load Features Test/Train dataset
features_test_data  <- read.table(file.path(file_path, "test" , "X_test.txt" ),header = FALSE)
features_train_data <- read.table(file.path(file_path, "train", "X_train.txt"),header = FALSE)

## Union the datasets for activity, subject, and train
activity_data <- rbind(activity_test_data, activity_train_data)
subject_data <- rbind(subject_test_data, subject_train_data)
features_data <- rbind(features_test_data, features_train_data)

## Assign names to variables for easy reading
names(activity_data) <- c("activity")
names(subject_data) <- c("subject")
features_name_data <- read.table(file.path(file_path, "features.txt"),head=FALSE)
names(features_data)<- features_name_data$V2

## Combine activity, subject, and features data into one dataset
all_data <- cbind(subject_data, activity_data)
all_data <- cbind(features_data, all_data)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features_names_mean_std_data <- features_name_data$V2[grep("mean\\(\\)|std\\(\\)", features_name_data$V2)]
mean_std_names <- c(as.character(features_names_mean_std_data), "subject", "activity" )

## subset the data for only the mean and standard deviation 
all_data <- subset(all_data, select = mean_std_names)


## 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table(file.path(file_path, "activity_labels.txt"),header = FALSE)


## 4. Appropriately labels the data set with descriptive variable names. 
## rename the names in combined dataset
names(all_data)<-gsub("^t", "time", names(all_data))
names(all_data)<-gsub("^f", "frequency", names(all_data))
names(all_data)<-gsub("Acc", "accelerometer", names(all_data))
names(all_data)<-gsub("Gyro", "gyroscope", names(all_data))
names(all_data)<-gsub("Mag", "magnitude", names(all_data))
names(all_data)<-gsub("BodyBody", "body", names(all_data))


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Load library "plyr" and output tidy data
library(plyr);
output_data <- aggregate(. ~subject + activity, all_data, mean)
output_data <- ouput_data[order(output_data$subject, output_data$activity),]
write.table(output_data, file = "output_tidy_data.txt", row.name=FALSE)
