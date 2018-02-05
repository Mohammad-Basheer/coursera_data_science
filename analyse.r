#  Getting and Cleaning Data by Coursera and Johns Hopkins
#  Author: Patrick Michael Chiuco
#  *** Padded rows with missing activity and subject values with NA

project_dir <- "/home/patrick/Desktop/DOST_DataScience"

#---> STEP 1 Start
# Get features and activity list tables

## Features and activity list data sets
features <- read.table(paste(project_dir,"/Final_Project/UCI HAR Dataset/features.txt", sep=""))
activity_list <- read.table(paste(project_dir,"/Final_Project/UCI HAR Dataset/activity_labels.txt", sep=""))


## Test data set (X,Y and subject)
test_data_x <- paste(project_dir, "/Final_Project/UCI HAR Dataset/test/X_test.txt", sep="")
test_x <- read.table(test_data_x)

test_data_y <- paste(project_dir, "/Final_Project/UCI HAR Dataset/test/y_test.txt", sep="")
test_y <- read.delim(test_data_y)

test_subject_y <- paste(project_dir, "/Final_Project/UCI HAR Dataset/test/subject_test.txt", sep="")
test_subj_y <- read.delim(test_subject_y)


## Train data set (X,Y and subject)
train_data_x <- paste(project_dir,"/Final_Project/UCI HAR Dataset/train/X_train.txt", sep="")
train_x <- read.table(train_data)

train_data_y <- paste(project_dir, "/Final_Project/UCI HAR Dataset/train/y_train.txt", sep="")
train_y <- read.delim(train_data_y)

train_subject_y = paste(project_dir,"/Final_Project/UCI HAR Dataset/train/subject_train.txt", sep="")
train_subj_y <- read.delim(train_subject_y)

# Attach subject and y data sets to the x data set; use feature names as column names for the resulting table.

## Test Data set
names(test_x) <- features$V2

test_subj_y[nrow(test_subj_y)+1,] <- NA # See ***
test_x["Subjects"] <- test_subj_y

test_acts <- rep(1, nrow(test_y)+1)
for(index in 1:nrow(test_y)){
  g <- activity_list$V2[test_y[index,]]
  test_acts[index] = as.character(g)
}
test_x["Activities"] <- test_acts

## Train Data set
names(train_x) <- features$V2

train_subj_y[nrow(train_subj_y)+1,] <- NA
train_x["Subjects"] <- train_subj_y

train_acts <- rep(1, nrow(train_y)+1) 
for(index in 1:nrow(train_y)){
  g <- activity_list$V2[train_y[index,]]
  train_acts[index] = as.character(g)
}
train_x["Activities"] <- train_acts

# Bind resulting test and train tables together
clean_data <- rbind(test_x,train_x)
#---> STEP 1 DONE

#---> STEP 2 START
# Get and extract mean() and std() columns from resulting data set in step 1
## Extract column names
clean_data_names <- names(clean_data)

## Extract mean() column names
mean_col_names <- grep("[:alnum:]*-mean()[:alnum:]*",clean_data_names,"r",value=TRUE)
mean_col_names2 <- grep("[:alnum:]*-meanFreq()[:alnum:]*",mean_col_names,"r",value=TRUE, invert=TRUE)

## Extract std() column names
std_col_names <- grep("[:alnum:]*-std()[:alnum:]*",clean_data_names,"r", value=TRUE)
step2_colnames <- c(mean_col_names2, std_col_names)

# mean() and std() data from STEP 1
step2_clean_data <- clean_data[,step2_colnames]
#---> STEP 2 DONE

#---> STEP 3 START


#---> STEP 3 DONE

#---> STEP 4 START
#---> STEP 4 DONE

#---> STEP 5 START
#---> STEP 5 DONE
