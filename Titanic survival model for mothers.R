titanic <- read.csv("titanic.csv")

#filtering to create a matrix of possible mothers
mothers <- titanic[!titanic$Parch==0,]
mothers <- mothers[mothers$Sex=="female",]
mothers <- mothers[mothers$Age>18,]

#Any way to make this succint?
#WHY mothers <- titanic[!titanic$Parch==0 && titanic$Sex=="female",] DID NOT WORK?

#Determine mothers by differentiating Miss. and Mrs.
mrs.row <- grep("Mrs\\.", mothers$Name)
mothers <- mothers[mrs.row,]

#create new column to categorize mothers
titanic$IsMother <- FALSE
