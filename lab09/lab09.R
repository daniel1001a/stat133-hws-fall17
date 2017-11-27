P(red) = P(red | bag1) P(bag1) + P(red | bag2) P(bag2)

P(white) = P(white | bag1) P(bag1) + P(white | bag2) P(bag2)
bag1 <- c('white', 'white', 'red')
bag2 <- c(rep('white', 3), 'red')
bags <- c('bag1', 'bag2')
repetitions <- 1000
drawn_balls <- character(repetitions)

set.seed(345)
for (i in 1:repetitions) {
  # select one bag
  chosen_bag <- sample(bags, 1)
  
  # draw a ball from chosen bag
  if (chosen_bag == 'bag1') {
    drawn_balls[i] <- sample(bag1, 1)
  } else {
    drawn_balls[i] <- sample(bag2, 1)
  }
}

table(drawn_balls) / repetitions