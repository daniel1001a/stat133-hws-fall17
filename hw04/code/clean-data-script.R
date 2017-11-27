#5

#load the package
library(dplyr)
library(readr)
#source
# Change
setwd("~/stat133-hws-fall17/hw04")  #in order to read the csv file

# Your directoyr is set to "~/stat133-hws-fall17/hw04"
# getwd() : "~/stat133-hws-fall17/hw04"
source("code/functions.R")

scores <- read.csv("data/rawdata/rawscores.csv")

# sink("output/summar-rawscores.txt")

sink_file <- ("output/summary-rawscores.txt")

# Get row and column number
ncols <- ncol(scores)
nrows <- nrow(scores)

sink(sink_file)
str(scores)

for(k in 1:ncols){
  print_stats(scores[ ,k])
}

sink()

# Replace NA values in each column with zero
for(k in 1:ncols) {
  scores[is.na(scores[,k]), k] <- 0
}


# test
# apply(scores, 2, range)

scores$QZ1 <- rescale100(scores$QZ1, xmin = 0, xmax = 12)
scores$QZ2 <- rescale100(scores$QZ2, xmin = 0, xmax = 18)
scores$QZ3 <- rescale100(scores$QZ3, xmin = 0, xmax = 20)
scores$QZ4 <- rescale100(scores$QZ4, xmin = 0, xmax = 20)


scores$Test1 <- rescale100(scores$EX1, xmin = 0, xmax = 80)
scores$Test2 <- rescale100(scores$EX2, xmin = 0, xmax = 90)


# Lab score 
Lab <- double(nrows)
for(k in 1:nrows){
  Lab[k] <- score_lab(unlist(scores[k, "ATT"]))
}

scores$Lab <- Lab

# apply(scores, 2, range)

Homework <- double(nrows)
for(k in 1:nrows){
  Homework[k] <- score_homework(unlist(scores[k, 1:9]))
}

scores$Homework <- Homework 

# Quiz scores
# Check columns
names(scores[, 11:14])

Quiz <- double(nrows)
for(k in 1:nrows){
  Quiz[k] <- score_quiz(unlist(scores[k, 11:14]))
}

scores$Quiz <- Quiz




# Overall score 
lab_w <- .10 
hwk_w <- .30
quiz_w <- .15
test1_w <- .20 
test2_w <- .25

Overall <- double(nrows)
for(k in 1:nrows){
  
  lab <- lab_w * scores[k, "Lab"]
  hwk <- hwk_w * scores[k, "Homework"] 
  quiz <- quiz_w * scores[k, "Quiz"]
  test1 <- test1_w * scores[k, "Test1"]
  test2 <- test2_w * scores[k, "Test1"]
  Overall[k] <- hwk + quiz + test1 + test2  + lab
}

scores$Overall <- Overall 


#score_lab()
grade_scores <- function(a = 0){
  if(a < 50){return("F")}
  else if(a < 60){return("D")}
  else if(a < 70){return("C-")}
  else if(a < 77.5){return("C")}
  else if(a < 79.5){return("C+")}
  else if(a < 82){return("B-")}
  else if(a < 86){return("B")}
  else if(a < 88){return("B+")}
  else if(a < 90){return("A-")}
  else if(a < 95){return("A")}
  else{ return("A+")}
}

Grades <- character(nrows) 

for(k in 1:nrows){
  Grades[k] <- grade_scores(scores[k, "Overall"])  
}

scores$Grades <- Grades


col_names <- c("Lab", "Homework", "Quiz", "Test1", "Test2", "Overall")


for(name in col_names){
  write_file <- file.create(paste0("output/",name, "-stats.txt"))
  sink(paste0("output/", name, "-stats.txt"))
  print_stats(scores[, name])
  sink()
}

sink(sink_file)
str(scores)
sink()

# Got to top of file

write.csv(scores, "data/cleandata/cleanscores.csv")










