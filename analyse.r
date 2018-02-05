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
# Extract Activities and STEP 2 data from clean_data
step3_colnames <- c("Activities", step2_colnames)
step3_clean_data <- clean_data[, step3_colnames]
#---> STEP 3 DONE

#---> STEP 4 START
hr_names <- c("Activities",
"Body Acceleration Mean - X",
"Body Acceleration Mean - Y",
"Body Acceleration Mean - Z",
"Gravity Acceleration Mean - X",
"Gravity Acceleration Mean - Y",
"Gravity Acceleration Mean - Z",
"Body Acceleration (Jerk) Mean - X",
"Body Acceleration (Jerk) Mean - Y",
"Body Acceleration (Jerk) Mean - Z",
"Angular Velocity Mean - X",
"Angular Velocity Mean - Y",
"Angular Velocity Mean - Z",
"Angular Velocity (Jerk) Mean - X",
"Angular Velocity (Jerk) Mean - Y",
"Angular Velocity (Jerk) Mean - Z",
"Body Acceleration Magnitude Mean",
"Gravity Acceleration Magnitude Mean",
"Body Acceleration (Jerk) Magnitude Mean",
"Angular Velocity Magnitude Mean",
"Angular Velocity (Jerk) Magnitude Mean",
"Fourier Body Acceleration Mean - X",
"Fourier Body Acceleration Mean - Y",
"Fourier Body Acceleration Mean - Z",
"Fourier Body Acceleration (Jerk) Mean - X",
"Fourier Body Acceleration (Jerk) Mean - Y",
"Fourier Body Acceleration (Jerk) Mean - Z",
"Fourier Angular Velocity Mean - X",
"Fourier Angular Velocity Mean - Y",
"Fourier Angular Velocity Mean - Z",
"Fourier Body Acceleration Magnitude Mean",
"Fourier Body Acceleration (Jerk) Magnitude Mean",
"Fourier Body Angular Velocity Magnitude Mean",
"Fourier Body Angular Velocity Magnitude (Jerk) Mean",
"Body Acceleration Std. Dev. - X",
"Body Acceleration Std. Dev. - Y",
"Body Acceleration Std. Dev. - Z",
"Gravity Acceleration Std. Dev. - X",
"Gravity Acceleration Std. Dev. - Y",
"Gravity Acceleration Std. Dev. - Z",
"Body Acceleration (Jerk) Std. Dev. - X",
"Body Acceleration (Jerk) Std. Dev. - Y",
"Body Acceleration (Jerk) Std. Dev. - Z",
"Angular Velocity Std. Dev. - X",
"Angular Velocity Std. Dev. - Y",
"Angular Velocity Std. Dev. - Z",
"Angular Velocity (Jerk) Std. Dev. - X",
"Angular Velocity (Jerk) Std. Dev. - Y",
"Angular Velocity (Jerk) Std. Dev. - Z",
"Body Acceleration Magnitude Std. Dev.",
"Gravity Acceleration Magnitude Std. Dev.",
"Body Acceleration (Jerk) Magnitude Std. Dev.",
"Angular Velocity Magnitude Std. Dev",
"Angular Velocity (Jerk) Magnitude Std. Dev.",
"Fourier Body Acceleration Std. Dev. - X",
"Fourier Body Acceleration Std. Dev. - Y",
"Fourier Body Acceleration Std. Dev. - Z",
"Fourier Body Acceleration (Jerk) Std. Dev. - X",
"Fourier Body Acceleration (Jerk) Std. Dev. - Y",
"Fourier Body Acceleration (Jerk) Std. Dev. - Z",
"Fourier Angular Velocity Std. Dev. - X",
"Fourier Angular Velocity Std. Dev. - Y",
"Fourier Angular Velocity Std. Dev. - Z",
"Fourier Body Acceleration Magnitude Std. Dev.",
"Fourier Body Acceleration (Jerk) Magnitude Std. Dev.",
"Fourier Body Angular Velocity Magnitude Std. Dev",
"Fourier Body Angular Velocity Magnitude (Jerk) Std. Dev.")

step4_clean_data <- step3_clean_data
names(step4_clean_data) <- hr_names
#---> STEP 4 DONE

#---> STEP 5 START
#---> STEP 5 DONE
