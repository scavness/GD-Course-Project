##run_analysis.R

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


##Adds Activity and Test subject columns to test and train data
total$Activity <- ytotal
total$Subject <- namestotal



##Removes data from before the merge
rm(xtest,ytest,xtrain,ytrain,test_sub,train_sub)
