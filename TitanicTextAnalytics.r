#=======================================================================
#
# Code sample illustrating the use of the quanteda package to perform 
# text analytics on Titanic Ticket data.
#
#=======================================================================
#install.packages("quanteda")
library(quanteda)


# Load up data.
# NOTE - Set your working directory to the correct location for the
#        Kaggle data files
train <- read.csv("train.csv", stringsAsFactors = FALSE)
test <- read.csv("test.csv", stringsAsFactors = FALSE)


# Combine the data to make data cleaning easier
survived <- train$Survived
data.combined <- rbind(train[, -2], test)


# Transform some variables to factors
data.combined$Pclass <- as.factor(data.combined$Pclass)
data.combined$Sex <- as.factor(data.combined$Sex)


# Use the quanteda package to create n-grams from the characters
# of passenger Tickets.
ticket.ngrams <- dfm(data.combined$Ticket, what = "character", 
                     remove_numbers = FALSE, remove_punct = TRUE,
                     remove_symbols = TRUE, remove_hyphens = TRUE,
                     ngrams = 1:3)


# Use the mighty TF-IDF to enhance the n-gram features
ticket.tfidf <- tfidf(ticket.ngrams)


# Calculate the cosine similarity between all Tickets
cosine.sim <- as.matrix(textstat_simil(ticket.tfidf, 
                                       method = "cosine", 
                                       margin = "documents"))
View(cosine.sim)


# To use tf-idf values, we will need to convert to a data
# frame. Then we can use the cbind() function.
ticket.tfidf.df <- as.data.frame(ticket.tfidf)
dim(ticket.tfidf.df)


# However, the column names are not in a good format,
# fix up the column names on the data frame.
names(ticket.tfidf.df)[1:10]
names(ticket.tfidf.df) <- paste("Ticket_",
                                 names(ticket.tfidf.df),
                                 sep = "")
names(ticket.tfidf.df)[1:10]


# Now we can cbind() to your combined data frame
data.combined <- cbind(data.combined, ticket.tfidf.df)
dim(data.combined)
names(data.combined)[1:20]


# Transform some variables to factors
data.combined$Pclass <- as.factor(data.combined$Pclass)
data.combined$Sex <- as.factor(data.combined$Sex)


# Split data back out
train <- data.combined[1:891,]
train$Survived <- as.factor(survived)

test <- data.combined[892:1309,]


# EXERCISE
#
# How can the similiarities between ticket number be used to 
# engineer new features that attempt to capture "the underlying
# truth" in all passenger data?
