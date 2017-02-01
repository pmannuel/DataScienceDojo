train.master <- grep("Master\\.", train$Name)
train.master <- train[train.master,]
train.mchildren <- train.master

train.miss <- grep("Miss", train$Name)
train.miss <- train[train.miss,]

train.miss14a <- subset(train.miss, Age>=14)

train.miss14b <- train.miss[!rownames(train.miss) %in% rownames(train.miss14a),]

train.fchildren <- train.miss14b[train.miss14b$Parch!=0,]

train.children <- c(row.names(train.fchildren),row.names(train.mchildren))
train.children <- train[train.children,]

train.children.noage <- subset(train.children, is.na(train.children$Age))
train.children.noage <- row.names(train.children.noage)

clean.train <- train

clean.train[train.children.noage,]$Age <- median(train.children$Age, na.rm=TRUE)

clean.train$IsChildren <- 0
clean.train[row.names(train.children),]$IsChildren <- 1

clean.train$IsElderly <- 0
train.elder <- subset(clean.train, Age>60)
clean.train[row.names(train.elder),]$IsElderly <- 1

train.adult <- train[!rownames(train) %in% rownames(train.children),]
train.adult <- train.adult[!rownames(train.adult) %in% rownames(train.elder),]

clean.train$Age[is.na(clean.train$Age)] <- median(train.adult$Age, na.rm=TRUE)

#INCLUDE SURVIVE FOR TRAINING DATA, EXCLUDE FOR TEST !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

factor.col <- c("Pclass", "IsChildren", "IsElderly")
clean.train[factor.col] <- lapply(clean.train[factor.col], as.factor)

numeric.col <- c("PassengerId", "SibSp", "Parch", "Fare")
clean.train[numeric.col] <- lapply(clean.train[numeric.col], as.numeric)

###WRONG## ENDED UP REPLACING ALL ZEROS
#clean.train$SibSp[is.na(clean.train$SibSp)] <- median(train.adult$SibSp, na.rm=TRUE)
#clean.train$Parch[is.na(clean.train$Parch)] <- median(train.adult$Parch, na.rm=TRUE)

clean.train$IsMchild <- 0
clean.train[row.names(train.mchildren),]$IsMchild <- 1

clean.train$IsFchild <- 0
clean.train[row.names(train.fchildren),]$IsFchild <- 1

clean.train$Fare[is.na(clean.train$Fare)] <- c(7.55) #ONLY FOR TEST DATA

write.csv(clean.train, file = "Titanic Cleaned Blind Holdout 2" )

rm(list=setdiff(ls(), "titanic.clean.train.data"))

#####################################################
#ADD FEATURE OF TRAVELLING ALONE TO CLEAN TRAIN DATA#
#####################################################
clean.train <- titanic.clean.train.data
clean.train$IsAlone <- 0
train.alone <- subset(clean.train, SibSp==0)
train.alone <- subset(train.alone, Parch==0)
clean.train[row.names(train.alone),]$IsAlone <- 1

clean.train$highSS <- 0
train.highSS <- subset(clean.train, SibSp>2)
clean.train[row.names(train.highSS),]$highSS <- 1
