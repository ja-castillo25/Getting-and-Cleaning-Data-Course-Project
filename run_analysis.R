#0)
#Downloading the data:

setwd("~/Trabajos R/Coursera3")

if(!file.exists("~/Trabajos R/Coursera3/Datasets.zip")){
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = '~/Trabajos R/Coursera3/Datasets.zip')
unzip("Datasets.zip")
}

#1)
#Merging the data:

#Train data:
train<-read.table('./UCI HAR Dataset/train/X_train.txt')


#Test data:
test<-read.table('./UCI HAR Dataset/test/X_test.txt')

#Merging the test and train data to create the dataset:

dataset<-rbind(train,test)

#adding the column names to 'dataset'

features <- read.table('./UCI HAR Dataset/features.txt')

colnames(dataset)<-features[,2]

#2)
#Extracting the measurements of the mean y std

data_mean_std<-dataset[,grep("mean|std",colnames(dataset))]

#3)
#Loading the activities variable:

ActivityTrain<-read.table('./UCI HAR Dataset/train/y_train.txt')
ActivityTest<-read.table('./UCI HAR Dataset/test/y_test.txt')
Activity<-rbind(ActivityTrain,ActivityTest)
colnames(Activity)<-"ActivityId"

#Loading the labels of activity (What each number means)

Labels<-read.table('./UCI HAR Dataset/activity_labels.txt')
colnames(Labels)<-c("ActivityId","Label")

#Adding ActivityLabel variable in Activity:

Activity$ActivityLabel<-Labels[match(Activity$ActivityId,Labels$ActivityId),"Label"]

data_mean_std<-cbind(data_mean_std,ActivityLabel=Activity$ActivityLabel)

#4)
#Changing variables name with descrptive names
colnames(data_mean_std)
colnames(data_mean_std)<-gsub("-","",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("mean\\(\\)","Mean",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("std\\(\\)","StandardDeviation",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("meanFreq\\(\\)","MeanFrequency",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("^[Tt]","Time",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("^[Ff]","frequency",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("Acc","Accelometer",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("Gyro","Gyroscope",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("Mag","Magnitude",colnames(data_mean_std))
colnames(data_mean_std)<-gsub("BodyBody","Body",colnames(data_mean_std))

#5)
#Resume of mean by activity and subject
library(dplyr)
SubjectTrain<-read.table('./UCI HAR Dataset/train/subject_train.txt')
SubjectTest<-read.table('./UCI HAR Dataset/test/subject_test.txt')
Subject<-rbind(SubjectTrain,SubjectTest)
colnames(Subject)<-"SubjectId"

data_mean_std<-cbind(data_mean_std,Subjects=Subject$SubjectId)

Tidy <- data_mean_std %>% group_by(ActivityLabel,Subjects) %>% summarise_all(mean)

write.table(Tidy, "TidyData.txt", row.name=FALSE)
