library(dplyr)

get_raw_data <- function() {
  url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  destfile <- 'raw.zip'
  download.file(url, destfile = destfile)
  unzip(destfile)
}

read_file <- function(feature, datasets, data_base_dir) {
  x <- tibble()
  for (d in datasets) {
    filepath <- file.path(data_base_dir, d, paste(feature, '_', d, '.txt', sep = ''))
    x <- bind_rows(x, tibble(read.table(filepath)))
    
  }
  x
}

run_analysis <- function() {
  data_base_dir <- 'UCI HAR Dataset'
  datasets = c('train', 'test')
  
  # merge training and test data sets
  X <- read_file(feature = 'X', 
                 datasets = datasets, 
                 data_base_dir = data_base_dir)
  y <- read_file(feature = 'y',                 
                 datasets = datasets, 
                 data_base_dir = data_base_dir)
  subject <- read_file(feature = 'subject',                 
                       datasets = datasets, 
                       data_base_dir = data_base_dir)
  names(subject) <- c("subject_code")
  
  # extract mean and std
  features <- tibble(read.table(file.path(data_base_dir, 'features.txt')))
  idx <- filter(features, grepl('-mean[(]|-std[(]', features$V2))
  X_mean_and_std <- select(X, idx$V1)
  names(X_mean_and_std) <- idx$V2
  
  # assign descriptive names to activities
  # labels data set with descriptive variables names
  activity_labels <- tibble(read.table(
      file.path(data_base_dir, "activity_labels.txt")))
  y_labeled <- inner_join(y, activity_labels, by = c("V1" = "V1"))
  names(y_labeled) <- c("activity_code", "activity_name")
  
  # mean each variable group by activity and subject
  data_final <- bind_cols(X_mean_and_std, subject, y_labeled)
  gdata <- group_by(data_final, activity_name, subject_code)
  averaged_data_final <- summarise_all(gdata, mean, na.rm = TRUE)
  
  #list(data_final, averaged_data_final)
  
  averaged_data_final
}

write_data <- function(dataset) {
  
}
