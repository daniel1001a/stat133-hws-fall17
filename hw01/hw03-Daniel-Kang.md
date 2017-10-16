hw03-Daniel-Kang
================
Daniel Kang
10/15/2017

``` r
setwd('/Users/Danielisgood/stat133-hws-fall17/hw3/report')
library(ggplot2)
library(readr)
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
teams_data <- read.csv('/Users/Danielisgood/stat133-hws-fall17/hw3/data/nba2017-teams.csv')
```

``` r
library(ggplot2)
#Basic Ranking
#Rank by total Salary
ggplot(teams_data, aes(x = reorder(team, salary), y = salary))+
  geom_bar(stat = 'identity', color = 'white', fill = 'grey')+
  coord_flip()+
  ylab("Total Salary") + xlab("Team")+
  ggtitle("NBA Team ranked by Total Salary")+
  geom_hline(yintercept = mean(teams_data$salary), color = "red", size = 1.5)
```

![](hw03-Daniel-Kang_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
#Rank by total Points
library(ggplot2)
ggplot(teams_data, aes(x = reorder(team, points), y = points))+
  geom_bar(stat = 'identity', color = 'white', fill = 'grey')+
  coord_flip()+
  ylab("Total Points") + xlab("Team")+
  ggtitle("NBA Team ranked by Total Points")+
  geom_hline(yintercept = mean(teams_data$points), color = "red", size = 1.5)
```

![](hw03-Daniel-Kang_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

``` r
#Rank by total Efficiency
library(ggplot2)
ggplot(teams_data, aes(x = reorder(team, efficiency), y = efficiency))+
  geom_bar(stat = 'identity', color = 'white', fill = 'grey')+
  coord_flip()+
  ylab("Total Efficiency") + xlab("Team")+
  ggtitle("NBA Team ranked by Total Efficiency")+
  geom_hline(yintercept = mean(teams_data$efficiency), color = "red", size = 1.5)
```

![](hw03-Daniel-Kang_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

``` r
#prcomp()
PCA <- prcomp(teams_data[c('points3', 'points2', 'free_throws', 'off_rebounds', 
              'def_rebounds', 'assists', 'steals', 'blocks', 'turnovers', 'fouls')], scale. = TRUE)
names(PCA)
```

    ## [1] "sdev"     "rotation" "center"   "scale"    "x"

``` r
#data frame with the eigenvalues:
eig_df <- data.frame(
  Eigenvalue = round(PCA$sdev^2, 4), 
  prop <- round((PCA$sdev^2) / sum(PCA$sdev^2), 4),
  cumProp = round(cumsum(prop), 4)
  )
eig_df
```

    ##    Eigenvalue prop....round..PCA.sdev.2..sum.PCA.sdev.2...4. cumProp
    ## 1      4.6959                                         0.4696  0.4696
    ## 2      1.7020                                         0.1702  0.6398
    ## 3      0.9795                                         0.0980  0.7378
    ## 4      0.7717                                         0.0772  0.8150
    ## 5      0.5341                                         0.0534  0.8684
    ## 6      0.4780                                         0.0478  0.9162
    ## 7      0.3822                                         0.0382  0.9544
    ## 8      0.2603                                         0.0260  0.9804
    ## 9      0.1336                                         0.0134  0.9938
    ## 10     0.0627                                         0.0063  1.0001

``` r
eig_df <- mutate(eig_df, cumprop = cumsum(prop))
eig_df <- round(eig_df, 4)
```

``` r
#Use the first two PCs to get a scatterplot of the teams
PCA_x <- as.data.frame(PCA$x)
PCA_x[ ,"team"] <- teams_data[ ,"team"]

ggplot(PCA_x, aes(x = PC1, y = PC2))+
  geom_text(aes(label = PCA_x$team))
```

![](hw03-Daniel-Kang_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

``` r
#Index based on PC1
S1 <- 100 * (PCA_x[ ,1] - min(PCA_x[ ,1])) / (max(PCA_x[ ,1]) - min(PCA_x[ ,1]))
S1t <- as.data.frame(S1)
S1t[ ,"team"] = teams_data[ ,"team"]
```

``` r
#NBA Teams ranked by scaled PC1
dim(S1t)
```

    ## [1] 30  2

``` r
ggplot(teams_data, aes(x = reorder(S1t$team, S1t$S1), y = S1))+
  geom_bar(stat = 'identity', color = 'white', fill = 'grey')+
  coord_flip()+
  ylab("First PC (scaled from 0 to 100)") + xlab("Team")+
  ggtitle("NBA Teams ranked by scaled PC1")
```

![](hw03-Daniel-Kang_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

Comments and Reflections
========================

``` r
#Was this your first time working on a project with such file structure? If yes, how do you feel about it?
#yes I feel it is pretty hard


#Was this your first time using relative paths? If yes, can you tell why they are important for reproducibility purposes?
#yes, It is more clearly 


#Was this your first time using an R script? If yes, what do you think about just writing code?
#No.


#What things were hard, even though you saw them in class/lab?
#PCA part was hard


#What was easy(-ish) even though we haven’t done it in class/lab?
#ggplot


#Did anyone help you completing the assignment? If so, who?
#Yes, GST and lab assistents 


#How much time did it take to complete this HW?
#over 8 hours 


#What was the most time consuming part?
#self-learning PCA


#Was there anything interesting?
#I like to look at the graph after I analyst it. It is cool
```
