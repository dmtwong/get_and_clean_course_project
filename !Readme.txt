This repository contains the following files:

!Readme.txt: meant to describe how the tidy_set.txt was created.
tidy_data.txt: contains the output for course project.
codebook.txt: describes the contents of tidy_data.txt (particularly the unit and overview of variables).
run_analysis.R: the script to do the work
-------------------------------
Before writing the script:
Download, and unzip data to Desktop
-------------------------------
Procedure:
1: 		Read all relevant data
2 (optional):	return first row to have a sense of data
3:		Extracts only mean and sd for each measurement (and the index as well for subsetting dataset)
4: 		Create the subset of test dataset and trainning dataset before merge (subsetting according index from step 3)
5: 		Cbind merge the two dataset (First four tasks are completed)
6: 		take the mean for each voluntter and activitiyes 
7: 		Export the output as tidy_data.txt


The attached tidy_data.txt was created using R version 3.3.3 64-bit (2017-04-04) on Windows 10.
