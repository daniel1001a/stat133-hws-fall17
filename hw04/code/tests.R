#3 test the functions
##setup the vector in order make the test easier
a <- c(1, NA, 2,3)
b <- c(10, NA, 20, 30)
c <- c(100, NA, 200, 300)
d <- c(1000, NA, 2000, 3000)
#remove_missing()
context("remove_missing")
test_that("remove_missing",{
expect_equal(remove_missing(a), c(1,2,3))
expect_equal(remove_missing(b), c(10, 20, 30))
expect_equal(remove_missing(c), c(100, 200, 300))
expect_equal(remove_missing(d), c(1000, 2000, 3000))
})

#get_minimum()
context("get_minimum") 
test_that("get_minimum",{
expect_equal(get_minimum(a, na.rm = TRUE), 1)
expect_equal(get_minimum(b, na.rm = TRUE), 10)
expect_equal(get_minimum(c, na.rm = TRUE), 100)
expect_equal(get_minimum(d, na.rm = TRUE), 1000)
})

#get_maximum()
context("get_maximum") 
test_that("get_maximum",{
expect_equal(get_maximum(a, na.rm = TRUE), 3)
expect_equal(get_maximum(b, na.rm = TRUE), 30)
expect_equal(get_maximum(c, na.rm = TRUE), 300)
expect_equal(get_maximum(d, na.rm = TRUE), 3000)
})

#get_range()
context("get_range") 
test_that("get_range",{
expect_equal(get_range(a, na.rm = TRUE), 2)
expect_equal(get_range(b, na.rm = TRUE), 20)
expect_equal(get_range(c, na.rm = TRUE), 200)
expect_equal(get_range(d, na.rm = TRUE), 2000)
})

#get_quartile1()
context("get_quartile1") 
test_that("get_quartile1",{
expect_equal(get_quartile1(a), 1.5 )
expect_equal(get_quartile1(b), 15)
expect_equal(get_quartile1(c), 150)
expect_equal(get_quartile1(d), 1500 )
})

#get_quartile3()
context("get_quartile3") 
test_that("get_quartile3",{
expect_equal(get_quartile3(a), 2.5)
expect_equal(get_quartile3(b), 25)
expect_equal(get_quartile3(c),  250)
expect_equal(get_quartile3(d),  2500)
})

#get_median()
context("get_median") 
test_that("get_median",{
expect_equal(get_median(a), median(a, na.rm = TRUE))
expect_equal(get_median(b), median(b, na.rm = TRUE) )
expect_equal(get_median(c), median(c, na.rm = TRUE) )
expect_equal(get_median(d), median(d, na.rm = TRUE) )
})

#get_average()
context("get_average") 
test_that("get_average",{
expect_equal(get_average(a), mean(a, na.rm = TRUE ) )
expect_equal(get_average(b), mean(b, na.rm = TRUE) )
expect_equal(get_average(c), mean(c, na.rm = TRUE) )
expect_equal(get_average(d), mean(d, na.rm = TRUE) )
})

#get_stdev()
context("get_stdev") 
test_that("get_stdev",{
expect_equal(get_stdev(a), sd(a, na.rm = TRUE) )
expect_equal(get_stdev(b), sd(b, na.rm = TRUE) )
expect_equal(get_stdev(c), sd(c, na.rm = TRUE) )
expect_equal(get_stdev(d), sd(d, na.rm = TRUE) )
})

#count_missing()
context("count_missing") 
test_that("count_missing",{
expect_equal(count_missing(a),  1)
expect_equal(count_missing(b),  1)
expect_equal(count_missing(c),  1)
expect_equal(count_missing(d),  1)
})



#drop_lowest()
context("drop_lowest") 
test_that("drop_lowest",{
expect_equal(drop_lowest(a), c(2, 3))
expect_equal(drop_lowest(b), c(20, 30))
expect_equal(drop_lowest(c), c(200, 300))
expect_equal(drop_lowest(d), c(2000, 3000))
})

#rescale100()
context("rescale100") 
test_that("rescale100",{
expect_equal(rescale100(1, xmin = 0, xmax = 20), 5 )
expect_equal(rescale100(10, xmin = 0, xmax = 20), 50 )
expect_equal(rescale100(100, xmin = 0, xmax = 20), 500 )
expect_equal(rescale100(1000, xmin = 0, xmax = 20), 5000 )
})

#score_homework()
context("score_homework") 
test_that("score_homework",{
expect_equal(score_homework(a, drop = TRUE ),2.5)
expect_equal(score_homework(b, drop = TRUE), 25 )
expect_equal(score_homework(c, drop = TRUE),  250)
expect_equal(score_homework(d, drop = TRUE), 2500 )
})

#score_quiz()
context("score_quiz") 
test_that("score_quiz",{
expect_equal(score_quiz(c(1, 20,3), drop = TRUE ), 11.5)
expect_equal(score_quiz(c(1, 2,30), drop = TRUE ), 16)
expect_equal(score_quiz(c(1, 200,3), drop = TRUE ), 101.5)
expect_equal(score_quiz(c(1, 2,300), drop = TRUE ), 151 )
})

#score_lab()
context("score_lab") 
test_that("score_lab",{
expect_equal(score_lab(8), 40 )
expect_equal(score_lab(9), 60)
expect_equal(score_lab(10), 80)
expect_equal(score_lab(11), 100 )
})


    