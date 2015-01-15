# GettingCleaningData_CourseProject

CourseProject
##Scripts
1)  run_analysis.R
>This script does the following.
* Checks for the UCI HAR Dataset folder with its subfolders and downloads the folder if not found
* Records the download date, working directory, and R version
* Sets file paths to point the program to the data
* Creates R structures into which the data is read
* Adds column labels that describe each measure into the training and test data sets to facilitate later binding
* Adds and names a column to the training and test files to indicate the activity measured
* Adds and names a column that contains the subject number associated with each line of data in each dataset
* #Part3: Gives meaningful activity labels to the train and test sets of data (e.g., Walking)
* #Part1: Merges the training and test sets to create one dataset
* #Part2: Extracts the measurements on the mean and standard deviation of each measurement
##Interpretation - I selected only measures that listed an overall mean() or overall std() at the end of the column name. I did not retain any variables that measured on the X,Y,Z axes, presuming that the measures without axis labels were combined over these axes and therefore of greater relevance for future analyses.
* #Part4: Performed a series of substitutions to replace the column names with more meaningful descriptors that eliminated abbreviations (e.g., "Acc" was changed to "Accelerometer") and removed R-incompatible field separators
* #Part5: Creates a tidy data set by melting the merged data, separating the variables into columns, and aggregating over these columns
