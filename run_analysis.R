##run_analysis.R

##Checks to see if dplyr is installed
 if(!(is.element("dplyr",installed.packages()[,1]))){
    install.packages("dplyr")
}
library(dplyr)

##Optional code to check for, and install the files in the working directory
##Uncomment to use
 #if(!file.exists("./UCI HAR Dataset")){
 #fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
 #temp <- tempfile()
 #download.file(fileUrl, temp)
 #unzip(temp)
 #unlink(temp)
 #}
 
##Reads in all the files from wd
features <- read.table(paste(getwd(),"/UCI HAR Dataset/features.txt",sep=""))
activity <- read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep=""))

xtest <- read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt",sep=""))
ytest <- read.table(paste(getwd(),"/UCI HAR Dataset/test/y_test.txt",sep=""))
test_sub <- read.table(paste(getwd(),"/UCI HAR Dataset/test/subject_test.txt",sep=""))

xtrain <- read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt",sep=""))
ytrain <- read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt",sep=""))
train_sub <- read.table(paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt",sep=""))


##Merges xtest and xtrain data, then names columns
total <- rbind(xtest,xtrain)
names(total) <- features$V2


##Extracts columns containing 'mean' or 'std' in their names
mean_std_dat <- total[,grep("mean|std",names(total))]


##Labels ytrain and ytest data based on activity names
ytest <- activity[,2][ytest$V1]
ytest <- as.data.frame(ytest)
names(ytest) <- "Activity"

ytrain <- activity[,2][ytrain$V1]
ytrain <- as.data.frame(ytrain)
names(ytrain) <- "Activity"

##Merges ydata and names the data frame
ytotal <- rbind(ytest,ytrain)

##Merges test and train subject data and names it
namestotal <- rbind(test_sub,train_sub)
names(namestotal) <- "Subject"


##Adds Activity and Test subject columns to mean and std data
all_data <- cbind(namestotal, ytotal, mean_std_dat)

##Converts all_data into a data frame tbl
tbl_data <- tbl_df(all_data)

##Takes the mean of each measurement and arranges it by Activity and Subject
tidy <- group_by(tbl_data, Activity, Subject) %>% summarise_each(funs(mean))

write.table(tidy, file = "tidy.txt", row.name=FALSE)

##Removes local data created during the script
rm(xtest,ytest,xtrain,ytrain,test_sub,train_sub, 
   mean_std_dat,ytotal,namestotal, total, activity, features
  ,all_data,tbl_data,tidy)