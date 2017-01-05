Additional information about run_analysis.R

Used variables:

- dataTrain.X: data extracted from X_train.txt
- dataTrain.Subject: data extracted from subject_train.txt
- dataTrain.Y: data extracted from y_train.txt
- dataTrain: dataTrain.Subject, dataTrain.Y and dataTrain.X merged
- dataTest.X: data extracted from X_test.txt
- dataTest.Subject: data extracted from subject_test.txt
- dataTest.Y: data extracted from y_test.txt
- dataTest: dataTest.Subject, dataTest.Y and dataTest.X merged
- features: measures labels extracted from features.txt
- activity_labels: activity labels extracted from activity_labels.txt
- mergedData: all data merged.
- dataMeanStd: data containing mean and std information extracted from mergedData.
- tidyData: data set output with the average of each variable for each activity and each subject

Code steps:
- Extract data train and data test from text files using read.table() and merge it using data.frame()
- Bind data train and data test using rbind() 
- Label data with the data obtained from features.txt using names()
- Extract subset containing mean and std using grep() and selecting obtained columns
- Match activity data with the activity names obtained in activity_labels
- Set more descriptive names:
  - Set to lower case.
  - Substitute - for_
  - Remove ()
  - Remove repeated words
  - Use more descriptive words (std: standard_deviation, acc: accelerometer, gyro: gyroscope, freq: frequency, t: time_domain, f: frequency_domain)
  - Divide names correctly with _
- Create new dataset from mergedData, spliting the data into subsets regarding activity and subject and computing the mean using the function aggregate()
- Write a table with the new dataset tidyData.txt
