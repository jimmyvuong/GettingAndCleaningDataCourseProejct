###Introduction
The script run_analysis.R performs steps 1-5 from the Course Project.

* Step 1 - merges the training and test datasets for activity, subject, and features 
by using the `rbind()` function to union the results of each respective dataset.
After the datasets have been created, we provide friendly names to each column 
in the respective data sets.  Once this is complete, we combine the data into 
one by using the `cbind()` function.
* Step 2 - extract only the means and standard deviation measurements by subsetting 
our dataset we combined in step 1.
* Step 3 - obtain the descriptive names for the activity dataset by looking at the 
activity_labels.txt file
* Step 4 - renamed the combined dataset with friendly names
* Step 5 - output the data to a tidy data set


###Variables
* `activity_test_data`, `activity_train_data`, `subject_test_data`, `subject_train_data`, 
`features_test_data`, and `features_train_data` contain the data from the downloaded files.
* `activity_data` is the union data for activity test and train.
* `subject_data` is the union data for subject test and train.
* `features_data` is the union data for features test and train.
* `all_data` is the combined data from `activity_data`, `subject_data`, and `features_data`.
`features_names_mean_std_data` contains a vector of the mean and standard deviation 
measurement we are interested in.
* `activity_lables` contains the decriptive lables for the activities data set
* `output_tiday_data.txt` is the text file output using the `write.table()` function 
from plyr package for all subject and activity and their appropriate mean and standard deviation measurements.
