________________________________________________________________________________________________________________________________________________
________________________________________________________________________________________________________________________________________________
________________________________________________________________________________________________________________________________________________

This is the Code Book for the output dataset created from running run_analysis.R


SUMM_DATA.txt: This is a summary dataset containing one record per subject per activity.
	       All subjects in both the training and testing datasets are included in this summary file.
	       There are 180 rows in this dataset (30 subject x 6 activities each)
	       There are 88 variables including in this dataset (outlined below).

Variables:

SUBJID
	This is a variable indicating the ID for each volunteer included in the experiment.
	values (integer): 1-30

ACTIVITY
	This variable indicates the activity being performed
	values (character):
		WALKING
		WALKING_UPSTAIRS
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING

All other variables included in the dataset (86 variables) respresent unique measurements taken as
part of the experiment. From the raw data, only measurements on the mean and standard deviation for each 
measurement were included (i.e., any variable name including the text string 'mean' or 'std' was kept.)
The values presented in this summary dataset for each of these variables is the mean value of each original 
measurement by subject and activity.

For example, in the summary dataset you will find the variable tBodyAcc.mean.Y. The values presented for this 
variable are the mean of all raw values of this measurement (this measurement = the mean of the time body acceleration measurement on the X axis)
for each subject and activity. The *general* naming conventions for these variables follows:
	XX.YY.Z where 
		XX = the measurement description (t = time, f= frequency)
		YY = whether this was a mean or standard deviaton of the measurement (mean, meanFreq, or std)
		 Z = the axis of the measurement (X, Y, or Z) (NOT ALWAYS APPLICABLE)

	The last seven variable include slightly different naming conventions (no separations with .); these all apply to the angular measurement beginning
	with 'angle' and all indicate means with similar descriptive text of the measurement in the variable name. 

	All 86 of these variables are numeric.

________________________________________________________________________________________________________________________________________________
________________________________________________________________________________________________________________________________________________
________________________________________________________________________________________________________________________________________________

		
