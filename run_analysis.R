source("libs_and_funs.R")

# Defines the subfolder where the data will be downloaded
# and creates it if it does not exists
input_data_folder <- "input_data"

if(!file.exists(input_data_folder)){
   dir.create(input_data_folder)
}

# Downloads data
file_name <- "accelerometers_data"
file_extension <- "zip"
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
download_file_curl(input_data_folder, file_name, file_extension, file_url)

# UNZIP Data
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

unzip(zipfile = file_path, junkpaths = FALSE, exdir = input_data_folder)

# Load features (columns) names
input_data_folder <- file.path("input_data",
                               "UCI HAR Dataset")
file_name <- "features"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

features_names <- fread(file_path)

# Load activities labels
input_data_folder <- file.path("input_data",
                               "UCI HAR Dataset")
file_name <- "activity_labels"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

activity_labels <- fread(file_path)

# Loads training data
input_data_folder <- file.path("input_data",
                               "UCI HAR Dataset",
                               "train")
# X train
file_name <- "X_train"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

x_train_df <- fread(file_path)

# y train (labels)
file_name <- "y_train"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

y_train_df <- fread(file_path)

# subject train
file_name <- "subject_train"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

subject_train_df <- fread(file_path)

# Loads test data
input_data_folder <- file.path("input_data",
                               "UCI HAR Dataset",
                               "test")
# X test
file_name <- "X_test"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

x_test_df <- fread(file_path)

# y test (labels)
file_name <- "y_test"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

y_test_df <- fread(file_path)

# subject test
file_name <- "subject_test"
file_extension <- "txt"
file_path <- file.path(input_data_folder, 
                       paste(file_name, file_extension, sep = "."))

subject_test_df <- fread(file_path)

# Merges x , subjects, and y(labels) data frames for train and test data
train_df <- bind_cols(x_train_df, subject_train_df, y_train_df)
test_df <- bind_cols(x_test_df, subject_test_df, y_test_df)

# Merges train and test data frames
train_test_df <- bind_rows(train_df, test_df)

# Change columns names to features names
names(train_test_df) <- c(features_names$V2,"subject", "activity")

# Change activity labels from numbers to phrases
train_test_df$activity <- factor(train_test_df$activity,
                                 levels = activity_labels$V1,
                                 labels = activity_labels$V2)

# Selects only the columns with mean or std of the variables
# and keeps subject and activity columns
pattern_reg <- ".*(mean|std)\\(\\).*"
cols <- c(grep(pattern = pattern_reg, names(train_test_df), value = TRUE),
          "subject",
          "activity")

train_test_df <- train_test_df[ , ..cols]

# Summarises the train_test_df on the variables with mean or std in the name
# using the mean
train_test_summary_df <- train_test_df %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# Removes dataframes
rm(activity_labels, 
   features_names, 
   subject_test_df, 
   subject_train_df,
   x_test_df,
   x_train_df,
   y_test_df,
   y_train_df,
   test_df,
   train_df)

# Removes other values
rm(cols, 
   file_extension, 
   file_name, 
   file_path, 
   file_url, 
   input_data_folder, 
   pattern_reg)

    