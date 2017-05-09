#==================================================
#
# Sample R script illustrating the use of the 
# mighty ggplot2 package for analyzing Titanic
# data.
#
#==================================================

#install.packages("ggplot2")
library(ggplot2)

# Set working directory to root folder of the
# bootcamp GitHub.
titanic <- read.csv("Datasets/titanic.csv")

# Make Survived a factor (i.e., category)
titanic$Survived <- as.factor(titanic$Survived)

# Boxplot - Age by Sex
ggplot(titanic, aes(x = Sex, y = Age)) +
  theme_bw() +
  geom_boxplot() +
  labs(title = "Boxplot of Titanic Age by Sex")

# Boxplot - Age by Survived
ggplot(titanic, aes(x = Survived, y = Age)) +
  theme_bw() +
  geom_boxplot() +
  labs(title = "Boxplot of Titanic Age by Survived")

# Density plot - Surivabilty by Age, segmented
# by Sex and Pclass
ggplot(titanic, aes(x = Age, fill = Survived)) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_density(alpha = 0.5) +
  labs(y = "Density",
       title = "Density Plot - Suvivability by Age Segmented by Sex & Pclass")

# Color-coded histogram of Age by Survived, segmented
# by Sex and Pclass
ggplot(titanic, aes(x = Age, fill = Survived)) +
  theme_bw() +
  facet_wrap(Sex ~ Pclass) +
  geom_histogram(binwidth = 5) +
  labs(y = "Density",
       title = "Histogram - Suvivability by Age Segmented by Sex & Pclass")
