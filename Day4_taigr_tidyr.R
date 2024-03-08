
# -----
# CP Bootcamp 2024: Introdction to Tidyverse Part 2
# Michael Bond
# March 7 2024
#Learning dplyr and tidyr
#------

# Libraries
library(tidyverse)
library(taigr)
options(taigaclient.path=path.expand("/opt/miniconda3/envs/taigapy/bin/taigaclient"))

taigr::load.from.taiga("taigr-data-40f2.7/tiny_matrix")

library(nycflights13)
library(stocks)

#Data Transformations----
#Filtering rows
#Arranging rows
#Selecting columns
#Adding (mutating) columns
#Grouping and summaries

flights
head(flights)
glimpse(flights)

#Filtering rows -----

jan1 <- flights %>%
    dplyr::filter(month == 1, day == 1)

#print and assign
(march24 <-flights %>%
    dplyr::filter(month == 3, day == 24))

sqrt(2)^2 == 2
1/49 * 49 == 1

near(1/49 * 49, 1)

(nov_dec <- flights %>%
    dplyr::filter(month >= 11))

#this is better
(nov_dec <- flights %>%
    dplyr::filter(month %in% c(11,12)))

tail(nov_dec)

#What does this mean?
flights %>%
    dplyr::filter(!(arr_delay > 120 | dep_delay > 120))

#same thing and cleaner, but seemed slower
flights %>%
  dplyr::filter(arr_delay <= 120, dep_delay <= 120)

#NA's are contigous
NA > 5
10 == NA
NA == NA

is.na(NA)

(df <- tibble(x = c(1,NA,3)))

# | means or
df %>%
  dplyr::filter((x > 1) | is.na(x))

df %>%
  dplyr::filter(!(x > 1))

#flighst with delay of 2 hrs or more

flights %>% 
    dplyr::filter(arr_delay >= 2)

#all flights to Houston

flights %>%
  dplyr::filter(dest == "IAH" | dest == "HOU" )

flights %>%
  dplyr::filter(dest %in% c("IAH", "HOU"))

#no departure time

flights %>%
  dplyr::filter(is.na(dep_time))

#Arrange ----

flights %>%
  dplyr::arrange(year, month, day)

flights %>%
  dplyr::arrange(dep_delay)

flights %>%
  dplyr::arrange(desc(dep_delay))

#same as above (only for numerical variables)
flights %>%
  dplyr::arrange(-dep_delay)

flights %>%
  dplyr::arrange(desc(dep_delay), day)

#NA's go at end regardless of ascending or descending order ----
dplyr::arrange(df, x)
dplyr::arrange(df, desc(x))

#DepMap -----
corner(CRISPRGeneDependency)
dim(CRISPRGeneDependency)
colnames(CRISPRGeneDependency)

OmicsSomaticMutations <- load.from.taiga(data.name='internal-23q4-ac2b', data.version=68, data.file='OmicsSomaticMutations')

OmicsSomaticMutations
OmicsSomaticMutations %>%
  as_tibble()

#Selecting columns by name
flights %>%
    dplyr::select(year, month, day)

flights %>%
    dplyr::distinct(year, month, day)

#all but things between year and day
flights %>%
  dplyr::select(-(year:day))

#same as above, better option because it uses !
flights %>%
  dplyr::select(!(year:day))

#Will keep all the columns
flights %>%
  dplyr::distinct(year, month, day, .keep_all = TRUE)

#Two ways to rename
flights %>%
  dplyr::distinct(Month = month, day, year)

flights %>%
  dplyr::rename(Month = month) %>% 
  head

#Relocation/rearrange columns
flights %>%
  dplyr::relocate(dep_time, sched_dep_time, .after = year)

flights %>%
  dplyr::relocate(dep_time, sched_dep_time, .before = month)

#helper functions

flights %>%
  dplyr::select(flight, time_hour, air_time, everything())

flights %>%
  dplyr::select(flight, time_hour, air_time, ends_with("delay"))

a <- "Michael Bond"

b <- "MICHAEL BOND"

c <- "michael bond"

d <- "michael:joseph:bond"

tolower(c(a,b,c))
toupper(c(a,b,c))
make.names(c(a,b,c))

word(a)
word(a, 1, -2)
word(a, 1:3)
word(d, 1, -2, sep = fixed("::"))
substr(d, 1,10)

flights %>%
  dplyr::count(month, day, year)

flights %>%
  dplyr::select(month, day, year)

OmicsSomaticMutations %>%
  glimpse

(trimmed_mutations <- OmicsSomaticMutations %>%
  dplyr::select(ProteinChange,
                HugoSymbol,
                ModelID,
                HessDriver,
                LikelyLoF))

#How many distinct driver (Hess) mutations
#with specified protein changes?
trimmed_mutations %>%
  dplyr::count(HessDriver)

trimmed_mutations %>%
  dplyr::distinct(HugoSymbol, HessDriver == TRUE)

#real solution, true is default 
trimmed_mutations %>%
  dplyr::filter(HessDriver, !is.na(ProteinChange)) %>%
  distinct(ProteinChange, HugoSymbol)

#barplot for top 3 genes

trimmed_mutations %>% head

favorites <- OmicsSomaticMutations %>%
  dplyr::filter(HugoSymbol == "KRAS")

favorites %>% glimpse

#you have to use c() ----
trimmed_mutations %>%
  dplyr::filter(HugoSymbol %in% c("KRAS", "BRAF", "MYC")) %>%
  ggplot() +
  geom_bar(aes(x = HugoSymbol, fill = HessDriver))

#Mutate: Creating/adding new columns ----

flights_small <- flights %>%
  dplyr::select(year:day,
                ends_with("delay"),
                distance,
                air_time)

flights_small

flights_small %>%
  dplyr::mutate(gain = dep_delay - arr_delay,
                speed = distance / air_time)

#change place of new columns you are adding
flights_small %>%
  dplyr::mutate(gain = dep_delay - arr_delay,
                speed = distance / air_time,
                .before = dep_delay)

#misc ----
x <- 1:10
x
lag(x)
lead(x)
diff(x)

sum(x)
cumsum(x)
cummean(x)

y <- c(1,2,2,NA,3,4)
rank(y)
min_rank(y)

#mutate ----

flights_small %>%
  dplyr::mutate(average_dep_delay = mean(dep_delay, na.rm = T))

flights_small %>%
  dplyr::mutate(average_dep_delay = mean(dep_delay, na.rm = T),
                log2_dep_delay = log2(dep_delay))

#Grouped summaries ----

data %>%
  group_by(grouping1, grouping2) %>%
  summarise(summary1 = f(),
            summary2 = g())

flights %>%
  dplyr::summarize(delay = mean(dep_delay, na.rm = TRUE))

flights %>%
  dplyr::summarize(ave_dep_delay = mean(dep_delay, na.rm = TRUE),
                   ave_arr_delay = mean(arr_delay, na.rm = TRUE),
                   med_dep_delay = median(dep_delay, na.rm = TRUE),
                   med_arr_delay = median(arr_delay, na.rm = TRUE))
flights %>%
  ggplot(aes(x = dep_delay,
             y = arr_delay)) +
  geom_density_2d()

#random sample
flights %>%
  dplyr::sample_n(1000) %>%
  ggplot(aes(x = dep_delay,
             y = arr_delay)) +
  geom_point()

#group ----
day_summaries <- flights %>%
  dplyr::group_by(month, day, year) %>%
  dplyr::summarize(ave_dep_delay = mean(dep_delay, na.rm = TRUE),
                   ave_arr_delay = mean(arr_delay, na.rm = TRUE),
                   med_dep_delay = median(dep_delay, na.rm = TRUE),
                   med_arr_delay = median(arr_delay, na.rm = TRUE))


day_summaries <- day_summaries %>%
  dplyr::group_by(day)

day_summaries

#ungroup
day_summaries <- flights %>%
  dplyr::group_by(month, day, year) %>%
  dplyr::summarize(ave_dep_delay = mean(dep_delay, na.rm = TRUE),
                   ave_arr_delay = mean(arr_delay, na.rm = TRUE),
                   med_dep_delay = median(dep_delay, na.rm = TRUE),
                   med_arr_delay = median(arr_delay, na.rm = TRUE)) %>%
  dplyr::ungroup()

delays <- flights %>%
  dplyr::group_by(dest) %>%
  dplyr::summarize(count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)) %>%
  dplyr::filter(count > 20, dest !="HNL")

delays %>%
    ggplot(aes(x = dist, y = delay)) +
    geom_point() +
    geom_smooth(se = FALSE)

not_cancelled <- flights %>%
  dplyr::filter(is.finite(dep_delay), is.finite(arr_delay))

not_cancelled %>%
  dplyr::group_by(tailnum) %>%
  dplyr::summarize(delay = mean(arr_delay)) %>%
  ggplot(aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

#average flight delay and how many times did it fly

colnames(not_cancelled)

not_cancelled %>%
  dplyr::group_by(tailnum) %>%
  dplyr::summarize(n = n(),
                   delay = mean(arr_delay)) %>%
  ggplot() +
  geom_point(aes(x = n, y = delay), alpha = 0.1)

not_cancelled %>%
  dplyr::group_by(tailnum) %>%
  dplyr::summarize(n = n(),
                   delay = mean(arr_delay)) %>%
  dplyr::filter(n > 25) %>%
  ggplot() +
  geom_point(aes(x = n, y = delay), alpha = 0.1)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::slice_head(n=3)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::slice_tail(n=3)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::arrange(dep_delay) %>%
  dplyr::slice_head(n=3)

not_cancelled %>%
  dplyr::group_by(month) %>%
  dplyr::arrange(dep_delay) %>%
  dplyr::sample_n(10)

#average arr delay among the ones that arrive late



# A useful short-cut
not_cancelled %>%
  dplyr::group_by(year, month, day) %>%
  dplyr::summarize(arr_delay1 = mean(arr_delay),
                  arr_delay2 = mean(arr_delay[arr_delay > 0]))

not_cancelled %>%
  dplyr::group_by(dest) %>%
  dplyr::summarize(distance_sd = sd(distance), distance_mean = mean(distance)) %>%
  dplyr::arrange(desc(distance_sd))

#When do the first and last flights leave each day

colnames(not_cancelled)

not_cancelled %>%
  dplyr::group_by(year, month, day) %>%
  dplyr::summarize(first_flight = min(dep_time),
                   last_flight = max(dep_time)) %>%
  dplyr::arrange(desc(first_flight)) %>%
  view()

flights_small %>%
  dplyr::group_by(day, month, year) %>%
  dplyr::filter(rank(desc(arr_delay)) < 10)

#Better way than above
flights_small %>%
  dplyr::group_by(day, month, year) %>%
  dplyr::arrange(desc(arr_delay)) %>%
  dplyr::slice_head(n = 9)

flights_small %>%
  dplyr::group_by(day, month, year) %>%
  dplyr::top_n(n = 9)

popular_destinations <- flights %>%
  dplyr::group_by(dest) %>%
  dplyr::filter(n() > 200) %>%
  dplyr::ungroup()

popular_destinations %>%
  dplyr::filter(arr_delay > 0) %>%
  dplyr::mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  dplyr::select(year:day, dest, arr_delay, prop_delay)

#safer version of above

popular_destinations %>%
  dplyr::filter(arr_delay > 0) %>%
  dplyr::group_by(dest) %>%
  dplyr::mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  dplyr::select(year:day, dest, arr_delay, prop_delay)

popular_destinations %>%
    dplyr::summarize(ave_del = mean(dep_delay, na.rm = T),
                     .by = dest)

popular_destinations %>%
  dplyr::summarize(ave_del = mean(dep_delay, na.rm = T),
                   .by = c(dest, month))
#Same data different representations
table1
table2
table3
table4a
table4b

#Compute rate per 10,000
table1 %>%
  dplyr::mutate(rate = cases / population * 10000)

#count cases per year
table1 %>%
  dplyr::count(year, wt = cases)

table1 %>%
  ggplot(aes(x = year, y = cases)) +
  geom_line(aes(group = country), color = "gray") +
  geom_point(aes(color = country)) +
  theme_bw()


#Tidy Data ----
#Tidy Data
#each dataset is a tibble, each variable is a column

#Pivoting----
#if one variable is spread across columns
pivot_longer()
#if an observation spread across rows
pivot_wider()

table4a

table4a %>%
  tidyr::pivot_longer(cols = c('1999', '2000'))

#change column names
tidy4a <- table4a %>%
  tidyr::pivot_longer(cols = c('1999', '2000'),
                      names_to = "year",
                      values_to = "cases")

table4b

tidy4b <- table4b %>%
  tidyr::pivot_longer(cols = 2:3,
                      names_to = "year",
                      values_to = "population")

#pivot_wider
view(table2)

table2 %>%
  tidyr::pivot_wider(names_from = type,
                     values_from = count) %>%
  view()

#Uniting and separating

table3

table3 %>%
  tidyr::separate(rate, into = c("cases", "population"))

table3 %>%
  tidyr::separate(rate, into = c("cases", "population")) %>%
  dplyr::mutate(cases = as.numeric(cases),
                population = as.numeric(population))

table3 %>%
  tidyr::separate(rate, into = c("cases", "population"),
                  convert = TRUE)

table3 %>%
  tidyr::separate(year, into = c("century", "year"),
                 sep = 2,
                 convert = TRUE)

#inverse of the separate is unite
table5

table5 %>%
  tidyr::unite(year, century, year, sep = "")

#We will learn this tomorrow morning, but we reproduced table1
#This joins two tables using their common variables
dplyr::left_join(tidy4a, tidy4b)
table1

#Missing values
stocks <- tibble(
  year = c(2015, 2015, 2015,2015, 2016, 2016, 2016),
  qtr = c(1,2,3,4,2,3,4),
  return = c(1.88, 0.56, 0.35, NA, 0.9, 0.16, 2.5)
)

stocks

stocks %>%
  tidyr::pivot_wider(names_from = year, values_from = return)

stocks %>%
  tidyr::pivot_wider(names_from = year, values_from = return) %>%
  tidyr::pivot_longer(cols = 2:3,
                      names_to = "year",
                      values_to = "return",
                      values_drop_na = TRUE)
stocks %>%
  tidyr::complete(year, qtr)

#Relational Data ----

# primary key uniquely identifies an observation in its own table
#foreign key uniquely identifies an observation in another table
#some datasets don't have primary keys, if so should make one

#checking if keys actually identifies each observation
planes %>%
  head

planes %>%
  dplyr::distinct(tailnum)

#check for duplicate rows
planes %>%
  dplyr::count(tailnum) %>%
  dplyr::filter(n > 1)

weather %>%
  dplyr::count(origin, year, month, day, hour) %>%
  dplyr::filter(n > 1)

#not good because n = 2 for some things
flights %>%
  dplyr::count(year, month, day, flight)

#This is good
flights %>%
  dplyr::count(flight, time_hour, carrier) %>%
  dplyr::filter(n > 1)

flights %>%
  dplyr::mutate(row_index = 1:n(),
                .before = year)
#n() is a shorthand for nrow() or n anything

#let's work with a trimmed dataset

flights2 <- flights %>%
  dplyr::select(year:day, hour, origin, dest, tailnum, carrier)

flights2 %>%
  dplyr::left_join(airlines)

# carrier is a foreign key, but it is critical to join because it is shared with the airlines table

#mutating joins and filtering joins ----

x <- tibble(key = 1:3,
            val_x = c("x1", "x2", "x3"))

y <- tibble(key = c(1,2,4),
            val_y = c("y1", "y2", "y3"))

x
y

dplyr::left_join(x,y)
dplyr::right_join(x,y)
dplyr::full_join(x,y)
dplyr::inner_join(x,y)

#we can explicitly specify the keys to join
x %>%
  dplyr::inner_join(y, join_by("key"))

#how do duplicate keys behave?
x <- tibble(key = c(1,2,2,1),
            val_x = c("x1", "x2", "x3", "x4"))

y <- tibble(key = c(1,2),
            val_y = c("y1", "y2"))

x
y

x %>%
  dplyr::left_join(y)

flights2
weather

flights2 %>%
  dplyr::left_join(weather, join_by("month", "day"))

# all the common column names
dplyr::left_join(flights2, weather)

dplyr::left_join(flights2, planes,
                 by = "tailnum")

#Join columns that have different column names for the same data
dplyr::left_join(flights2, airports,
                 by = c("origin" = "faa"))

dplyr::left_join(flights2, airports,
                 by = c("dest" = "faa"))

#Doesn't work
dplyr::left_join(flights2, weather,
                 by = c("month", "day", "origin"))

#Filtering joins ----
x
y

dplyr::semi_join(x,y)
dplyr::anti_join(x,y)

x <- tibble(key = 1:3,
            val_x = c("x1", "x2", "x3"))

y <- tibble(key = c(1,2,4),
            val_y = c("y1", "y2", "y3"))

x
y

dplyr::semi_join(x,y)
dplyr::anti_join(x,y)

(top_dest <- flights %>%
  dplyr::count(dest, sort = TRUE) %>%
  head(10))

#these are equivalent below
flights2 %>%
    dplyr::filter(dest %in% top_dest$dest)

flights2 %>%
  dplyr::semi_join(top_dest)

#all the tail numbers listed in flights 2 exist in planes
#have to join by some defining characteristic - in this case tailnum
flights2 %>%
  dplyr::anti_join(planes, by = "tailnum")

flights2 %>%
  dplyr::anti_join(planes, by = "tailnum") %>%
  dplyr::count(tailnum, sort = TRUE)


flights2 %>%
  dplyr::anti_join(planes, by = "tailnum") %>%
  dplyr::count(tailnum, sort = TRUE) %>%
  drop_na() %>%
  ggplot() +
  geom_histogram(aes(x = n), binwidth = 1,) +
  coord_fixed(10)

# Set operations ----

x <- 1:10
y <- rep(5:15, each = 2)

intersect(x,y)

union(x,y)

setdiff(x,y)
setdiff(y,x)
unique(y)

#Use w/ caution
colnmaes(CRISPRGeneDependency) <- colnames(CRISPRGeneDependency) %>% word()

rm(CRISPRGeneDependency)

#Cell Line Annotations ----


#Expression -----


#Loss of heterozygosity ----


#A small matrix ----


#Mutations -----