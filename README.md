# Preliminarily, we read all the files

## Data on test set
subject_test
x_test
y_test

## Data on training set
subject_train
x_train
y_train

## Names of features
features

## Names of activities
activities

# Firstly, we merge both datasets

subject_full
x_full
y_full

And creates text files through write.table

# Secondly, we select those features related to mean or standard deviation

## Identify features with the wording "mean" or "std" 
featurestfmean
featurestfstd

## Get the column numbers of those features
colsms

## Extract those columns
x_ms

# Thirdly, we rename the activities

# Fourthly, we appropriately label the dataset with appropriate variable names

# And fifthly, new data set with variable averages per suject and activity

## We prepare the data, we need to convert the data into vectors.

sf
xf
yf

## We create a new data frame, freshdata, to store these data, and create a first column with codes for pairs of subject and activity

Then we create the file with data.frame