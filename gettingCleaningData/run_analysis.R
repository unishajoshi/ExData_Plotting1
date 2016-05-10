library(plyr)
library(dplyr)

#Creating Directories 
#Extract the given data files in "UCI HAR Dataset" folder in the woring directory
uci_har_dataset <- "UCI\ HAR\ Dataset"
activity_labels_path <- paste(uci_har_dataset, "/activity_labels.txt", sep = "")
feature_path <- paste(uci_har_dataset, "/features.txt", sep="")
x_train_path <- paste(uci_har_dataset, "/train/X_train.txt", sep = "")
y_train_path <- paste(uci_har_dataset, "/train/y_train.txt", sep = "")
subject_train_path <- paste(uci_har_dataset, "/train/subject_train.txt", sep = "")
x_test_path  <- paste(uci_har_dataset, "/test/X_test.txt", sep = "")
y_test_path  <- paste(uci_har_dataset, "/test/y_test.txt", sep = "")
subject_test_path <- paste(uci_har_dataset, "/test/subject_test.txt", sep = "")

#Read the raw data from the files
features <- read.table(feature_path, colClasses = c("character"))
activity_labels <- read.table(activity_labels_path)
x_train <- read.table(x_train_path)
y_train <- read.table(y_train_path)
subject_train <- read.table(subject_train_path)
x_test <- read.table(x_test_path)
y_test <- read.table(y_test_path)
subject_test <- read.table(subject_test_path)

#To understand the data we can view the data 
#View(features)
#View(activity_labels)
#View(x_train)
#View(y_train)
#View(subject_train)
#View(x_test)
#View(y_test)
#View(subject_test)

#Specifying more specific column names to activity_labels
activity_labels <- read.table(activity_labels_path, col.names = c("ActivityId", "Activity"))

# 1. Merges the training and the test sets to create one data set.

# Binding/Combining the data
training_data_combined <- x_train %>% cbind(subject_train) %>% cbind(y_train)
test_data_combined <- x_test %>% cbind(subject_test) %>% cbind(y_test)
combined_data <- training_data_combined %>% rbind(test_data_combined)

#Assigning Labels
data_labels <- features %>% rbind(c(562, "Subject")) %>% rbind(c(563, "ActivityId")) 
names(combined_data) <- data_labels[,2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
combined_data_mean_standard <- combined_data[,grepl("mean|std|Subject|ActivityId", names(combined_data))]

# 3. Uses descriptive activity names to name the activities in the data set
combined_data_mean_standard <- join(combined_data_mean_standard, activity_labels, by = "ActivityId", match = "first")
combined_data_mean_standard <- combined_data_mean_standard[,-1]

# 4. Appropriately labels the data set with descriptive names.

# Remove parentheses
names(combined_data_mean_standard) <- gsub('\\(|\\)',"",names(combined_data_mean_standard), perl = TRUE)

#Make valid names
names(combined_data_mean_standard) <- make.names(names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('Acc',"Acceleration",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('GyroJerk',"AngularAcceleration",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('Gyro',"AngularSpeed",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('Mag',"Magnitude",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('^t',"TimeDomain.",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('^f',"FrequencyDomain.",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('\\.mean',".Mean",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('\\.std',".StandardDeviation",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('Freq\\.',"Frequency.",names(combined_data_mean_standard))
names(combined_data_mean_standard) <- gsub('Freq$',"Frequency",names(combined_data_mean_standard))


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

average_by_activity_subject = ddply(combined_data_mean_standard, c("Subject","Activity"), numcolwise(mean))
write.table(average_by_activity_subject, file = "average_by_activity_subject.txt")


