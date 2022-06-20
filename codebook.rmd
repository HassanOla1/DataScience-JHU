---
title: "UCI Human Activity Recognition Using smartphones Dataset"
author: "Hassan"
date: '2022-06-20'
output: html_document
---
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. They performed a protocol of activities composed of six basic activities: three static postures (standing, sitting, lying) and three dynamic activities (walking, walking downstairs and walking upstairs). The experiment also included postural transitions that occurred between the static postures. These are: stand-to-sit, sit-to-stand, sit-to-lie, lie-to-sit, stand-to-lie, and lie-to-stand. All the participants were wearing a smartphone (Samsung Galaxy S II) on the waist during the experiment execution. We captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz using the embedded accelerometer and gyroscope of the device. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 561 features was obtained by calculating variables from the time and frequency domain.
## Attribute Information:
The dataset is then divided in two parts and they can be used separately
1. Inertial sensor data
- Raw triaxial signals from the accelerometer and gyroscope of all the trials with with participants.
- The labels of all the performed activities.

2. Records of activity windows. Each one composed of:
- A 561-feature vector with time and frequency domain variables.
- Its associated activity label.
- An identifier of the subject who carried out the experiment.

Section 1. Merge the training and the test sets to create one data set. After setting the source directory for the files, read into tables the data located in features.txt activity_labels.txt subject_train.txt x_train.txt y_train.txt subject_test.txt x_test.txt y_test.txt Assign column names and merge to create one data set.

Section 2. Extract only the measurements on the mean and standard deviation for each measurement. select objects that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset this data to keep only the necessary columns.

Section 3. Use descriptive activity names to name the activities in the data set Merge data. The activity field in extracted data is originally of numeric type. We need to change its type to character so that it can accept activity names. The activity names are taken from metadata activity_labels

Section 4. Appropriately label the data set with descriptive activity names. Use gsub function for pattern replacement to clean up the data labels. By examining extracted data, we observe the following acronyms can be replaced:

Acc can be replaced with Accelerometer
Gyro can be replaced with Gyroscope
BodyBody can be replaced with Body
Mag can be replaced with Magnitude
Character f can be replaced with Frequency
Character t can be replaced with Time

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. From the project instructions,  We create tidy data as a data set with average for each activity and subject. Then, we order the entries in tidy data and write it into data file Tidy.txt that contains the processed. data.