README.txt

The experiments have been carried out with a group of 30 volunteers within an age
bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. 

There are 2 parts of the data: train and test data.


Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration 
and 3-axial angular velocity were captured.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

There are 561 variables (features) like:

"timeBodyAccelerometer-std()-X"
“timeBodyAccelerometer-mean()-Y”
"frequencyBodyAccelerometer-std()-Z"
"frequencyBodyGyroscope-meanFreq()-X"


The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. 
These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The tidy data set (Data) was obtained with "run_analysis.R" script.

The steps for tidying the data were following :

1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement.
3) Use descriptive activity names to name the activities in the data set
4) Appropriately label the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set (secTidySet) with the average of each variable for each activity and each subject.
