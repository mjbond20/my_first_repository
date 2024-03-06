
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

#Day 3 ----

#Pooled cell lines 
#paste0 means no sapces!

cell_line_data <- data.frame(cell_line = paste0("c", 1:100), # cell line index
                             growth_rate = runif(100, 0.5, 5), # doubling per day
                             lag_period = rexp(100, 1), # in days
                             initial_cell_count = sample(c(25,50,100), 100, replace = TRUE, prob = c(0.25, 0.5, 0.25)))


cell_line_data$lag_period %>%
  sort() %>% 
  plot(type = "s")

assay_end_point <- 5
pcr_bottleneck <- 2e4
seq_depth <- 1e6
threshold <- 40 * seq_depth / pcr_bottleneck

# First attempt (planning)
simulate_experiment <- function(){
  
  # calculate cell counts at the end-point
  lysate_cell_counts <- simulate_growth()
  
  # simulate the pcr bottleneck
  pcr_counts <- simulate_pcr()
  
  # simulate sequencing
  sequencing_counts <- simulate_sequencing()
  
  # visualize final population
  hist(sequencing_counts, 100)
  
  # count the detected cell lines
  detected_lines <- count_detected()
}

simulate_experiment <- function(cell_line_data, 
                                assay_end_point = 5, 
                                pcr_bottleneck = 2e4, 
                                threshold = NULL){
  if(is.null(threshold)){
    threshold <- 40 * seq_depth / pcr_bottleneck
  }
  # calculate cell coutns at the assay end-point
  lysate_cell_counts <- simulate_growth(cell_line_data, assay_end_point)
  
  #simulate pcr input (bottleneck)
  pcr_counts <- siulate_pcr(lysate_cell_counts, pcr_bottleneck)
  
  #simulate sequencing
  seqencing_counts <- simulate_seqencing(pcr_counts, seq_depth)
  
  #count the detected lines
  detected_lines <- count_detected(sequencing_counts, threshold)
  
  return(detected_lines)
  
}

#Breaking down function ----
simulate_growth <- function(cell_line_data, assay_end_point){
  
  #how long each cell doubled
  exponential_period <- pmax(assay_end_point - cell_line_data$lag_period, 0)
  #look for ?pmax()
  
  #how many doublings
  number_of_doublings <- exponential_period * cell_line_data$growth_rate
  
  #final cell counts
  lysate_cell_counts <- cell_line_data$initial_cell_count * 2^number_of_doublings
  
  return(lysate_cell_counts)
}


#small test
lysate_cell_counts <- simulate_growth(cell_line_data, 5)
plot(simulate_growth(cell_line_data, 3),
     simulate_growth(cell_line_data, 5))

#MSimulate_pcr----

simulate_pcr <- function(lysate_cell_counts, pcr_bottleneck){
  
  n <- length(lysate_cell_counts)
  
  # there is some room for improvement here
  sample_cells <- sample(n, pcr_bottleneck, replace = (TRUE), prob = lysate_cell_counts)
  
  pcr_counts <- rep(0, 100)
  
  for(x in 1:100){
    pcr_counts[x] <- sum(sample_cells == x)
  } 
  
  return(pcr_counts)
}


#Loops -----
pcr_counts <- rep(0, 100)

names(pcr_counts) <- 1:n

for(x in 1:100){
  pcr_counts[x] <- sum(sampled_cells == x)
}

##Alternative way
#sampled_table <- table(sampled_cells)
# pcr_counts <- rep(0, 100)
# names(pcr_counts) <- 1:n
# pcr_counts[names(sampled_table)] < sampled_table

#test
pcr_counts <- simulate_pcr(lysate_cell_counts, pcr_bottleneck)

hist(log2(lysate_cell_counts))
hist(pcr_counts)

plot (log2(1 + lysate_cell_counts),
      log2(1 + pcr_counts))

#simulate sequencing-----

simulate_sequencing <- function(pcr_counts, seq_depth){
  
  n <- length(pcr_counts)
  
  sampled_counts <- sample(n, seq_depth, replace = TRUE, prob = pcr_counts)
  sequencing_counts <- rep(0, n)
  
  for(x in 1:n){
    sequencing_counts[x] <- sum(sampled_counts == x)
  }
  
  return(sequencing_counts)
}

sequencing_counts <- simulate_sequencing(pcr_counts, seq_depth)

install.packages("psych")

data.frame(initial = cell_line_data$initial_cell_count,
           lysate = lysate_cell_counts,
           pcr_input = pcr_counts,
           se_output = sequencing_counts) %>%
  psych::pairs.panels()

data.frame(initial = log2(1 + cell_line_data$initial_cell_count),
           lysate = log2 (1 + lysate_cell_counts),
           pcr_input = log2(1 + pcr_counts),
           se_output = log2(1 + sequencing_counts)) %>%
  psych::pairs.panels()

# count the detected lines ----

detected_lines <- sum(sequencing_counts >= threshold)
detected_lines

?which
detected_lines_number <- which(sequencing_counts >= threshold)
detected_lines_number

#to get the names of the cell lines
detected_line_names <- cell_line_data$cell_line[sequencing_counts >= threshold]
detected_line_names

#debugging functions
?browser

simulate_sequencing <- function(pcr_counts, seq_depth){
  #put browser in function

  
  n  <- length(pcr_counts)
  
  sampled_counts <- sample(n, seq_depth, replace = TRUE, prob = pcr_counts)
  sequencing_counts <- rep(0, n)
  
  for(x in 1:n){
    sequencing_counts[x] <- sum(sampled_counts == x)
  }
  
  return(sequencing_counts)
}

#Some simmple examples of loops!

#For loops (iterative)
for(dummy in some_vector){
  do this for each value in the vector
}

for(value in c("my", "first", "for", "loop")){
  print("one run")
}

for(value in c("my", "first", "for", "loop")){
  print(value)
}

#can change the dummy variable to anything, for example word can be used
for(word in c("my", "first", "for", "loop")){
  print(word)
}

chars <- rep("", 4)
words <- c("My","second","for","loop")

for (i in 1:4){
  chars[i] <- words[i]
}

#Below is not good practice
chars <- c()
for(i in 1:4){
  chars <- c(chars, words[i])
}

#while loops:

while(condition){
  run this as long as the condition is TRUE

roll <- function(){
  sample(6, 2, replace = TRUE)
}

roll()

n = 4
while(n > 0){
  print(factorial(n))
  n = n - 1
}

# let's write a loop that calls roll() till it gets a 6,6 and
#counts how many times it is called

count <- 1
dice <- roll()

while(any(dice) != 12){
  count <- count + 1
  dice <- roll()
}

while(all(dice == c(6,6))){
  count <- count + 1
  dice <- roll()
}



#Let's simulate this experiment 1000 times and plot the histogram of the counts

roll_till_6_6 <- function(){
    count <- 1
    dice <- roll()
    while(any(dice != c(6,6))){
      count <- count + 1
      dice <- roll()
  }
  count
}

results <- replicate(1000, roll_till_6_6())
hist(results,100)

?any
?all

#one mor example
fizzbuzz <- function(n){
  if(n %% 15 == 0){
    return("FizzBuzz")
  }else if(n %% 3 == 0){
    return("Fizz")
  }else if (n %% 5 == 0){
    return("Buzz")
  }else{
    return(as.character(n))
  }
}

fizzbuzz(50)

#Write a vector version of fizzbuzz
#Test
c(45,46,48,50) ----> c("FizzBuzz", "46", "Fizz", "Buzz")

a <- c(45,46,48,50)

fizzbuzz <- function(n){
  if(n %% 15 == 0){
    return("FizzBuzz")
  }else if(n %% 3 == 0){
    return("Fizz")
  }else if (n %% 5 == 0){
    return("Buzz")
  }else{
    return(as.character(n))
  }
}

fizzbuzz_vector <- function(vec){
  n = length(vec)
  results = rep("", n)
  for(ix in 1:n){
    results[ix] <- fizzbuzz(vec[ix])
  }
  return(results)
}

fizzbuzz_vector(c(45,46,48,50))

#computationall efficient version
fizzbuzz_vector2 <- function(vec){
  results <- as.character(vec)
  results[vec %% 3 == 0] <- "Fizz"
  results[vec %% 5 == 0] <- "Buzz"
  results[vec %% 15 == 0] <- "FizzBuzz"
  
  return(results)
}

system.time(fizzbuzz_vector(1:1e6))
system.time(fizzbuzz_vector2(1:1e6))


