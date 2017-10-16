#title: Ranking NBA Teams
#description: From the analytical point of view, we will focus on ranking tasks.This will give us an excuseto introduce Principal Components Analysis (PCA), from a narrow yet useful perspective.One of the deliverables is to calculate a composite index to rank NBA teams.
#input(s): what are the inputs required by the script?
#output(s): what are the outputs created when running the script?

#install package
library(ggplot2)
library(readr)
library(dplyr)
#read
dat_roster <- read.csv('/Users/Danielisgood/stat133-hws-fall17/hw3/data/nba2017-roster.csv', stringsAsFactors = FALSE)
dat_stats <- read.csv('/Users/Danielisgood/stat133-hws-fall17/hw3/data/nba2017-stats.csv')
setwd("/Users/Danielisgood/stat133-hws-fall17/hw3")

#missed_fg, missed_ft, points, rebounds, efficiency
dat_stats2 <- mutate(dat_stats, 
                     missed_fg = (field_goals_atts - field_goals_made),
                     missed_ft = (points1_atts - points1_made),
                     points    = (3 * (points3_made) + 2 * (points2_made) + 1 * (points1_made)),
                     rebounds  = (off_rebounds + def_rebounds),
                     efficiency = ((points + rebounds + assists + steals + blocks
                                    - missed_fg - missed_ft - turnovers) / games_played)
)
#Once you’ve computed the efficiency index, use sink() to send the R output of summary()

sink(file = '/Users/Danielisgood/stat133-hws-fall17/hw3/output/efficiency-summary.txt')
summary(dat_stats2[ , 'efficiency'])

#Merging Tables
totaldat <- merge(dat_roster,dat_stats2)
totaldat

#Creating nba2017-teams.csv
teams <- summarise(group_by(totaldat, team),
            experience = round(sum(experience),2),
            salary = round(sum(salary / 1000000), 2),
            points3 = sum(points3_made),
            points2 = sum(points2_made),
            free_throws = sum(points1_made),
            points = sum(points),
            off_rebounds = sum(off_rebounds),
            def_rebounds = sum(def_rebounds),
            assists = sum(assists),
            steals = sum(steals),
            blocks = sum(blocks),
            turnovers = sum(turnovers),
            fouls = sum(fouls),
            efficiency =  sum(efficiency)
            )

sink(file = '/Users/Danielisgood/stat133-hws-fall17/hw3/data/teams-summary.txt')

sink()
#export the teams table to a csv file named nba2017-teams.csv, inside the data/ folder
write.csv(teams, file = '/Users/Danielisgood/stat133-hws-fall17/hw3/data/nba2017-teams.csv',row.names = FALSE )

#use stars() to get a star plot fo the teams
pdf('/Users/Danielisgood/stat133-hws-fall17/hw3/images/teams_star_plot.pdf')
stars(teams[ ,-1], labels = teams$team )
dev.off


#use ggplot() to get a scatterplot of experience and salary, in which the names of the teams are included.
library(ggplot2)
experience_salary <- ggplot(teams, aes(x = experience, y = salary))+
  geom_point(size = 2, shape = 2, color = 3)+
  xlab("experience") + ylab("salary (in millions)")+
  geom_text(label = rownames(teams), size = 2, vjust = -1.5)
experience_salary

pdf(file = '/Users/Danielisgood/stat133-hws-fall17/hw3/images/experience_salary.pdf')
ggplot(size = 2, shape = 2, color = 3)+
  geom_point(size = 2, shape = 2, color = 3)+
  xlab("experience") + ylab("salary (in million")+
  geom_text(label = rownames(teams), size = 2, vjust = -1.5)
dev.off()




