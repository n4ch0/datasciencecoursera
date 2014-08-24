# Preliminarily, we read all the files

## Data on test set
subject_test <- read.table("~/UCI HAR Dataset/Test/subject_test.txt")
x_test <- read.table("~/UCI HAR Dataset/Test/x_test.txt")
y_test <- read.table("~/UCI HAR Dataset/Test/y_test.txt")

## Data on training set
subject_train <- read.table("~/UCI HAR Dataset/Train/subject_train.txt")
x_train <- read.table("~/UCI HAR Dataset/Train/x_train.txt")
y_train <- read.table("~/UCI HAR Dataset/Train/y_train.txt")

## Names of features
features <- read.table("~/UCI HAR Dataset/Features.txt")

## Names of activities
activities <- read.table("~/UCI HAR Dataset/activity_labels.txt")

# Firstly, we merge both datasets

subject_full <- rbind(subject_test, subject_train)
x_full <- rbind(x_test, x_train)
y_full <- rbind(y_test, y_train)

write.table(subject_full, file = "subject_full.txt", row.name=FALSE)
write.table(x_full, file = "x_full.txt", row.name=FALSE)
write.table(y_full, file = "y_full.txt", row.name=FALSE)

# Secondly, we select those features related to mean or standard deviation

## Identify features with the wording "mean" or "std" 
featurestfmean <- grepl("mean", features[,2])
featurestfstd <- grepl("std", features[,2])

## Get the column numbers of those features
colsms <- features[,1][featurestfmean | featurestfstd]

## Extract those columns
x_ms <- x_full[,colsms]

# Thirdly, we rename the activities

y_full2 <- data.frame()
for(i in 1:nrow(y_full)){y_full2[i,1]<-activities[y_full[i,1],2]}

y_full <- y_full2

# Fourthly, we appropriately label the dataset with appropriate variable names

names(subject_full) <- "Subject"
names(x_ms) <- features[,2][featurestfmean | featurestfstd]
names(y_full) <- "Activity"

# And fifthly, new data set with variable averages per suject and activity

## We prepare the data, I need to convert the data into vectors.

sf<- as.vector(t(subject_full))
xf <- as.matrix(x_ms)
yf<- as.vector(t(y_full))

## We create a new data frame, freshdata, to store these data, and create a first column with codes for pairs of subject and activity
freshdata <- data.frame()
levelsdata <- levels(interaction(sf,yf))
for(i in 1:length(levelsdata)){freshdata[i,1] <- levelsdata[i]}

for(i in 1:ncol(xf)){
  meansVec <- sapply(split(xf[,i], list(sf, yf), drop=TRUE),mean)
  for(j in 1:length(meansVec)){
    freshdata[j,i+1] <- meansVec[j]
  }
}

names(freshdata)<- c("Subject.Activity",names(x_ms))

write.table(freshdata, file = "freshdata.txt", row.name=FALSE)
