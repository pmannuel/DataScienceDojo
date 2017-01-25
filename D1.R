setwd("~/DataScienceDojo Repository/bootcamp/Datasets")
titanic <- read.csv("titanic.csv")

female.survivors<-titanic[titanic$Sex=="female","Survived"]

prop.table(table(titanic[titanic$Pclass==1,"Survived"]))

first_males <- titanic$Sex=="male" & titanic$Pclass==1

median(titanic$Age, na.rm=T)

titanic[is.na(titanic$Age),"Age"] <- median(titanic$Age, na.rm=T)

titanic$IsNaAge <- FALSE
titanic[is.na(titanic$Age),"IsNaAge"] <- TRUE

titanic$Pclass <- as.factor(titanic$Pclass)
ggplot(titanic,aes(x=Survived, y=Age)) + geom_boxplot(aes(color=Pclass))

"master\\."
grep("master", titanic$Name, ignore.case=T)
strsplit
apply