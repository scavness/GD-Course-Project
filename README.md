# GD-Course-Project
Course Project for the Coursera Getting and Cleaning Data Class

# Introduction
The purpose of this project was to work with a real dataset and create tidy data based on it. I worked with the data from the UCI Machine Learning Repository at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Reading in the data
The data used in this assignment has been pulled from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script assumes you have unzipped the folder from the source above to your working directory to pull in the data, manipulate it, and create a "tidy.txt" of the summarized data.

# How it works

The first thing the script does is test if you have the package 'dplyr' installed, installs it for you if not, and then reads in the dplyr package for later.

All the data is then read in using read.table pasting the default folder names from the downloaded data.

Rbind is used to combine the xtest and xtrain data in a single table. I used the names from the features file to name them at this point for simplicity's sake. 

I then used grep to find all the columns containing mean or std and stored those in the variable mean_std_dat. Viewing the features_info.txt file this seems to correctly gather all of the mean and standard deviation measurements from the data. This leaves me with 79 columns as opposed to the original 561.

I then gather the activity and subject data and convert them into the data frames 'namestotal' and 'ytotal' which are then combined with the mean_std_dat via cbind for 81 columns in all_data. 

At this point I convert the merged data into a tbl_df so I can utilize dplyr for the final analysis. I grouped the data by Activity and then Subject. This was used with the summarize_each(funs(mean)) function to determine the average measurement of each activity for each subject. 

Finally, the data is written to a "tidy.txt" file and I used rm() to get rid of the local data used in the analysis.

# Data format and reasoning

The final file provides the average values for each measurement on each subject by activity. From the top it starts with the activity Laying and provides the values for each Subject in order from 1:30 and repeates for each activity (a total of 180 rows for the 6 activites). 

The column names are unchanged from the source although they provide the average of the values by subject rather than individual measurements 

The column names with 't' denote time captured at a rate of 50Hz

The column names with 'f' indicated that a Fast Fourier Transform was applied to the frequency domain signals.

'XYZ' indicate the axial directions measured by the accelerometer and gyroscopes used with the experiment.

Gyro: Readings from the Gyroscope
Acc: Readings from the Acceleromter

Variable names, from the features_info.txt in the UCI Har Dataset:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

Where:

* mean(): Mean value
* std(): Standard deviation
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency


# Conclusion

The run_analysis.R scipt produces a 'tidy.txt' file that provides the summarized measurements for each user in the "Human Activity Recognition Using Smartphones Data Set" for each activity performed. Each variable name is the mean of the measurements taken

If the file is in the active R directory, it can be read in using: 

tidy_data <- read.table(paste(getwd(),"/tidy.txt",sep=""), header = TRUE)
