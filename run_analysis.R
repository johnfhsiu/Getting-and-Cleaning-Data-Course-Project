##download data##
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "D:/Users/user/Desktop/R/assignment.zip")
dataall<-unzip("D:/Users/user/Desktop/R/assignment.zip")
list(dataall)

##read and convert data##
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

data_train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
data_train_activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data_train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

data_train <-  data.frame(data_train_subject, data_train_activity, data_train_x)
names(data_train) <- c(c('subject', 'activity'), features)

data_test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data_test_activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data_test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data_test <-  data.frame(data_test_subject, data_test_activity, data_test_x)
names(data_test) <- c(c('subject', 'activity'), features)

##1. Merges the Training and Testing Sets into 1 data set called data.all##
data.all <- rbind(data_train, data_test)

##2. Extracts only the measurements on the mean and standard deviation for each measurement.##
mean_std_select <- grep('mean|std', features)
data_sub <- data.all[,c(1,2,mean_std_select + 2)]

##3. Uses descriptive activity names to name the activities in the data set##
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
data_sub$activity <- activity_labels[data_sub$activity]

##4. Appropriately labels the data set with descriptive variable names.##
name.new <- names(data_sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data_sub) <- name.new

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.##
data_tidy <- aggregate(data_sub[,3:81], by = list(activity = data_sub$activity, subject = data_sub$subject),FUN = mean)
write.table(x = data_tidy, file = "D:/Users/user/Desktop/R/data_tidy.txt", row.names = FALSE)
