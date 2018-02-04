project_dir <- "/home/patrick/Desktop/DOST_DataScience"

features <- read.table(paste(project_dir,"/Final_Project/UCI HAR Dataset/features.txt", sep=""))
activity_list <- read.table(paste(project_dir,"/Final_Project/UCI HAR Dataset/activity_labels.txt", sep=""))

test_data_x <- paste(project_dir, "/Final_Project/UCI HAR Dataset/test/X_test.txt", sep="")
train_data_x <- paste(project_dir,"/Final_Project/UCI HAR Dataset/train/X_train.txt", sep="")

test_data_y <- paste(project_dir, "/Final_Project/UCI HAR Dataset/test/y_test.txt", sep="")
train_data_y <- paste(project_dir, "/Final_Project/UCI HAR Dataset/train/y_train.txt", sep="")

test_subject_y <- paste(project_dir, "/Final_Project/UCI HAR Dataset/test/subject_test.txt", sep="")
train_subject_y = paste(project_dir,"/Final_Project/UCI HAR Dataset/train/subject_train.txt", sep="")

train_x <- read.table(train_data)
test_x <- read.table(test_data)

train_y <- read.delim(train_data_y)
test_y <- read.delim(test_data_y)

test_subj_y <- read.delim(test_subject_y)
train_subj_y <- read.delim(train_subject_y)

#buffer for extra row
test_subj_y[nrow(test_subj_y)+1,] <- NA
train_subj_y[nrow(train_subj_y)+1,] <- NA

names(test_x) <- features$V2
test_acts <- rep(1, nrow(test_y)+1)
print(ncol(test_acts))
for(index in 1:nrow(test_y)){
  g <- activity_list$V2[test_y[index,]]
  test_acts[index] = as.character(g)
}
test_x["Activities"] <- test_acts
test_x["Subjects"] <- test_subj_y

names(train_x) <- features$V2
train_acts <- rep(1, nrow(train_y)+1) 
for(index in 1:nrow(train_y)){
  g <- activity_list$V2[train_y[index,]]
  train_acts[index] = as.character(g)
}
train_x["Activities"] <- train_acts
train_x["Subjects"] <- train_subj_y

clean_data <- rbind(test_x,train_x)
