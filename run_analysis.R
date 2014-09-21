################################################################
##
## Get data for Course Project
##  Getting and Cleaning Data
## Download a zip file and unzip it properly into specified
##   directories
## September 2014
################################################################
### Clean out data and other functions first
rm(list=ls())

################################################################
## Some libraries - 
################################################################
## loaded a bunch for various exercises
library(sqldf)
library(httr)
library(httpuv)
library(RCurl)
library(plyr)
library(Hmisc)
library(reshape2)
library(dplyr)
library(tidyr)
##############################################################
### get the data
##############################################################
urlname<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=urlname, destfile="./projectClass2.zip")
downLoaddate<-date()
filename<-"./projectClass2.zip"
if (!file.exists("projectdat")){
      dir.create("projectdat")
}
### UNZIP the data into projectdat
unzip(filename, exdir="./projectdat")

##############################################################
## Useful way to scan directories and get a list of files
## This would not automate well in cases where you can add/modify
##   directories or files!! 
##############################################################
directories<-list.dirs(path="./projectdat",   full.names=TRUE)
num<-length(directories)
direct<-list.files(directories[1:num], full.names=TRUE)
#direct

##############################################################
## Read in the identifying pieces - y vectors are activity
##  flags. Do NOT reorder these!
## Activity levels are the decodes for activity flags
##############################################################
y_train<-read.table(direct[33], sep="\t")
y_test<-read.table(direct[19], sep="\t")
activity_labels<-read.table(direct[2], header = FALSE, sep = " ",
                            stringsAsFactors = F, fill = T)
namesact<-c("label", "activity")
names(activity_labels)<-namesact
## here are the subject numbers###############################
## DO NOT REORDER THESE EITHER ###############################
subj_train<-read.table(direct[31], sep="\t")
subj_test<-read.table(direct[17], sep="\t")

#############################################################
## get features - THESE ARE THE ROW LABELS ##################

features<-read.table(direct[3], header = FALSE, sep = " ",
                     stringsAsFactors = F, fill = T)
#############################################################
## get the actual data - checking on use of read.table
## these were space delimited not tab
#####################################
## CAREFUL! Use sep="" NOT sep=" "
#####################################

x_train<-read.table(direct[32], header = FALSE, sep = "",
                    stringsAsFactors = F, fill = T)
x_test<-read.table(direct[18], header = FALSE, sep = "",
                   stringsAsFactors = F, fill = T)
#########################################################
#########################################################
### PART 1: Merge test and training data 
### 
#########################################################

train<-cbind(subj_train, y_train, x_train)
test<-cbind(subj_test, y_test, x_test)

bigdat<-rbind(train,test)
mynames<-c("subject","label", features[,2])
names(bigdat)<-mynames
#rm(mynames)
#########################################################
### ABOVE IS BEGINNING of PART 4
### labeled all my columns - easier to subset
### it may be nice to label them better after I process
### the averages
#########################################################
### PART 2: Select just the columns where there are  
###   means or std
#########################################################
###### identify columns that have means or std
###### Do this step one at a time so you get proper columns
## include these
## do NOT forget to add 2 for SUBJNO and LABEL!!!

myvec<-c(grep("mean", features[,2]),grep("std", features[,2]))
myvec<-myvec+2
srt<-order(myvec)
myvec<-myvec[srt]
myvec
##### subsetting bigdat using my positional list
smallerdat<-bigdat[, c(1,2,myvec)]
#names(smallerdat)
###I do not want these - remove
myvec2<-grep("meanFreq", names(smallerdat))
smallerdat<-smallerdat[,-c(myvec2)]
names(smallerdat)

#myMeans<-grep("gravityMean", features[,2]) did not pick
#########################################################
### PART 3: NOW MERGE ACTIVITY LABEL   
###          Data has been properly merged and subset
#########################################################
smallerdat<-merge(smallerdat, activity_labels, by.x="label", by.y="label")
#table(smallerdat$activity,smallerdat$label)

#########################################################
### PART 4 and 5: Create meaningful column names  
###        Use PLYR package to reduce the data to average
###        values within activity for each subject
#########################################################
dim(smallerdat)
smallerdat$subject<-as.factor(smallerdat$subject)

### YAY! This simple syntax in DDPLY seems to work!!
df <- ddply(smallerdat, .(subject, activity), colwise(mean))
df<-df[,-c(3)]         #remove label
names(df)

##########################################################
## Finally - using a function in tidyr - I have a very tall
##  result
## I LIKE standardized data

mydat<-df %>% gather(Measures, AverageVal, -subject, -activity)
mydat<-arrange(mydat, subject,activity, Measures)
head(mydat,100)

##########################################################
##########################################################
## as per course instruction, write.table using row.name=FALSE
## contains a line of code to show how to read the data
##   back in from the text file

write.table(mydat, file="mytidydat.txt", row.names=FALSE, sep="")
check<-read.table("./mytidydat.txt", sep = "", header=TRUE,
                  fill=T)
###########################################################
