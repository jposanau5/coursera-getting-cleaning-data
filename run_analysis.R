# read the test and training data into data.frames
 
setwd("UCI HAR Dataset/test")
tests <- read.table("X_test.txt")
tests.activities <- read.table("y_test.txt")
tests.subjects <- read.table("subject_test.txt")
setwd("../train")
training <- read.table("X_train.txt")
training.activities <- read.table("y_train.txt")
training.subjects <- read.table("subject_train.txt")


# append subject and activity columns to the training/test data
# create a phase column to distinguish between training and test data
# give meaningful names to subject and activity id columns

training <- cbind(training,training.subjects,training.activities,phase="train")
colnames(training)[562:563] <- c("subject.id", "activity.id")
tests <- cbind(tests,tests.subjects,tests.activities,phase="test")
colnames(tests)[562:563] <- c("subject.id", "activity.id")

# merge the training and test data

full.dataset <- rbind(training, tests)


# read the feature data into data.frames

setwd("..")
features <- read.table("features.txt")

# give the features table meaningful column names

names(features) <- c("id", "name")

# identify meansurements on mean or standard deviation

selected.features <- features[grep("mean|std", features$name, ignore.case=TRUE),]

# get a subset of the full dataset containing only mean and standard
# deviation measurements

mean.std.data <- full.dataset[, c(selected.features$id, c(562:564))]


# read the activity labels into data.frames
# with meaningful column names

activity.labels <- read.table("activity_labels.txt")
names(activity.labels) <- c("activity.id", "activity.name")

# using the plyr library, append an activity name column
# reorder the columns, dropping the activity id which is now redundant

library(plyr)
mean.std.data <- join(mean.std.data, activity.labels, by="activity.id")
mean.std.data <- mean.std.data[, c(89,87,90,1:86)]


# replace all hypens, commas, and parentheses with a period
selected.features.names <- gsub("([-,\\(\\)])+", "." , selected.features$name)

# remove any period at the end of the string
selected.features.names <- gsub("(\\.)$", "", selected.features.names)

# place a period between camelCase strings
selected.features.names <- gsub("([a-z])([A-Z])", "\\1.\\2", selected.features.names)

# convert all characters to lowercase
selected.features.names <- tolower(selected.features.names)
	
# apply the appropriately named feature identifiers to the data set
names(mean.std.data)[4:89] <- selected.features.names

# Further tidy the data set by converting the subject id column to factors.
mean.std.data$subject.id <- as.factor(mean.std.data$subject.id)
	
	

# using the dplyr library, create a data tibble.
# drop the phase column
# group by activity and subject
# calculate the means

library(dplyr)
mean.std.avgs <- tbl_df(mean.std.data)
mean.std.avgs <- mean.std.avgs %>% 
                   select(-phase) %>% 
                   group_by(activity.name, subject.id) %>% 
                   summarise_all(funs(mean)) %>% 
                   arrange(activity.name, subject.id)

# prefix the measurement columns with 'avg.' to indicate average
colnames(mean.std.avgs)[3:88] <- paste0("avg.", colnames(mean.std.avgs)[3:88])


# Writing final data to CSV
if(!file.exists("output")) { dir.create(("output") }
write.csv(mean.std.data, "uci-har-mean-stdev.csv")
write.csv(mean.std.avgs, "uci-har-mean-stdev-summary.csv")