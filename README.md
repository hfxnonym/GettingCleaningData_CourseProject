# GettingCleaningData_CourseProject

CourseProject
##Scripts
1)  run_analysis.R
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
##Interpretation - I selected only measures that listed an overall mean() or overall std() at the end of the column name. I did not retain any variables that measured on the X,Y,Z axes, presuming that the measures without axis labels were combined over these axes and therefore of greater relevance for future analyses. I thus retained means and standard deviations on each measure, presuming that the measures of relevance were the composite measures and not the raw axis data. I understood from the course forum that there was latitude in the interpretation of the instruction and that we had license to interpret the instruction accordingly.
* Part4: Performed a series of substitutions to replace the column names with more meaningful descriptors that eliminated abbreviations (e.g., "Acc" was changed to "Accelerometer") and removed R-incompatible field separators. This satisfies the forth requirement of the course project by giving meaningful names to the variables. The original names that I modified were drawn from the features.txt file. I retained the structure of these labels but expanded the abbreviations to ful names and removed parentheses and dot separators.
* Part5: Creates a tidy data set by melting the merged data, separating the variables into columns, and aggregating over these columns. This satisfies the final requirement of the project by creating a data set in which the data consists of an average of each of my selected variables for each activity and each subject. In accordance with tidy data principles
*1) each variable measured is in one column, 
*2) each different observation (as a function of subject number and activity name) is on one row, 
*3) there is one table for this one kind of data (Samsung), 
*4) there is a row at the top of the tidy data file that contains variable names,
*5) data is saved with one file per table
