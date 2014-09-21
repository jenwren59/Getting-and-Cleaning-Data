#H2 Code List for run_analysis.R

Unzip the project data file and determine the folder structure. Within the subdirectories there are descriptive files and several data files that will not be used.

Raw data to use includes:
- features.txt - - these are the row labels
- activity_labels.txt - - these are descriptive labels for the "y_train" and "y_test" vectors
- y_train.txt - - these are the activity codes for subjects in the training data set
- y_test.txt - - these are the activity codes for subjects in the test data set
- subject_train.txt - - these are the subject numbers for the training data set
- subject_test.txt - - these are the subject numbers for the test data set


- x_train.txt - - these data are the pre-processed measurements on all subjects for all activities in the training set
- x_test.txt - -  these data are the pre-processed measurements on all subjects for all activities in the test set

Steps used to build the analysis data include:

1. Cbind y_train, subject_train, x_train without any prior steps; this properly attaches the unique keys of subject and activity to the entire set of measures in x_train (n=561 columns in x_train). Do the same for the test data.
2. Rbind the the two data frames in step 1 for training and test data to get one large data frame (nrow=10,299, ncol=563)
3. Provide labels for subject, activity and all the measures in columns 3:563. The labels for the measurements are provided in features.txt.
4. I used "grep" to identify those measures that contain "mean" or "std" in the label and subset the data for these columns only. I purposely choose to omit "meanFreq" and "gravityMean" columns. 
5. Merge the descriptive activity_labels onto the activity code (order is important here. This must be done after the large data is constructed in step 2).
6. Get the average value for each subject within each activity and store the result in a new data frame.
7. Produce a tidy data set from the data frame in step 6. I interpreted this to be a very tall data set. The flat data of 180 rows and 68 columns seemed to contain a variable in the column headers of columns 3:68. Using the "gather" function in tidyr, I created a variable for the column labels of columns 3:68 and output a row foreach with the corresponding value. I ended up with 66 rows for each subject and activity with a final data dimension of 11,880 rows, 4 columns.
8. Ordered the data by subject, activity, then Measures.
9. Write the data to a text file for submission.

Final variables in mytidydat.txt:
subject: levels = 1:30
activity: factor variable with 6 levels (see activity_labels.txt)
Measures: factor variable with 66 levels (direct subset of features.txt see step 4 to produce a list of levels)
AverageVal: the derived average for each measure per subject per activity


