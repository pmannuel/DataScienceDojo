titanic <- read.csv("titanic.csv")

titanic$IsMother <- 0 #change to zero because I couldn't assign TRUE

#eliminate Parch==0, find potential mothers
mothers <- titanic$Parch>0
titanic[mothers,"IsMother"] = 1

#remove male
notmothers <- titanic$Sex=="male"
titanic[notmothers,"IsMother"] = 0

#remove whoever is not Mrs.
mrs.row <- grep("Mrs\\.", titanic$Name)
titanic[-mrs.row,"IsMother"] = 0

#matrix of females with mothers category and no names
titanic.mothers.noname <- titanic[,-c(1,4,9,12)]
titanic.mothers.noname <- titanic.mothers.noname[titanic.mothers.noname$Sex=="female",]
titanic.females <- titanic.mothers.noname

densityplot(titanic.females$IsMother,groups=titanic.females$Survived,auto.key=T)
pie(table(titanic.females[titanic.females$Survived==1,"IsMother"]))
#other way to use the 'IsMother' feature other than determining odds in females?