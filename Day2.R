
# Bootcamp Day 2 3.5.24-------
# Michael Bond
# We are continuing with Base R

#loaded libraries ----
library(tidyverse)
library(useful)

# a royal flush
hand <- c("ace", "king", "queen", "jack", "ten")

#matrices are two dimensional vectors

?matrix()
die = 1:6
matrix(data = die)
m <- matrix(data = die, nrow = 2)
matrix(die, ncol = 2)
matrix(die, ncol = 3, byrow = TRUE)

seven = 1:7
matrix(data = seven)
matrix(seven, ncol = 2, byrow = TRUE)

matrix(c(die,1), nrow =2)

ar <- array(c(11:14, 21:24, 31:34), 
      dim = c(2,2,3))

attributes(die)
attributes(m)

names(die) <- c("one", "two", "three", "four", "five", "six")
attributes(die)
typeof(die)

dim(die) <-c(2,3)
die
attributes(die)

rownames(die) <- c("r1", "r2")
colnames(die) <- c("c1", "c2", "c3")
die

colnames(die) <- NULL
#NULL resets
die

class(die)
die <- 1:6
class(die)

#matrices are 2D vectors and arrays are 3D vectors

#Lists allow for multiple types of data in 1D
#Data Frame allows for multiple types of data in 2D
#Data Frames are lists of vectors

#we use lists to group arbitrary objects

list1 <- list(1:10, 3, "five", mean, matrix(1:12, 3))
list1

names(list1) <- c("vector", "numeric", "character", "function", "matrix")

list1

list2 <- list("vector" = 1:100, 
             "numberic" = 3, 
             "character" = "five", 
             "function" = mean, 
             "matrix" = matrix(1:12, 3))

list2

#a data frame is a list of vectors of the same length

df <- data.frame(face = c("ace", "two", "six"),
           suit = c("clubs", "clubs", "clubs"),
           value = c(1,2,3))

df

#if any of the entries is a constant, it will be recycled
data.frame(face = c("ace", "two", "six"),
           suit = c("clubs", "clubs", "clubs"),
           value = c(1))

typeof(df)
class(df)
str(df)

faces <- c("king", "queen", "jack", "ten", "nine", "eight", "seven",
           "six", "five", "four", "three", "two", "ace")

suits <- c("spades", "clubs", "diamonds", "hearts")

values <- seq(13,1, -1)
values

#trying to organize data frames ----
data.frame(let = rep(c("a", "b", "c"), 6),
           num = rep(c(1,2,3,4,5,6), 3))

#each makes values repeat that number of times
rep(c("a", "b", "c"), each = 2)

deck <- data.frame(suit = rep(suits, each = 13),
                   face = rep(faces, 4),
                   value = rep(values, time = 4))

deck

#how to save and load a data.fram
write.csv(x = deck, file = "~/Desktop/Basic_R_Programming/Data/deck.csv")
deck.read <- read.csv("Data/deck.csv")

deck.read

#How to eliminate extra column if no row names
write.csv(x = deck, file = "Data/deck.csv", row.names = FALSE)
deck.read <- read.csv("Data/deck.csv")
deck.read

head(deck)
head(deck, n =10)

tail(deck)
summary(deck)
glimpse(deck)

list1
saveRDS(list1, file = "Data/list.RDS")
list1.read <- readRDS("Data/list.RDS")
list1.read

random_matrix <- matrix(rnorm(3000), 50)
dim(random_matrix)
head(random_matrix)

corner(random_matrix)

write.csv(random_matrix,
          "Data/random_matrix.csv",
          row.names = FALSE)

random_matrix.read <- read.csv("Data/random_matrix.csv")

random_matrix.read %>% corner
random_matrix.read %>% class()

random_matrix.read <- read.csv("Data/random_matrix.csv") %>% as.matrix()

random_matrix %>% corner()

random_matrix.read <- data.table::fread("Data/random_matrix.csv") %>%
  as.matrix()
random_matrix.read

?fread

#Dicing and selecting datasets ----

dim(deck)
head(deck)
nrow(deck)

deck[1,1]
deck[1,1:3]
deck[1:5, 2:3]

deck[1:5, -3]
deck[1:4, c(-1,-3)]
deck[1:4, c(-1,3)] #this doesn't work

deck[1:4,c("suit", "value")]

names(die) <- c("one", "two", "three", "four", "five", "six")
die
die["three"]

deck[1:4, c(TRUE, FALSE, TRUE)]
deck[1:4, c(TRUE, TRUE, TRUE)]

deck[,2]
deck[,2, drop = FALSE] #stops data frame from turning into a single vector

deck$ #lets you choose just one column
deck$suit
deck$face
deck[deck$suit == "spades" , ]


list1 <- list(1:10)
list1$vector
list1$character

list2 <- list1[1]
list2 %>% class
length(list2)

list1[1:2]

vector2 <- list1[[1]]
vector2

list1[1:2]
list1[-1]

deck$value %>%
  median()

deck$suit

deck$suit %>%
  unique()

suit.table <- deck$suit %>%
  table()

suit.table["clubs"]

deck$suit == "clubs"

sum(deck$suit == "clubs")

mean(deck$suit == "clubs")

deck2 <- deck

vec <- rep(0, 6)
vec

vec[1]
vec[1] <- 1000

vec

vec[c(1,3,5)] <- c(1,2,1)
vec
vec[4:6] <- vec[4:6] + 1
vec
vec[1:3] <- vec[1:3] + vec[4:6]
vec

vec[7] <- 0
vec
vec[7] <- NA
vec
vec <- vec[-7]
vector2

deck2 <- deck

deck2 %>% head()

deck2$new <- NULL

deck2 %>% 
  head()

#Let's bump the values of aces to 15
# where are the aces?

deck2[c(13, 26, 39, 52), ]
deck2[c(13, 26, 39, 52), 3]
deck2[c(13, 26, 39, 52), 3] <- c(14,14,14,14)
deck2
#doing the same thing
deck2[c(13, 26, 39, 52), 3] <- 14
deck2$value[c(13, 26, 39, 52)] <- 14
deck2[c(13, 26, 39, 52), ]$value <- 14
deck2[c(13, 26, 39, 52), "value"] <- 14

sample(10, 3)

#shuffling the deck
deck3 <- deck[sample(52), ]

deck3

deck3$face  == "ace"
deck3[deck3$face == "ace", ]
deck3[deck3$face == "ace", 3] <- 14
deck3[deck3$face == "ace", ]

#some simple examples with booleans
1>2
2>1
1 > c(0,1,2)
c(1,2) > c(0,1,2)  
c(1,2,3) == c(3,2,1)
#are these the same?
all(c(1,2,3) == c(3,2,1))

1 %in% c(3,4,5)

c(1,2) %in% c(3,4,5) # no recycling!

c(1:4) %in% c(3:4)

deck4 <- deck[sample(52), ]
deck4

deck4[deck4$suit == "hearts", 3] <- 1
deck4
deck4[deck4$suit != "hearts", 3] <- 0
deck4

#Another way to do it
hearts <- deck4$suit == "hearts"
not_hearts <- deck4$suit != "hearts"
deck4[hearts, 3] <- 1
deck4[!hearts, 3] <- 0

deck4$value <- 0
deck4[hearts, 3] <- 1

#Next thing

hearts <- deck4$suit == "hearts"

hearts

deck4$value <- as.numeric(hearts)

queens <- deck4$face == "queen"
spades <- deck4$suit == "spades"
deck4[queens & spades, 3] <- 13
deck4[queens & spades, ]

#NAs are contigious
1 + NA
NA == 1 
c(NA, 1:50)
mean(c(NA, 1:50))

mean(c(NA, 1:50), na.rm = TRUE)

x <- c(NA, 1:50)

is.na(x)

x[!is.na(x)]

x <- c(NA, 1:50, 1/0)
x
is.finite(x)

deck
#function that takes deck as input and takes another input as 
#number of cards (4) called deal

deal <- function(deck, n =5){
  n.deck <- nrow(deck)
  shuffled_deck <- deck[sample(n.deck), ]
  hand <- head(shuffled_deck, n)
  rest <- tail(shuffled_deck, n.deck-n)
  return(list(hand = hand, rest = rest))
}

deck
current.deck <- deck

temp <- deal(current.deck)
hand1 <- temp$hand
current.deck <- temp$rest

temp <- deal(current.deck)
hand2 <- temp$hand
current.deck <- temp$rest

temp <- deal(current.deck)
hand3 <- temp$hand
current.deck <- temp$rest

temp <- deal(current.deck)
hand4 <- temp$hand
current.deck <- temp$rest

hand1
hand2
hand3
hand4

#DepMap/Skyros Intro
install.packages('devtools')
library(devtools)
devtools::install_github("https://github.com/broadinstitute/taigr", force=T)
dir.create(path.expand("~/.taiga"))
write("1012a156-dd30-4f34-85ae-a76187bf2aec", file=path.expand("~/.taiga/token"))

options(taigaclient.path=path.expand("/opt/miniconda3/envs/taigapy/bin/taigaclient"))

taigr::load.from.taiga("taigr-data-40f2.7/tiny_matrix")

#Conditionals-----

num <- -2

absolute_value <- function(num) {
  if(num <0){
    num <- num * -1
  }
  num
}

absolute_value(4)
absolute_value(-4)

absolute_value <- function(num) {
  if(num <0){
    print("Input is negative, don't worry I will fix it.")
    num <- num * -1
  }
  num
}

absolute_value(-4)

#Quick quiz
x <-1
if(3 == 3){
  x <-2
}
x

x <- 1
if(TRUE){
  x <- 2
}
x

#If else statement where input gets changed once
x <- 1
if(x ==1){
  x <- 2
  if(x == 1){
    x <- 3
  }
}
x

#If else statement where input gets changed twice
x <- 1
if(x ==1){
  x <- 2
  if(x == 2){
    x <- 3
  }
}
x

a <- 3.14
dec <- a - trunc(a)
dec

if(dec >= 0.5){
  a <- trunc(a) + 1 
} else {
  a <-  trunc(a)
}

a <- 5
b <- 5

if(a>b){
  print("A wins!")
}else if(a < b){
  print("B wins!")
}else{
  print("Tie.")
}

#Write a function that takes one integer as input and
#prints "Fizz" if it is a multiple of 3, prints "Buzz" if it is 
#a multiple of 5, and "FizzBuzz" if it is a multiple of 15
#If the input is none of those, print the input itself

# Remainder
47 %% 3

#Integer divsions
47 %/% 3

n <- 67
div3 <- n %% 3
div5 <- n %% 5
div15 <- n %% 15

FizzBizz <- function(n){
  if (div15 == 0){
  print("FizzBuzz")
}else if(div5 == 0){
  print("Fizz")
}else if(div3 == 0){
  print("Buzz")
}else{
  print(num)
}
}

FizzBizz()

#Sometimes it is easier to use look-up table:

print_die <- function(x){
  if(x == 1){
    print("One")
  }else if(x == 2){
  }...
  else{
    print("Input is not between 1 and 6")
  }
}


x <- 4

print_die <- function(x){
  die = c("one", "two", "three", "four", "five", "six")
  if (x %in% 1:6){
    print("Input is between 1 and 6")
  }else{
    print("Input is not between 1 and 6")
  }
}

print_die(2*x)



