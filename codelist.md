Code List for run_analysis.R

Unzip the project data file and determine the folder structure. Within the subdirectories there are descriptive files and several data files that will not be used.

Raw data to use includes:
- features.txt: these are the row labels
- activity_labels.txt: these are descriptive labels for the "y_train" and "y_test" vectors
- y_train.txt: these are the activity codes for subjects in the training data set
- y_test.txt: these are the activity codes for subjects in the test data set
- subject_train.txt: these are the subject numbers for the training data set
- subject_test.txt: these are the subject numbers for the test data set
- x_train.txt: these data are the pre-processed measurements on all subjects for all activities in the training set
- x_test.txt: these data are the pre-processed measurements on all subjects for all activities in the test set

Steps used to build the analysis data include:

1. Cbind y_train, subject_train, x_train without any prior steps; this properly attaches the unique keys of subject and activity to the entire set of measures in x_train (n=561 columns in x_train). Do the same for the test data.
2. Rbind the the two data frames in step 1 for training and test data to get one large data frame (nrow=10,299, ncol=563)
3. Provide labels for subject, activity and all the measures in columns 3:563. The labels for the measurements are provided in features.txt.
4. I used "grep" to identify those measures that contain "mean" or "std" in the label and subset the data for these columns only. I purposely choose to omit "meanFreq" and "gravityMean" columns. 
5. Merge the descriptive activity_labels onto the activity code (order is important here. This must be done after the large data is constructed in step 2).
6. Get the average value for each subject within each activity and store the result in a new data frame.
7. Produce a tidy data set from the data frame in step 6. I interpreted this to be a very tall data set. The flat data of 180 rows and 68 columns seemed to contain a variable in the column headers of columns 3:68. Using the "gather" function in tidyr, I created a variable for the column labels of columns 3:68 and output a row for each with the corresponding value. I ended up with 66 rows for each subject and activity with a final data dimension of 11,880 rows, 4 columns.
8. Ordered the data by subject, activity, then Measures.
9. Write the data to a text file for submission.

Final variables in mytidydat.txt:
- subject: levels = 1:30
- activity: factor variable with 6 levels
  - "LAYING" 
  - "SITTING"            
  - "STANDING"           
  - "WALKING"
  - "WALKING_DOWNSTAIRS" 
  - "WALKING_UPSTAIRS"
- Measures: factor variable with 66 levels
  - "tBodyAcc-mean()-X"
  - "tBodyAcc-mean()-Y"           
  - "tBodyAcc-mean()-Z"           
  - "tBodyAcc-std()-X"           
  - "tBodyAcc-std()-Y"            
  - "tBodyAcc-std()-Z"            
  - "tGravityAcc-mean()-X"        
  - "tGravityAcc-mean()-Y"       
  - "tGravityAcc-mean()-Z"
  - "tGravityAcc-std()-X"         
  - "tGravityAcc-std()-Y"         
  - "tGravityAcc-std()-Z"        
  - "tBodyAccJerk-mean()-X"       
  - "tBodyAccJerk-mean()-Y"       
  - "tBodyAccJerk-mean()-Z"       
  - "tBodyAccJerk-std()-X"       
  - "tBodyAccJerk-std()-Y"        
  - "tBodyAccJerk-std()-Z"        
  - "tBodyGyro-mean()-X"          
  - "tBodyGyro-mean()-Y"         
  - "tBodyGyro-mean()-Z"          
  - "tBodyGyro-std()-X"           
  - "tBodyGyro-std()-Y"           
  - "tBodyGyro-std()-Z"          
  - "tBodyGyroJerk-mean()-X"      
  - "tBodyGyroJerk-mean()-Y"      
  - "tBodyGyroJerk-mean()-Z"      
  - "tBodyGyroJerk-std()-X"      
  - "tBodyGyroJerk-std()-Y"       
  -"tBodyGyroJerk-std()-Z"       
  - "tBodyAccMag-mean()"          
  - "tBodyAccMag-std()"          
  - "tGravityAccMag-mean()"       
  - "tGravityAccMag-std()"        
  - "tBodyAccJerkMag-mean()"      
  - "tBodyAccJerkMag-std()"      
  - "tBodyGyroMag-mean()"         
  - "tBodyGyroMag-std()"          
  - "tBodyGyroJerkMag-mean()"     
  - "tBodyGyroJerkMag-std()"     
  - "fBodyAcc-mean()-X"           
  - "fBodyAcc-mean()-Y"           
  - "fBodyAcc-mean()-Z"           
  - "fBodyAcc-std()-X"           
  - "fBodyAcc-std()-Y"            
  - "fBodyAcc-std()-Z"            
  - "fBodyAccJerk-mean()-X"       
  - "fBodyAccJerk-mean()-Y"      
  - "fBodyAccJerk-mean()-Z"       
  - "fBodyAccJerk-std()-X"        
  - "fBodyAccJerk-std()-Y"        
  - "fBodyAccJerk-std()-Z"       
  - "fBodyGyro-mean()-X"          
  - "fBodyGyro-mean()-Y"          
  - "fBodyGyro-mean()-Z"          
  - "fBodyGyro-std()-X"          
  - "fBodyGyro-std()-Y"           
  - "fBodyGyro-std()-Z"           
  - "fBodyAccMag-mean()"          
  - "fBodyAccMag-std()"          
  - "fBodyBodyAccJerkMag-mean()"  
  - "fBodyBodyAccJerkMag-std()"   
  - "fBodyBodyGyroMag-mean()"     
  - "fBodyBodyGyroMag-std()"     
  - "fBodyBodyGyroJerkMag-mean()" 
  - "fBodyBodyGyroJerkMag-std()" 
- AverageVal: numeric variable, the derived average for each measure per subject per activity


