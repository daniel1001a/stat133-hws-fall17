# ===================================================================
# Title: Cleaning Data
# Description:
#   This script performs cleaning tasks and transformations on 
#   various columns of the raw data file.
# Input(s): data file 'raw-data.csv'
# Output(s): data file 'clean-data.csv'
# Author: Daniel Kang
# Date: 10-06-2017
# ===================================================================

#load package
library(readr)    # importing data
library(dplyr)    # data wrangling
library(ggplot2)  # graphics


dat <- data.frame(read_csv("/users/Danielisgood/stat133-hws-fall17/lab06/data/nba2017-players.csv"), 
                  col_types = list(player = col_character(),
                                   team = col_character(),
                                   position = col_character(),
                                   height = col_integer(),
                                   weight = col_integer(),
                                   age = col_integer(),
                                   experience = col_integer(),
                                   college = col_character(),
                                   salary = col_double(),
                                   games = col_integer(),
                                   minutes = col_integer(),
                                   points = col_integer(),
                                   points3 = col_integer(),
                                   points2 = col_integer(),
                                   points1 = col_integer()),
stringsAsFactors = FALSE )

dat

warriros <- data.frame(filter(arrange(dat, salary), team == "GSW"))
write.csv(warriros,file = "/users/Danielisgood/stat133-hws-fall17/lab06/data/warriors.csv", row.names = FALSE )
lakers <- data.frame(filter(arrange(dat, desc(experience)), team == "LAL"))
write.csv(lakers,file = "/users/Danielisgood/stat133-hws-fall17/lab06/data/lakers.csv", row.names = FALSE)





