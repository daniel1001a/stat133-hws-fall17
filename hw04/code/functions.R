#2) Functions
##You will have to create the following functions in an R script functions.R 
library(testthat)
#remove_missing()
remove_missing <- function(a = c(1,2,3)){
  l = length(a)
  m = 1
  b = vector(length = 0L)
  for(i in 1:l){
    if(is.na(a[i])){
      m = m
    }
    else{
      b[m] = a[i]
      m = 1 + m
    }
  }
  if(length(b) == 0){
    return("Incorrect input")
  }
  else{
    return(b)
    }
}

#get_minimum()
get_minimum <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  a = sort(a, decreasing = FALSE)
  return(a[1])
}

#get_maximum()
get_maximum <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  a = sort(a, decreasing = TRUE)
  return(a[1])
}

#get_range()
get_range <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  return(get_maximum(a) - get_minimum(a))
}

#get_quartile1()
get_quartile1 <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  q <- quantile(a, na.rm = FALSE)
  return(as.double(q[2]))
}

#get_quartile3()
get_quartile3 <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  q <- quantile(a, na.rm = FALSE)
  return(as.double(q[4]))
}


#get_median()
get_median <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  a = sort(a)
  l = length(a)
  if(l %% 2 == 0){
    m = l/2
    return(0.5 * (a[m] + a[m + 1]))
  }
  else{
    m <- (l + 1) / 2
    return(a[m])
  }
}

#get_average()
get_average <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  l = length(a)
  s = 0
  for(i in 1:l){
    s = s+ a[i]
  }
  return( s/l)
}

#get_stdev()
get_stdev <- function(a = c(1,2,3), na.rm = TRUE){
  if(na.rm){
    a = remove_missing(a)
  }
  l = length(a)
  ave = get_average(a)
  s = 0
  m = l-1
  for(i in 1:l){
    s = s + ( a[i] - ave )^2
  }
  return(sqrt( s/m ))
}

# get_stdev(a, na.rm = TRUE)
#count_missing()
count_missing <- function( a = c(1,2,3)){
  l = length(a)
  m = 0
  for(i in 1:l){
    if(is.na(a[i])){
      m = 1 + m
    }
  }
  return(m)
}

#summary_stats()
summary_stats <- function(a){
  percent10 <- quantile(a, 0.1, na.rm = TRUE)
  percent30 <- quantile(a, 0.9, na.rm = TRUE)
  return(stats <- list(
    minimum = get_minimum(a, TRUE),
    maximum = get_maximum(a, TRUE), 
    percent10 = as.double(percent10),
    percent30 = as.double(percent30),
    quantile1 = get_quartile1(a, TRUE),
    quantile3 = get_quartile3(a, TRUE),
    median = get_median(a, TRUE),
    mean = get_average(a, TRUE),
    range = get_range(a, TRUE),
    stdev = get_stdev(a, TRUE),
    missing = count_missing(a)
  ))
  
}

#print_stats()
print_stats <- function(a){
  m = 0
  stats = summary_stats(a)
  for(i in 1:11){
    if(nchar(names(stats[i])) > m){
      m = nchar(names(stats[i]))
      }
  }
  for(i in 1:11){
    print(paste(format(names(stats[i]), width = m),
                format(round(as.double(stats[i]), 4), nsmall = 4),
                sep = " : ")
          )
  }
}

#drop_lowest()
drop_lowest <- function(a) {
  if(!is.numeric(a)) {
    stop("The vector contain not numeric variable")}
  l = length(a)
  m = get_minimum(a,na.rm = TRUE)
  for(i in 1:l){
    if (a[i] == m) {
      a[i] <- NA
      stop(return(remove_missing(a)))
    }
  }
}

#rescale100()
rescale100 <- function(x = c(1,2,3), xmin = 0, xmax = 0){
  up <-  x - xmin
  bot <- xmax - xmin
  return(z = 100 * ( up/bot))
}

#score_homework()
score_homework <- function(hws = c(1,2,3), drop = FALSE){
  if(drop){
    hws = drop_lowest(hws)
  }
  return(get_average(hws, na.rm = FALSE))
}

#score_quiz()
score_quiz <- function(quiz = c(1,2,3), drop = FALSE){
  if(drop){
    quiz = drop_lowest(quiz)
  }
  return(get_average(quiz, na.rm = FALSE))
}

#score_lab()
score_lab <- function(a = 0){
  if(a <= 6){return(0)}
  else if(a <= 7){return(20)}
  else if(a <= 8){return(40)}
  else if(a <= 9){return(60)}
  else if(a <= 10){return(80)}
  else if(a <= 12){return(100)}
}
