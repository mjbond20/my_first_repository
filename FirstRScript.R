

# Start Info----
# My Ver First Introduction to R
# Author: Michael Bond
# Date: March 4 2024
# Description: First Lecture notes from CP Bootcamp
# End Info-----



# Introduction -----
3 + 5
5 ^3
# multiple lines can be used, but don't do it, bad practice
3 +
  4
# multiple orders in single line w/ semicolon ;
3+5 ; 12-8

#First Vector
3:10

#Longer vector
3:100

6/2^2-1
#better than above is below
(6/2)^2-1

#R Objects ----
#My frist R object
a <- 3

die <- 1:6

#Naming objects:
NamesAreCaseSensitiive <- 3
NamesAreCaseSENSITIVE <- 5

#they cannot start with a number
1object <-100

#They cannot start with a special character
@nospecialCharacters <- 200

underscores_or.dots.are.okay <- 10 

# Can't use NA, NULL or TRUE as variable
NA <- 10
NULL <- 2
TRUE <- 9

# elementwise operations
die
die - 1
doubled_die <- die * 2

die * die
die * doubled_die

#Probability
probability = rep(1/6, 6)
probability
sum(die*probability)
die %*% probability

# %*% does the inner product
die %*% die 

#%o% die is outer product

#Vector multiplication
die * 1:2

# c() makes a vector

##recycles until it reaches the size and then cuts it off
die * 1:4

# Functions ----
round(3.5)

#create random number from normal distribution
rnorm(1)

factorial(5)
exp(2)
log2(16)
log10(120)

#Use tab within function to add the required values/variables
rnorm(n = 10, mean = 0, sd = 3)

#Vectors of numbers as an argument
mean(1:10)

#Functions always have parenthesis, if not it shows the code
mean

#using the ouput of one function as the input of another function
round(mean(1:10))
round(exp(2))

#cleaner way to do above
a <- exp(2)
rounded_a <- round(a)

#sample function randomly samples from a number defined by x
sample(x = die, size = 2, replace = TRUE)

#position of arguments matters, this is same as above
sample(die, 2, TRUE)

#There are some default values, below has a default size that is the same as szie (or whatever x would be) and a default of FALSE, so values aren ot replaced
sample(x = die)

#How to ask for help with functions use one questions marks
?sample

#How to ask for help and search with the name use two question marks
??sample

#to see the code
sample

#First Function ----
#Roll two dice and give sum
#Good function, return prints the output
roll2 <- function() {
  dice <- sample (x = 1:6, size = 2, replace = TRUE)
  return(sum(dice))
}

roll2()

#Bad function because die is not explicit, use 1:6 instead
roll3 <- function() {
  dice <- sample (x = die, size = 2, replace = TRUE)
  return(sum(dice))
}

roll3()

#Using extract function (highlight code and then go to code and hit extract function)
roll4 <- function(die) {
  dice <- sample(x = die, size = 2, replace = TRUE)
  sum(dice)
}

roll4()

#Packages ----

?install.packages()

install.packages("useful")

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")

qplot() # not working yet! Not in envionrment

# worked because we told R where to go
ggplot2::qplot() 

#Load whole library
library(ggplot2)

#package with packages within
install.packages("tidyverse")
library(tidyverse)

library(ComplexHeatmap)

# ComplexHeatmap::Heatmap() is better to write than Heatmap() 
# This means I am calling Heatmap from within ComplexHeatmap package

qplot()

x <- c(-1, 0.8, 0.5, 3, -2, 10, 1.1, 5)
x
y <- x^3
y
plot(x,y)

x <- c(-1, 0.8, 0.5, 3, -2, 10, 1.1, 5)
x <- sort(x)
y <- x^3
y 
qplot(x,y, type = "o")

qplot(y)

#This is to test to see if this will get added when I commit
#Trying again


# Write a function that rolls a pair of dice and reports their sum ----
roll_fair <- function(x) {
  dice <- sample(x = 1:6, size = 2, replace = TRUE)
  return(sum(dice))
}

roll_fair()

#Write a function that rolls a pair of loaded dice that are twice more likely
# to come 5 or 6 any other numbers and returns
roll_loaded <- function(){
  dice <- sample(x = c(1:6, 5,6), size = 2, replace = TRUE)
  return(sum(dice))
}

roll_loaded()

roll_loaded2 <- function(){
  dice <- sample(x = 1:6, size = 2, replace = TRUE, prob = c(1,1,1,1,2,2))
  return(sum(dice))
}

roll_loaded2()

#Repeat 1000 times and graph or sum

?replicate()

replicate(n = 1000, expr = roll_fair(), simplify = "array")

fair_sums <- replicate(n = 1000, expr = roll_fair(), simplify = "array")

loaded_sums <- replicate(n =1000, expr = roll_loaded(), simplify = "array")

plot(fair_sums)
hist(fair_sums)
hist(loaded_sums)
plot(loaded_sums)

fig1 <- ggplot2::qplot(fair_sums)
fig2 <- ggplot2::qplot(loaded_sums)

fig1

cowplot::plot_grid(fig1, fig2, nrow = 1)
# the ... in cowplot means number of graphs in grid

#Write a function that rolls 1000 die and returns the sum
#roll_many(n) --> roll n pairs of dice and return the sums

roll_many <- function(n){
  die1 <- sample(1:6, n, TRUE)
  die2 <- sample(1:6, n, TRUE)
  return(die1 + die2)
}

ggplot2::qplot(roll_many(1e4))

#magrittr ----

library(magrittr)

x <- 3
y <- exp(x)
z <- sqrt(y)
t <- log10(z)
s <- abs(t)

#This is the same but not as clean as above
s <- abs(log10(sqrt(exp(3))))

#This is the same and lets you change x
# %>% which is a pipe, eans "and then"
s <- x %>%
  exp() %>%
  sqrt() %>%
  log10() %>%
  abs()

subtraction <- function(x,y){
  return(x-y)
}

x <- 3

x %>%
  subtraction(1)

x %>%
  subtraction(1, .)

#R objects and notations ----

#atomic vectors
die <- (sample(x = 1:6, 2, replace = TRUE))
is.vector(die)
length(die) # will use often

five <- 5
is.vector(five)
length(five)

typeof(die)

#Assumes integer until you give it more information
typeof(die+ 0.0)

sqrt(2)^2 - 2

sqrt(4)^2 - 4


#Logical Vectors ----

logicals <- c(TRUE, FALSE, T, F, F, F)
typeof(logicals)

text <- c("Hello", "World")
length(text)
typeof(text)

five <- 5L
typeof(five)

#Coercion ----
logicals
int <- c(1L, 5L)

#r transforms logical to numerics
#below is the same as c(logicals, int)
logicals %>%
  c(int)
c(logicals, int)

#Making the integers logical
as.logical(int)

logicals %>%
  c(int) %>%
  c(die) %>%
  c(text) %>%
  typeof()

  