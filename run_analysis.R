library ("httr") #needed to read urls
library ("dplyr") #needed to manipulate data
library ("plyr") #needed to manipulate data
library ("tidyr") #needed to create tidy data output
library ("reshape2") #needed to create tidy data output

#set for my computer
setwd("~/Desktop/GettingCleaningData/CourseProject")

#check for data folder in working directory and download if not already available
filePath <- "./UCI HAR Dataset"
if (!file.exists (filePath)) {
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file (fileURL, destfile = "temp.zip", method = "curl")
	unzip ("temp.zip", overwrite=FALSE)
	unlink("temp.zip") #remove temporary zip file
}

#Best practices - Record download date, working directory, and r version
dateDownloaded <- date()
wd <- getwd ()
version <- R.Version()

#Set file paths to point the program to the data
trainXPath <- "./UCI HAR Dataset/train/X_train.txt"
trainYPath <- "./UCI HAR Dataset/train/Y_train.txt"
trainSubjectPath <- "./UCI HAR Dataset/train/subject_train.txt"

testXPath <- "./UCI HAR Dataset/test/X_test.txt"
testYPath <- "./UCI HAR Dataset/test/Y_test.txt"
testSubjectPath <- "./UCI HAR Dataset/test/subject_test.txt"

activityLegendPath <- "./UCI HAR Dataset/activity_labels.txt"
featuresPath <- "./UCI HAR Dataset/features.txt"

#Create R structures that contain the data
trainSet <- read.table (trainXPath, header=FALSE
						, fill=TRUE #adds NA to short lines
						, blank.lines.skip=TRUE)  #skips blank lines in the original data file
trainLabels <- read.table (trainYPath, header=FALSE
						, fill=TRUE #adds NA to short lines
						, blank.lines.skip=TRUE)  #skips blank lines in the original data file
trainSubjects <- read.table (trainSubjectPath, header=FALSE)


testSet <- read.table (testXPath, header=FALSE
					   , fill=TRUE #adds NA to short lines
					   , blank.lines.skip=TRUE)  #skips blank lines in the original data file
testLabels <- read.table (testYPath, header=FALSE
						  , check.names=TRUE  #checks variable names for validity and changes as necessary
						  , fill=TRUE #adds NA to short lines
						  , blank.lines.skip=TRUE)  #skips blank lines in the original data file
testSubjects <- read.table (testSubjectPath, header=FALSE)

activityLegend <- read.table (activityLegendPath, header=FALSE)
columnLabels <- read.table (featuresPath, header=FALSE)

#Add column labels into the datasets to facilitate later binding
colLabels <- columnLabels[,2]
colnames(trainSet) <- colLabels
colnames(testSet) <- colLabels

#For my own info, add column into the datasets to identify data source in later binding
trainSet$dataSource <- c("train")
testSet$dataSource <- c("test")

#Add column to each file to indicate the activity measured
trainSet <- cbind (trainLabels, trainSet)
testSet <- cbind (testLabels, testSet)

#Give the added column a label
colnames(trainSet)[1] <- c("activityCode") #note column index is outside the function name
colnames(testSet)[1] <- c("activityCode") #note column index is outside the function name

#Add column to each file to identify the experimental subject number
trainSet <- cbind (trainSubjects, trainSet)
testSet <- cbind (testSubjects, testSet)

#Give the added column a label
colnames(trainSet)[1] <- c("subjectNumber") #note column index is outside the function name
colnames(testSet)[1] <- c("subjectNumber") #note column index is outside the function name

#Add column names to the the activity legend
colnames(activityLegend) <- c("activityCode", "activityName")

#**********************************************************************************************
#Part 3 :  Use descriptive activity names to name the activities in the set
#          NOTE: I am choosing to do this earlier rather than later;
#                labels will be retained after the data sets are collated
#**********************************************************************************************

#Give the activities meaningful labels by merging the data with the activity legend
trainSet <- merge(trainSet, activityLegend, by="activityCode")
testSet <- merge(testSet, activityLegend, by="activityCode")


#**********************************************************************************
#Part 1 :  Merge the training and test sets to create one data set
#**********************************************************************************

allData <- rbind (trainSet, testSet, all=TRUE) #note all=TRUE so that all data are retained
print ("Part 1 confirmed...allData is an R dataframe that contains the merged training and test sets")
	
#**********************************************************************************************
#Part 2 :  Extract only the measurements on the mean and std of EACH MEASUREMENT
#          NOTE: Also need activity names, and subject numbers
#          NOTE: Some warnings are thrown with the merge; checked and OK
#**********************************************************************************************

#Transform data frame to table to use dplyr commands
allData_tbl <- tbl_df (allData)
colNames <- colnames (allData_tbl)

#Eliminate duplicated columns from data set to avoid errors during selection
dupNames <- duplicated(colNames)
allData_tbl <- allData_tbl[,!duplicated(colNames)]

#Select columns that include mean() and std() and that list the associated activity and datasource
#Restrict to OVERALL means and stdevs, and so exclude data broken down by x-y-z axis
selectData <- select (allData_tbl
					  , activityName
					  , subjectNumber
					  , contains ('mean()')
					  , contains ('std()')
					  , -contains("-X")
					  , -contains("-Y")
					  , -contains("-Z")
					) #include only overall means, exclude individual x-y-z axis

print ("Part 2 confirmed...selectData is an R dataframe that contains only the means and standard deviations for each measurement. Note that I interpreted this to mean when collapsed over the axes, such that I excluded the data separated by x, y, and z axes")

#**********************************************************************************************
#Part 3 :  (See above)
#**********************************************************************************************
print ("Part 3 confirmed...descriptive labels were given to the activities earlier in the R program in the trainSet and testSet dataframe and retained in all that followed.")

#**********************************************************************************************
#Part 4 :  Labels the data with descriptive variable names
#**********************************************************************************************
#I don't know the most efficient way to do this...but this works

a <- colnames(selectData)
b <- sub("BodyBody", "Body", a)
c <- sub("tBody", "time-body-", b)
d <- sub("tGravity", "time-gravity-", c)
e <- sub("fBody", "frequency-body-", d)
f <- sub("Acc", "accelerometer-", e)
g <- sub("Gyro", "gyroscope-", f)
h <- sub("Mag", "magnitude-", g)
i <- sub("Jerk", "jerk", h)
j <- sub("mean", "mean", i)
k <- sub("std", "standardDeviation", j)
l <- sub("--", "-", k)
m <- sub("\\(\\)", "", l)

colnames (selectData) <- m

print ("Part 4 confirmed...selectData is an R structure that contains the extracted data, all of which has been renamed with descriptive labels, as per the instruction.")

#**********************************************************************************************
#Part 5 :  Create a second independent tidy data set with the ave of each variable 
#          by activity and subject
#**********************************************************************************************
#Can use melt or gather to accomplish the same thing
meltedData <- melt (selectData
					, id=c("subjectNumber", "activityName")
					, na.rm = FALSE
					, value.name="value")

#gatheredData <- selectData %>%
#	gather(label, value, -subjectNumber, -activityName)

#Separate the columns by splitting on the dash separator
separatedData <- meltedData %>%
	separate(variable, into = c("analysisDomain"
								, "dataSource"
								, "tool"
								, "magnitude"
								, "dependentMeasure"
								), sep = "-") 

separatedData <- arrange(separatedData, subjectNumber, activityName)

tidyData <- aggregate (value 
					   ~ subjectNumber 
					   + activityName
					   + analysisDomain						
					   + dataSource
					   + tool
					   + magnitude
					   + dependentMeasure
					   , separatedData, mean)
write.table (tidyData, file = "tidyData_tt.csv", sep=",")

print ("Part 5 confirmed...tidyData written to csv file")

#To load the created tidyData that this program has created, use the following code in R
#read.csv ("tidyData_tt.csv", header=TRUE, sep=",")
