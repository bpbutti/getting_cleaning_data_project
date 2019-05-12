# `run_analysis.R` script
This script does the following things

  1. Loads the libraries and functions from the `libs_and_funs.R` script

  1. Downloads and unzips the data to be analized

  1. Loads the files `activity_labels.txt` and `features.txt` from the folder `.\data_course_project\UCI HAR Dataset`

  1. Loads the files `subject_test.txt`, `X_test.txt`, and `y_test.txt` from the folder `.\data_course_project\UCI HAR Dataset\test`

  1. Loads the files `subject_train.txt`, `X_train.txt`, and `y_train.txt` from the folder `.\data_course_project\UCI HAR Dataset\test`

  1. Bind the columns from X, subject, and y for both train and test data in two separate data frames `train_df` and `test_df`

  1. Bind the rows from `train_df` and `test_df` in a single df names `train_test_df` which now gather all the train and test data

  1. Renames the columns of `train_test_df` based on the names in the `features.txt`, and renames the column with the sujects and y data as `subjects` and `activity`, respectively

  1. Changes the values in the `activity` column from numbers, to text that matches the relation in the `activity_labels.txt`
  2. Selects only the columns that contain "mean" or "std" in its name, also selects the subject and activity columns
  3. Groups the data by subject and activity and summarizes it calculating the mean for each column, and saves it in a new data frame `train_test_summary_df`

# `libs_and_funs` script

This script has the libraries used in the `run_analysis.R` script, and also a function called `download_file_curl` whihc is used to download the data
