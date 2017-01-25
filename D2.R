sample_rate = .7 #Tuning parameter, declared at top
train.index <- sample(1:nrow(iris), sample_rate * nrow(iris))
iris.train <- iris[train.index,]
View(titanic)
iris.test <- iris[-train.index]

library(rpart)
rpart(Species~., data=iris)

iris.tree <- rpart(Species~., data=iris.train)

predict(iris.tree, newdata = iris.test) #spit out percentage

iris.predictions <- predict(iris.tree, iris.test, type = "class")

iris.comparison <- iris.test

iris.comparison$Predictions <- iris.predictions

iris.comparison[,c("Species","Predictions")]
table(iris.comparison[,c("Species","Predictions")])
