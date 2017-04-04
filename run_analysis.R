setwd('C:\\Users\\Davif Wong\\Desktop\\UCI HAR Dataset')
# You should create one R script called run_analysis.R that does the following. 

#	Merges the training and the test sets to create one data set.
#	Extracts only the measurements on the mean and standard deviation for each measurement. 
#	Uses descriptive activity names to name the activities in the data set
#	Appropriately labels the data set with descriptive variable names. 
#	From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

# X_train.txt X_test.txt
train <- read.table('./train/X_train.txt')
test <- read.table('./test/X_test.txt')

rain_bel <- read.table('./train/Y_train.txt')
est_bel <- read.table('./test/Y_test.txt')

rain_ject <- read.table('./train/subject_train.txt')
est_ject <- read.table('./test/subject_test.txt')

act_bel <- read.table('activity_labels.txt')
features  <- read.table('features.txt')

head_1 <- function(x, freq = 1){
  head(x, freq)
}

head_1(train);head_1(test);head_1(rain_bel);head_1(est_bel);head_1(act_bel)
head_1(features); head_1(rain_ject); head_1(est_ject)

# Extracts only the measurements on the mean and standard deviation for each 
# measurement. 

# ix first 
tmp <- features[,2]

extract <- grep(".*mean.*|.*std.*", tmp, value = T) 
extract <- gsub( '-mean', 'Mean', extract) # %>%
extract <- gsub( '-std', 'Std', extract) 
extract <- gsub( '[//()]', '', extract)
extract <- gsub( '[//-]', '', extract)
# extract: a list of mean and sd for measurements like tBodyAcc
extract_ix <- grep(".*mean.*|.*std.*", tmp) 

# subset from train_set and test set before merge
train_sel <- train[extract_ix]
test_sel <- test[extract_ix]

train_bind <- cbind(rain_ject, rain_bel, train_sel)
train_bind[,2] <- factor(train_bind[,2], levels = act_bel[,1],
                              labels = act_bel[,2])
names(train_bind) <- c('obs', 'act', extract)

test_bind <- cbind(est_ject, est_bel, test_sel)
test_bind[,2] <- factor(test_bind[,2], levels = act_bel[,1],
                         labels = act_bel[,2])
names(test_bind) <- c('obs', 'act', extract)

# last but not least 
merged_set <- rbind(train_bind,test_bind)

########### First four are done ##################
# Now creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
head_1(merged_set)

install.packages('dplyr')
library(dplyr)
install.packages('plyr')
library(plyr)

names(merged_set)
#merged_set[,3:81], na.rm=T)
#averages_data <- split(merged_set, c()
#  ddply(merged_set, .(obs, act), colMeans)

tidy_set <- aggregate(. ~ obs + act, data = merged_set, FUN = mean)

write.csv(tidy_set, 'tidy_set.txt', row.names =FALSE)
#write.csv(names(merged_set), 'forcook.txt', row.names =FALSE)
  