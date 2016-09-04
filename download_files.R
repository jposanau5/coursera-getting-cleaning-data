# create a data directory and download the HAR Dataset data file into it
# unzip the zip file
setwd("C:/")
if (!file.exists("data")) {dir.create("data")}
setwd("data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="assignment.zip")
unzip("assignment.zip")
