##load raw data into R
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

#merge data from test and train
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)

#getting numbera of rows containing measures for mean and std using regular expression
gr <- grep(".*mean|std.*", features$V2)

#setting column names from features dataframe
colnames(X) <- features[,2]

#removing rows other than rows containnig mean() and std() results
X_filtered <- X[,gr]

#adding activity and subject data into dataset
activity_names <- apply(y,1, function(i) activity_labels[i,2])
XX <- cbind(X_filtered, activity_name = activity_names, Subject = subject$V1)

#getting dataframe with average for each subject and each activity
attach(XX)
tidy <- aggregate(XX, list(activity_name, Subject), mean)
detach(XX)

tidy