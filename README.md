Getting-and-Cleaning-Data-Project-1
===================================
Date: 8/24/2014

Objective: Create two tidy datasets: (1) Mean and standard deviation measurements for subjects and their respective activity based on the test and train datasets, and (2) average of each variable for each activity and each subject, both from the Human Activity Recognition Using Smartphones Dataset.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were recorded. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Dataset 1: Mean and standard deviation for each measurement for each subject and their activity.  

Read in the data from the appropriate working directory. Create a train dataset, using the cbind() function; the first column is the subject, the second is the activity, and the remaining 561 columns correspond to the measurements. 

	setwd("/Users/kristinadang/Documents/Coursera/Getting Data/Project 1/UCI HAR Dataset/train")
	a<-read.table("subject_train.txt")
	b<-read.table("y_train.txt")
	c<-read.table("X_train.txt")
	
	train<-cbind(a,b,c)
	
Create a test dataset, using the cbind() function, the first column is the subject, the second is the activity, and the remaining 561 columns correspond to the measurements. 
	
	setwd("/Users/kristinadang/Documents/Coursera/Getting Data/Project 1/UCI HAR Dataset/test")
	d<-read.table("subject_test.txt")
	e<-read.table("y_test.txt")
	f<-read.table("X_test.txt")
	
	test<-cbind(d,e,f)

Combine the train and test datasets using rbind().
	
	all<-rbind(train, test)

To get the descriptive labels for each of the columns, you need to import the features.txt file from the working directory, and use colnames().

	setwd("/Users/kristinadang/Documents/Coursera/Getting Data/Project 1/UCI HAR Dataset")
	vars<-read.table("features.txt")
	vars1<-vars$V2
	vars2<-as.character(vars1)
	labels<-c("Subject", "Activity", vars2)
	colnames(all)<-labels
	
Now that all the columns are labeled, look for measurements correstponding to mean and standard deviation by using the grep() function.

	extractMean<-all[,grep("mean", colnames(all))]
	extractStd<-all[,grep("std", colnames(all))]
	combined<-cbind(all$Subject, all$Activity, extractMean, extractStd)
	colnames(combined)[1]<-"Subject"
	colnames(combined)[2]<-"Activity"
	
Add descriptive labels to the activities.

	combined$Activity[combined$Activity== "1"] <- "Walking"
	combined$Activity[combined$Activity == "2"] <- "WalkingUpstairs"
	combined$Activity[combined$Activity == "3"] <- "WalkingDownstairs"
	combined$Activity[combined$Activity == "4"] <- "Sitting"
	combined$Activity[combined$Activity == "5"] <- "Standing"
	combined$Activity[combined$Activity == "6"] <- "Laying"
	
Dataset 2: Average of each variable for each activity and each subject. 

Use the aggregate function to accomplish this. Drop the third and fourth columns as they are non-informative for the final dataset.

	average<-aggregate(combined, by = list(combined$Subject, combined$Activity), FUN = mean)
	colnames(average)[1] <- "Subject"
	colnames(average)[2] <- "Activity"
	final<-subset(average,select=-c(3,4))

Export FINAL dataset as a txt file. 

	write.table(final, "q5TidyDataset.txt",row.name=FALSE)


