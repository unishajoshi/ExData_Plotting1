The run_analysis.R does the following :

1. Loads the library for packages plyr and dplyr. If not installed previously run install.packages("plyr") and install.packages("dplyr") before laoding libraries.
2. Creates variables storing the directories path for the test, training, activity and features files.
3. Reads the raw data from the files.
4. Provides more specific column names to activity lookup.
5. Binds the given data.
6. Assigns labels
7. Extracts only the measurements on the mean and standard deviation for each measurement.
8. Provides more descriptive labels to the data.
9. Creates independent tidy data set with the average of each variable for each activity and each subject.
