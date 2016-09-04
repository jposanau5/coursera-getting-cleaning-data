# Coursera datascitoolbox Getting and Cleaning Data assignment

## Overview
This repo is for the " Getting and Cleaning Data" assignment for the https://www.coursera.org/course/datascitoolbox data science course. The assignment goal is to "demonstrate an ability to collect, work with, and clean a data set".

## Data Source
The data used for this assignment comes from the UCI Machine Learning Repository data set named "Human Activity Recognition Using Smartphones Data Set".  Documentation for source data set:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

## Included Files
**README.md** - This file.

**CodeBook.md** - Describes source data and derived variables.  The derived variable descriptions contain coniderable detail on how they were derived.  However for more detailed transformation steps, please refer to the comments contained in the scripts.

Two scripts are included.  They are intended to run in this order:

1. **download_files.R** – downloads source dataset to a new directory and unzips
2. **run_analysis.R** – reads the data, transform the data, output to CSV


