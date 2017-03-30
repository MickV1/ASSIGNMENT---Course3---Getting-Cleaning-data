# ASSIGNMENT---Course3---Getting-Cleaning-data

> # Downloading and unzipping dataset
> if(!file.exists("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse"))
+         {dir.create("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse")}
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> 
> # When you are naming your file:
> # You have to put the extension: .zip beacuse you are downloading the zip file
> download.file(fileUrl,destfile="/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
==================================================
downloaded 59.7 MB

> 
> # Unzip dataSet to your /data directory
> unzip(zipfile="/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse.zip",
+ exdir="/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse")
> 
> # 1) Merging the training and the test sets to create one data set
> 
> # Reading trainings tables:
> x_train <- read.table("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/train/X_train.txt")
> y_train <- read.table("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/train/y_train.txt")
> subject_train <- read.table("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/train/subject_train.txt")
> 
> # Reading testing tables:
> x_test <- read.table("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/test/X_test.txt")
> y_test <- read.table("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/test/y_test.txt")
> subject_test <- read.table("/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/test/subject_test.txt")
> 
> # Reading the "features" vector:
> features <- read.table('/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/features.txt')
> 
> 
> # Merging all data into a single set:
> colnames(x_train) <- features[,2] 
> colnames(y_train) <-"activityId"
> colnames(subject_train) <- "subjectId"
> 
> colnames(x_test) <- features[,2] 
> colnames(y_test) <- "activityId"
> colnames(subject_test) <- "subjectId"
> 
> mrg_train <- cbind(y_train, subject_train, x_train)
> nrow(mrg_train)
[1] 7352
> mrg_test <- cbind(y_test, subject_test, x_test)
> nrow(mrg_test)
[1] 2947
> setAllInOne <- rbind(mrg_train, mrg_test)
> 
> # Verify that the number of rows is the sum of the above 2 sets
> nrow(setAllInOne)
[1] 10299
> # Verify
> head(colnames(setAllInOne),3)
[1] "activityId"        "subjectId"         "tBodyAcc-mean()-X"
> 
> 
> # 2) Extracting only the measurements of the mean and standard deviation 
> # for each measurement
> 
> # Reading the column names:
> colNames <- colnames(setAllInOne)
> 
> # Create the vector for extracting ID, mean and the standard deviation:
> mean_and_std <- (grepl("activityId" , colNames) | 
+                          grepl("subjectId" , colNames) | 
+                          grepl("mean.." , colNames) | 
+                          grepl("std.." , colNames) 
+ )
> 
> # Making the subset from: setAllInOne:
> setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
> 
> 
> # 3) Using descriptive activity names to name the activities in the data set:
> # Reading activity labels:
> activityLabels = read.table('/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/UCI HAR Dataset/activity_labels.txt')
> colnames(activityLabels)
[1] "V1" "V2"
> 
> # Hence,you have to assign the NEW column names:
> colnames(activityLabels) <- c('activityId','activityType')
> colnames(activityLabels)
[1] "activityId"   "activityType"
> activityLabels
  activityId       activityType
1          1            WALKING
2          2   WALKING_UPSTAIRS
3          3 WALKING_DOWNSTAIRS
4          4            SITTING
5          5           STANDING
6          6             LAYING
> # Reorder columns in "activityLabels"
> e <-activityLabels[, c(2,1)]
> 
> Data <- merge(e,setForMeanAndStd, 
+               by='activityId',
+               all.x=TRUE)
> # Verify
> head(colnames(Data,1))
[1] "activityId"        "activityType"      "subjectId"         "tBodyAcc-mean()-X"
[5] "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z"
> ncol(Data)
[1] 82
> # Using the descriptive activity names to name the activities in the data set
> # (hence delete the "activityId" column )
> Data$activityId <-NULL
> # Verify
> head(colnames(Data,1))
[1] "activityType"      "subjectId"         "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"
[5] "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" 
> ncol(Data)
[1] 81
> 
> 
> # 4) Appropriately label the data set with descriptive variable names
> 
> head(colnames(Data,3))
[1] "activityType"      "subjectId"         "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y"
[5] "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" 
> names(Data)<-gsub("^t", "time", names(Data))
> names(Data)<-gsub("^f", "frequency", names(Data))
> names(Data)<-gsub("Acc", "Accelerometer", names(Data))
> names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
> names(Data)<-gsub("Mag", "Magnitude", names(Data))
> names(Data)<-gsub("BodyBody", "Body", names(Data))
> 
> head(colnames(Data,3))
[1] "activityType"                   "subjectId"                     
[3] "timeBodyAccelerometer-mean()-X" "timeBodyAccelerometer-mean()-Y"
[5] "timeBodyAccelerometer-mean()-Z" "timeBodyAccelerometer-std()-X" 
> 
> # Creating a second, independent tidy data set with the average of each variable 
> # for each activity and each subject
> 
> # Making second tidy data set
> library(plyr)
> secTidySet <- aggregate(. ~subjectId + activityType, Data, mean)
> secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityType),]
> head(colnames(secTidySet),8)
[1] "subjectId"                      "activityType"                  
[3] "timeBodyAccelerometer-mean()-X" "timeBodyAccelerometer-mean()-Y"
[5] "timeBodyAccelerometer-mean()-Z" "timeBodyAccelerometer-std()-X" 
[7] "timeBodyAccelerometer-std()-Y"  "timeBodyAccelerometer-std()-Z" 
> 
> 
> # Export the tidyData set into the text file
> # Notice the DIFFERENCE between bellow 2 text files 
> # (check the folder assignment_getandcleandatacourse):
> # Please upload your data set as a txt file created with write.table() using row.name=FALSE 
> # (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission)
> 
> write.table(secTidySet, '/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/tidyDataT.txt',row.names=TRUE,sep='\t')
> 
> # To prevent row names being written to a text file (this is what we want):
> write.table(secTidySet, '/Users/marinaz/Desktop/R STUDIO FILES/Getting_Cleaning_data/assignment_getandcleandatacourse/tidyDataF.txt',row.names=FALSE,sep='\t')
