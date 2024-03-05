
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

  