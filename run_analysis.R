#This is the R script for the course project for
#Coursera Getting and Cleaning Data

getwd()
#first make sure that the Samsung data in in your working directory


#explore the files provided withtin the data subfolders
list.files()
list.files("./test")
list.files("./train")

#read in the test and training data
TEST <- read.table("./test/X_test.txt", header = FALSE)
TRAIN <- read.table("./train/X_train.txt", header = FALSE)

#do some exploration of the datasets provided
dim(TEST)#2947 obs and 561 vars
dim(TRAIN)#7352 obs and 561 vars

#read in the test and training label datasets
TEST_LAB <- read.table("./test/Y_test.txt", header = FALSE)
TRAIN_LAB <- read.table("./train/Y_train.txt", header = FALSE)

#a little exploration of the values provided as test and training labels
table(TEST_LAB)
table(TRAIN_LAB)

#read in the subject files identifying who performed the activity for each window sample [1 to 30]
#for test and training datasets
TEST_SUBJ <- read.table("./test/subject_test.txt", header = FALSE)
TRAIN_SUBJ <- read.table("./train/subject_train.txt", header = FALSE)

#a little exploration of the values provided as test and training subject identifiers
table(TEST_SUBJ)
table(TRAIN_SUBJ)

#read in activity labels and features
ACTIVITY <- read.table("activity_labels.txt", header = FALSE)
FEATURE <- read.table("features.txt", header = FALSE)

#a little exploration of the values provided as activity and feature labels
dim(ACTIVITY)
dim(FEATURE)
summary(ACTIVITY)
table(FEATURE$V2)
head(ACTIVITY)
head(FEATURE)

#merge datasets together and add appropriate labels
install.packages("dplyr")
library(dplyr)

#updating the variable names to be easy to understand descriptive variables
FEATURE$ABB_NAME <- gsub("-", ".", FEATURE$V2)
FEATURE$ABB_NAME <- gsub("[()]", "", FEATURE$ABB_NAME)
FEATURE$ABB_NAME <- gsub(",", "", FEATURE$ABB_NAME)

#replacing variable names with descriptive one for TEST and TRAIN datasets
names(TEST)<- FEATURE$ABB_NAME
names(TRAIN)<- FEATURE$ABB_NAME

#rename the subject and activity dataset variables to have descriptive names
TEST_LAB <- rename(TEST_LAB, ACTIVITY = V1)
TRAIN_LAB <- rename(TRAIN_LAB, ACTIVITY = V1)

TEST_SUBJ <- rename(TEST_SUBJ, SUBJID = V1)
TRAIN_SUBJ <- rename(TRAIN_SUBJ, SUBJID = V1)

#Bind together the SUBJID and ACTIVITY columns to the rest of the data for TEST and TRAIN
NEW_TEST <- cbind(TEST_SUBJ, TEST_LAB, TEST)
dim(NEW_TEST)
NEW_TEST[1:5, 1:5]

NEW_TRAIN <- cbind(TRAIN_SUBJ, TRAIN_LAB, TRAIN)
dim(NEW_TRAIN)
NEW_TRAIN[1:5, 1:5]

#row bind NEW_TEST and NEW_TRAIN data together
ALL_DATA <- rbind(NEW_TRAIN, NEW_TEST)
dim(ALL_DATA)
names(ALL_DATA)

#now select only variables with either mean or std in var name
SUB_DATA <- ALL_DATA[ , grep("SUBJID|ACTIVITY|mean|Mean|std", names(ALL_DATA))]
names(SUB_DATA)
dim(SUB_DATA)

#merge on descriptive names for activities and rename new variable
SUB_DATA2 <- merge(ACTIVITY, SUB_DATA, by.x = "V1", by.y = "ACTIVITY", all = TRUE)
SUB_DATA2 <- rename(SUB_DATA2, ACTIVITY = V2)
SUB_DATA2 <- SUB_DATA2[ , 2:89]

#Now with this tiday dataset SUB_DATA2
#create another dataset with the average of each variable for each activity and subject 
SUBJ_ACT <- group_by(SUB_DATA2, SUBJID, ACTIVITY)
SUMM_DATA <- summarise_each(SUBJ_ACT, funs(mean))
dim(SUMM_DATA)

#write the final tidy dataset to a txt file to upload for grading
write.table(SUMM_DATA, file = "SUMM_DATA.txt", row.names = FALSE) 

#Check that data was accurately written by reading it back into R
CHECK_DATA <- read.table("SUMM_DATA.txt", header = TRUE)
View(CHECK_DATA)
