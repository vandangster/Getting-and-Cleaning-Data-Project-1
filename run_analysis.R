setwd("/Users/kristinadang/Documents/Coursera/Getting Data/Project 1/UCI HAR Dataset/train")
a<-read.table("subject_train.txt")
b<-read.table("y_train.txt")
c<-read.table("X_train.txt")

setwd("/Users/kristinadang/Documents/Coursera/Getting Data/Project 1/UCI HAR Dataset/test")
d<-read.table("subject_test.txt")
e<-read.table("y_test.txt")
f<-read.table("X_test.txt")

train<-cbind(a,b,c)
test<-cbind(d,e,f)
all<-rbind(train, test)

setwd("/Users/kristinadang/Documents/Coursera/Getting Data/Project 1/UCI HAR Dataset")
vars<-read.table("features.txt")
vars1<-vars$V2
vars2<-as.character(vars1)
labels<-c("Subject", "Activity", vars2)
colnames(all)<-labels

extractMean<-all[,grep("mean", colnames(all))]
extractStd<-all[,grep("std", colnames(all))]
combined<-cbind(all$Subject, all$Activity, extractMean, extractStd)
colnames(combined)[1]<-"Subject"
colnames(combined)[2]<-"Activity"

combined$Activity[combined$Activity== "1"] <- "Walking"
combined$Activity[combined$Activity == "2"] <- "WalkingUpstairs"
combined$Activity[combined$Activity == "3"] <- "WalkingDownstairs"
combined$Activity[combined$Activity == "4"] <- "Sitting"
combined$Activity[combined$Activity == "5"] <- "Standing"
combined$Activity[combined$Activity == "6"] <- "Laying"

average<-aggregate(combined, by = list(combined$Subject, combined$Activity), FUN = mean)
colnames(average)[1] <- "Subject"
colnames(average)[2] <- "Activity"
final<-subset(average,select=-c(3,4))
