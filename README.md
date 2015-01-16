# GettingCleaningData_CourseProject
***
CourseRA course project for Getting and Cleaning Data by Jeff Leek
based on data collected and made publicly availabl by
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
***
##Data
These data were extracted from a larger data set provided by the study authors. The following description is derived from their ReadMe file. 

The authors conducted a study with 30 volunteers, aged 19-48 years of age, who performed six activities (Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing, Lying) while wearing a Samsung smartphone. The original data were partitioned randomly to training and test sets; these data sets are merged in the current R program.

The current R program extracts only a subset of the original data, selecting only those variable names (described in the authors' original "features.txt") that ended with mean() or std().

The extracted data includes accelerometer and gyroscope signals that were measured in the time and frequency domains, whose source consisted of body or gravity forces that were standardized so as to represent deviations from a mean (no units). The authors report that signal magnitudes were derived in time to obtain jerk signals or according to the Euclidean norm; both magnitude types were extracted.

The extracted data set is collapsed over subjectNumber and activityName and contains the following variables: analysisDomain - time or frequency based
dataSource - body or gravity
tool - gyroscope or accelerometer
magnitude - jerkmagnitude (derived in time) or magnitude (Euclidean)
dependentMeasure - mean and standard deviation
value - the standardized data averaged over subjectNumber and activityNam
***
##Script
*Warning: My R code is inelegant! I have never taken computer programming and the only R I know is what I learned in the CourseRA R programming course. I know that my code is not efficient or elegant. But it does accomplish the course goals of retrieving, manipulating, cleaning, and tidying data. Sorry if it is painful to read! Feedback, tips, and pointers are very welcome.*

Script name **run_analysis.R**
>This script does the following.
* Checks for the UCI HAR Dataset folder with its subfolders and downloads the folder if not found
* Sets file paths to point the program to the data within the UCI HAR Dataset folder
* Creates R structures into which the data is read - Data is read from activity_labels.txt, features.txt, test/Y_test.txt, test/X_test.txt, subject_test.txt, train/subject_train.txt, X_train.txt, y_train.txt
* Adds column labels (from features.txt) to describe each measure in the training (X_train) and test (X_test) data sets; adding the labels earlier rather than later is intended to facilitate later binding
* Uses the data from y_train.txt and y_test.txt respectively, to add a column to the training and test files; this column contains the code for each measured activity
* Names this added column "activityName"
* Uses the data from subject_train.txt and subject_test.txt respectively, to add a column to the training and test files; this column contains the respective subject numbers
* Names this added column "subjectNumber"
* #Part3: Uses the activity_labels.txt file to map meaningful activity labels onto the activity codes contained in the "activityName" column created earlier in the train and test sets of data. This satisfies the third project requirement by ensuring that there are descriptive names (e.g., Walking) instead of numbers (e.g., 1) to indicate activity
* Part1: Merges the training and test sets to create one dataset. This satisfies the first project requirement which requires that these two data sets be combined. I used rbind to accomplish this merge
* Part2: Extracts the measurements on the mean and standard deviation of each measurement. This satisfies the second part of the project requirement, but did require some interpretation.
+Interpretation - I selected only measures that listed an overall mean() or overall std() at the end of the column name. I did not retain any variables that measured on the X,Y,Z axes, presuming that the measures without axis labels were combined over these axes and therefore of greater relevance for future analyses. I thus retained means and standard deviations on each measure, presuming that the measures of relevance were the composite measures and not the raw axis data. I understood from the course forum that there was latitude in the interpretation of the instruction and that so long as our extraction focused on mean and standard deviation data.
* Part4: Performed a series of substitutions to replace the column names with more meaningful descriptors that eliminated abbreviations (e.g., "Acc" was changed to "Accelerometer") and removed R-incompatible field separators. This satisfies the forth requirement of the course project by giving meaningful names to the variables. The original names that I modified were drawn from the features.txt file. I retained the structure of these labels but expanded the abbreviations to ful names and removed parentheses and dot separators.
* Part5: Creates a tidy data set by melting the merged data, separating the variables into columns, and aggregating over these columns. This satisfies the final requirement of the project by creating a data set in which the data consists of an average of each of my selected variables for each activity and each subject. In accordance with tidy data principles
 + each variable measured is in one column, 
 + each different observation (as a function of subject number and activity name) is on one row, 
 + there is one table for this one kind of data (Samsung), 
 + there is a row at the top of the tidy data file that contains variable names,
 + data is saved with one file per table

***
##Code to open TidyData

>To open the tidyData that was created using this script, use the following command in R:
read.table ("tidyData_tt.txt", header=TRUE)

***
##Original full data set
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##Full description of original data set
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

***
###Thanks for reviewing and grading my project!!
