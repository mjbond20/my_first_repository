install.packages(ggthemes)

#----
#Introduction to Tidyverse
#Michael Bond
#March 6, 2024

#load necessary libraries----
library(tidyverse)
library(useful)
library(nycflights13)
library(ggthemes)
library(scales)
library(ggrepel)
library(ggforce)
library(ggridges)
library(ggbeeswarm)

#Tibbles vs Data Frames----
vignette("tibble")

iris
?iris

iris %>% head()

as_tibble(iris)

tibble(x = 1:5,
       y = 1,
       z = x^2 + 1)

#you cannot refer to the previous column while creating a data.frame
data.frame(x = 1:5,
       y = 1,
       z = x^2 + 1)

tibble(":(" = "sad", "" = "space", "200" = "number")                          

iris[, "Sepal.Length"] %>% head

iris_t[, "Sepal.Length"]

tribble(~x, ~y, ~z,
        "a", 1, 2,
        "b", 3, 4)

nycflights13::flights
flights

flights %>%
  print(n = 10, width = Inf)

df <- tibble(x = runif(5),
             y = rnorm(5))

#All the same
df$x

df[["x"]]

df %>%
  .$x

df %>%
  .[["x"]]

as.data.frame(df)

df[1, ]
df[,1]
df[1]

as.data.frame(df[1, ])
as.data.frame(df[ ,1])

#Data Visualization ----
# |> is the same as %>% -----
#geom_point makes scatter plots
#mapping takes aesthetic argument which is aes()
?aes

mpg
ggplot(data = mpg) +
  geom_point(aes(x = displ,
                 y = hwy))

mpg %>% Hmisc::describe()

ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy,
                           y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ,
                           y = hwy))

mpg
nrow(mpg)
ncol(mpg)
dim(mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class,
                           y = drv))

?geom_jitter
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = class,
                           y = drv))
?geom_jitter
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = class,
                            y = drv), 
                            width = 0.1, height = 0.1)

ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ,
                            y = hwy,
                            color = class)) + 
  theme_bw()

#We lose SUVs becasue there are only 6 standard shapes
ggplot(mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy,
                           shape = class))

#scale_shape_manual allows you to add more shapes based on the numbering in the ppt
ggplot(mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy,
                           shape = class)) +
  scale_shape_manual(values = c(1:7))

#theme changes size and fonts
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ,
                            y = hwy,
                            color = class)) + 
  theme_bw(base_size = 16, 
           base_family = "GillSans")

#labs adds labels 
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ,
                            y = hwy,
                            color = class)) + 
  theme_bw(base_size = 16, 
           base_family = "GillSans") +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

#theme_base removes gridlines
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ,
                            y = hwy,
                            color = class)) + 
  theme_base(base_size = 16, 
           base_family = "GillSans") +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

#Change color scheme
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ,
                            y = hwy,
                            color = class)) + 
  theme_base(base_size = 16, 
             base_family = "GillSans") +
  scale_color_wsj() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

#Change the size, shape, and transparancy
ggplot(data = mpg) +
  geom_jitter(mapping = aes(x = displ,
                            y = hwy,
                            color = class),
              size = 4, alpha = 0.5) + 
  theme_base(base_size = 16, 
             base_family = "GillSans") +
  scale_color_wsj() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

#highlight all points
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ,
                            y = hwy,
                            color = class),
              size = 3, alpha = 0.75) + 
  geom_text(aes(x = displ, y = hwy, label = class)) +
  theme_base(base_size = 16, 
             base_family = "GillSans") +
  scale_color_wsj() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

#highlight some points ggrepell moves text away from points

ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, color = class)) +
  geom_point(size = 3, alpha = 0.75) + 
  geom_text_repel(data = mpg[mpg$class == "2seater", ],
            aes(label = class)) +
  theme_base(base_size = 14, 
             base_family = "GillSans") +
  scale_color_pander() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

#adding if else to calls

ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, color = class)) +
  geom_point(size = 3, alpha = 0.75) + 
  geom_text_repel(aes(label = ifelse(class == "2seater", class, NA)),
                  color = "black") +
  theme_base(base_size = 14, 
             base_family = "GillSans") +
  scale_color_pander() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

x <- ifelse(condition, x1, x2)

#two classes

ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, color = class)) +
  geom_point(size = 3, alpha = 0.75) + 
  geom_text_repel(aes(label = ifelse(class %in% c("2seater", "minivan"), class, NA)),
                  color = "black") +
  theme_base(base_size = 14, 
             base_family = "GillSans") +
  scale_color_pander() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

x <- ifelse(condition, x1, x2)

#Change color of points
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy), 
             color = "navy")

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, 
                 color = cty))

ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, 
                 color = cty)) +
  scale_color_viridis_b()

# Facets ----
#Facet_wrap ----
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(drv ~ class, )

#need period if you only want one variable
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(. ~ class, )

#scales
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(. ~ class, 
             scales = "free_x")

ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(. ~ class, 
             scales = "free_y")

ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(. ~ class, 
             scales = "free")

#change columns
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(. ~ class, 
             ncol = 2)

#change row
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap(. ~ class, 
             nrow = 1)

#facet_grid ----
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_grid(drv ~ class, scales = "free")

ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_grid(cyl ~ class, scales = "free")

#too many graphs to publish
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_grid(cyl ~ class + drv, scales = "free")

#ggforce----
#cutting down the number of displayed graphs, although it makes everything
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap_paginate(cyl ~ class + drv, scales = "free",
             nrow = 2, ncol = 3)

#look at pages as it made everything above, but should avoid the need for this
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_wrap_paginate(cyl ~ class + drv, scales = "free",
                      nrow = 2, ncol = 3,
                      page = 3)

#facet_zoom ----
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_zoom(xy = (displ > 5) & (hwy > 20))

#split zoom
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy)) +
  facet_zoom(xy = (displ > 5) & (hwy > 20),
             split = TRUE) +
  theme_bw()

#other variables
ggplot(mpg) +
  geom_point(aes(x = cyl,
                 y = hwy)) +
  facet_zoom(xy = (cyl > 5) & (hwy > 20),
             split = TRUE) +
  theme_bw()

# Geometric Objects ----

# points----
ggplot(mpg) +
  geom_point(aes(x = displ,
                 y = hwy))

#smooth line
ggplot(mpg) +
  geom_smooth(aes(x = displ,
                  y = hwy))

ggplot(mpg) +
  geom_smooth(aes(x = displ,
                  y = hwy, 
                  group = drv))

#change line type
ggplot(mpg) +
  geom_smooth(aes(x = displ,
                  y = hwy,
                  linetype = drv,
                  group = drv))

#change color
ggplot(mpg) +
  geom_smooth(aes(x = displ,
                  y = hwy, 
                  linetype = drv,
                  color = drv))

#remove axis
ggplot(mpg) +
  geom_smooth(aes(x = displ,
                  y = hwy, 
                  linetype = drv,
                  color = drv),
              show.legend = FALSE)

#add points and line together
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(aes(lty = drv))
                  
#add points and line together
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(aes(lty = drv), show.legend = FALSE)

#Making graph from slides
ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = class), size = 2) +
  geom_smooth(data = dplyr::filter(mpg, class != "2seater"),
              se = FALSE, color = "black")
  theme_base(base_size = 14, 
             base_family = "GillSans") +
  scale_color_ptol() +
  labs(x = "Engine Displacement (L)",
       y = "Highway Efficiency (miles/gallon)",
       color = "Class", shape = "Drive train",
       title = "Except 2 seaters, larger engine less efficient",
       subtitle = "2 seaters are ligher")

  #My attempts----
  #Plot1
  ggplot(mpg) +
    geom_point(aes(x = displ, y = hwy)) +
    geom_smooth(aes(x = displ, y = hwy))
  
  #Plot2
  ggplot(mpg) +
    geom_point(aes(x = displ, y = hwy)) +
    geom_smooth(aes(x = displ, y = hwy,
                line = drv))
             
  
  #Plot3
  ggplot(mpg) +
    geom_point(aes(x = displ, y = hwy)) +
    geom_smooth(aes(x = displ, y = hwy,
                    line = drv,
                    color = drv))
  
  #Plot 5
  ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
    geom_point(aes(color = drv)) +
    geom_smooth((aes(x = displ,
                    y = hwy,
                    linetype = drv,
                    group = drv)), color = "blue")
                   
  #Actual code----
  #Plot1
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(se = FALSE)
  
  #Plot2
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(aes(group = drv), se = FALSE)

#Plot3
  ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
    geom_point() +
    geom_smooth(aes(group = drv), se = FALSE)
  
#Plot4
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes (color = drv)) +
    geom_smooth(aes(group = drv), se = FALSE)

  #Plot5
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(aes (color = drv)) +
    geom_smooth(aes(lty = drv), se = FALSE)
  
  #Plot6
  ggplot(mpg, aes(x = displ, y = hwy)) +
    geom_point(color = "white", size = 5) +
    geom_point(aes(color = drv), size = 2)
  
  
  #box plot----
  mpg %>% 
    ggplot(aes(x = drv, y = hwy)) +
    geom_boxplot()
  
  #colors
  mpg %>% 
    ggplot(aes(x = drv, y = hwy)) +
    geom_boxplot(aes(fill = drv))
  
  #include points
  mpg %>% 
    ggplot(aes(x = drv, y = hwy)) +
    geom_boxplot(aes(fill = drv)) +
    geom_point()
  
  #include points
  mpg %>% 
    ggplot(aes(x = drv, y = hwy)) +
    geom_boxplot(aes(fill = drv)) +
    geom_jitter()
  
  #include points
  mpg %>% 
    ggplot(aes(x = drv, y = hwy)) +
    geom_boxplot(aes(fill = drv)) +
    geom_sina()
  
  #violin
  mpg %>% 
    ggplot(aes(x = drv, y = hwy)) +
    geom_boxplot(aes(fill = drv)) +
    geom_violin() +
    geom_sina()
  
  #violin
  mpg %>% 
    ggplot(aes(x = drv, y = hwy,
           color = drv)) +
    geom_violin() +
    geom_sina() +
    geom_boxplot(alpha = 0, color = "black")
  
  #violin with lines and no box
  mpg %>% 
    ggplot(aes(x = drv, y = hwy,
               color = drv)) +
    geom_violin( draw_quantiles = c(0.25, 0.5, 0.75), color = "black") +
    geom_sina()
  
  mpg %>% 
    ggplot(aes(x = drv, y = hwy,
               color = drv, fill = drv)) +
    geom_violin(color = "black",
                alpha = 0.1, show.legend = FALSE) +
    geom_sina(show.legend = FALSE) +
    geom_boxplot(alpha = 0, color ="black", width = .1, show.legend = FALSE) +
    theme_bw()
  
  #facet wrap to look at it seperated by classes
  mpg %>% 
    ggplot(aes(x = drv, y = hwy,
               color = drv, fill = drv)) +
    geom_violin(color = "black",
                alpha = 0.1, show.legend = FALSE) +
    geom_sina(show.legend = FALSE) +
    geom_boxplot(alpha = 0, color ="black", width = .1, show.legend = FALSE) +
    theme_bw() +
    facet_wrap(class ~ .)
  
  #facet wrap to look at it seperated by cylinder
  mpg %>% 
    ggplot(aes(x = drv, y = hwy,
               color = drv, fill = drv)) +
    geom_violin(color = "black",
                alpha = 0.1, show.legend = FALSE) +
    geom_sina(show.legend = FALSE) +
    geom_boxplot(alpha = 0, color ="black", width = .1, show.legend = FALSE) +
    theme_bw() +
    facet_wrap(cyl ~ ., nrow = 1)
  
  #Make a smaller data set ----
  
  mpg_tiny <- mpg %>%
    dplyr::filter(cyl %in% c(4,6),
                  drv %in% c("4", "f"))
  

  #geom_sina gives you points if there is a reasonable amount
  
#ggbeeswarm ----
  
ggplot(mpg, aes(class, hwy,
                color = drv)) +
  geom_quasirandom()
  
library(ggridges)
  mpg_tiny %>%
    ggplot() +
    geom_density_ridges()
  
  mpg %>%
  ggplot()
  
  
  #Bar graph, count is not part of the dataset
  #it is calcualted by r
  mpg %>%
    ggplot() +
    geom_bar(aes(x = class))
  
  #this is identical
  
  mpg %>%
    ggplot() +
    geom_bar(aes(x = class, y = after_stat(count)))
  
  
  #stat object
  ?stat
  
  mpg %>%
    ggplot() +
    geom_bar(aes(x = class, y=after_stat(prop)))
  
  mpg %>%
    ggplot() +
    geom_bar(aes(x = class, y=after_stat(prop), group = 1))
  
  mpg %>%
    dplyr::count(class) %>%
    ggplot() +
    geom_bar(aes(x = class, y = n), stat = "identity")
  
  #Stat summary to change what is plotted, in this case median
  mpg %>%
    ggplot() +
    stat_summary(aes(x = class, y = hwy),
                 fun = median,
                 fun.min = min, fun.max = max)

#This is saying to put class on x
   mpg %>%
    ggplot() +
    geom_bar(aes(x = class, fill = drv, 
                 y = after_stat(prop), 
                 group = drv))  

#Position argument ----

#stack
diamonds %>%
     ggplot() +
     geom_bar(aes(x = cut, fill = clarity))

#dodger
   diamonds %>%
     ggplot() +
     geom_bar(aes(x = cut, fill = clarity),
              position = "dodge")
   
#fill - proportions
   diamonds %>%
     ggplot() +
     geom_bar(aes(x = cut, fill = clarity),
              position = "fill")
   
#identity - things are on top of each other
   diamonds %>%
     ggplot() +
     geom_bar(aes(x = cut, fill = clarity),
              position = "identity", 
              alpha = 0.5)
   
   diamonds %>%
     ggplot() +
     geom_bar(aes(x = cut, color = clarity),
              position = "identity", 
              alpha = 0)
   
  #Histogram still need ggplot ----
   diamonds %>%
     ggplot() +
     geom_histogram(aes(x = carat))
   
   diamonds %>%
     ggplot() +
     geom_histogram(aes(x = carat, fill = cut))
   
   #Need smaller bins, default is 30
   diamonds %>%
     ggplot() +
     geom_histogram(aes(x = carat, fill = cut), 
                    binwidth = 5,
                    position = "dodge")
   
   diamonds %>%
     ggplot() +
     geom_histogram(aes(x = carat, fill = cut), 
                    position = "fill")
   

   mpg %>%
     ggplot() +
     geom_point(aes(x = displ, y = hwy), 
                position = "jitter")
   
   mpg %>%
     ggplot() +
     geom_boxplot(aes(x = class, y = hwy))
   
#this is what happens when you have x be an integer
#but we want it to be a character so we can tell it
   mpg %>%
     ggplot () +
     geom_boxplot(aes(x = cyl, y = hwy))
   
#interpreting it as a character
   mpg %>%
     ggplot () +
     geom_boxplot(aes(x = as.character(cyl), y = hwy))
   
#Most common
   mpg %>%
     ggplot () +
     geom_boxplot(aes(x = as.factor(cyl), y = hwy))
   
#fct_infreq
?fct_infreq
reorder()

mpg %>%
  ggplot() +
  geom_boxplot(aes(x = trans, y = displ))

#reorder ----
mpg %>%
  ggplot() +
  geom_boxplot(aes(x = reorder(trans, displ, median),
                   y = displ))

#play with boxplot ----
mpg %>%
  ggplot () +
  geom_boxplot(aes(x = as.factor(cyl), y = hwy))

mpg %>%
  ggplot () +
  geom_boxplot(aes(x = as.factor(cyl), y = hwy, fill = drv))

mpg %>%
  ggplot () +
  geom_boxplot(aes(x = trans, y = hwy, fill = drv))

mpg %>%
  ggplot() +
  geom_boxplot(aes(x = as.factor(cyl), 
                   y = hwy,
                   color = class)) +
  labs(x = "cyl")

mpg %>%
  ggplot() +
  geom_boxplot(aes(x = as.factor(cyl), 
                   y = hwy,
                   color = class),
               position = "identity") +
  labs(x = "cyl")

mpg %>%
  ggplot(aes(x = class, y = hwy)) +
  geom_boxplot()

mpg %>%
  ggplot(aes(x = class, y = hwy)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 75, 
                                  vjust = 1,
                                  hjust = 1))
mpg %>%
  ggplot(aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

mpg %>%
  ggplot(aes(x = reorder(class, hwy), y = hwy)) +
  geom_boxplot() +
  coord_flip()

bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
           show.legend = FALSE, width = 1)

bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
           show.legend = FALSE, width = 1) +
  theme(aspect.ratio = 1)

#Same thing as above, but showing how you can change labels
bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
           show.legend = FALSE, width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

#coord_flip, coord_polar, coord_trans, coord_cartesian, coord_fixed ----

bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
           show.legend = FALSE, width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL) +
  coord_flip()

bar + coord_flip()

bar <- ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut),
           show.legend = FALSE, width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL) +
  coord_polar()

bar + coord_polar()

bar2 <- bar + coord_flip()

bar3 <- bar + coord_polar()

p1 <- cowplot::plot_grid(bar, bar2, ncol = 1)
p1

cowplot::plot_grid(p1, bar3, nrow = 1)

mpg %>%
    ggplot() +
  geom_point(aes(x = displ, y =hwy)) +
  coord_trans(x = "log", y = "sqrt")

mpg %>%
  ggplot() +
  geom_point(aes(x = cty, y =hwy)) +
  coord_cartesian()

mpg %>%
  ggplot() +
  geom_point(aes(x = cty, y =hwy)) +
  coord_cartesian(xlim = c(0, NA),
                  ylim = c(0, NA))

mpg %>%
  ggplot() +
  geom_point(aes(x = cty, y =hwy)) +
  coord_cartesian(xlim = c(0, 50),
                  ylim = c(0, 50))

mpg %>%
  ggplot(aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth() +
  coord_cartesian(xlim = c(10,20), ylim = c(10,30))

mpg %>%
  ggplot(aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth() +
  coord_cartesian(xlim = c(10,20), ylim = c(10,35))

mpg %>%
  ggplot(aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth() +
  geom_abline() +
  coord_cartesian(xlim = c(10,20), ylim = c(10,35))

mpg %>%
  ggplot(aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth() +
  geom_abline() +
  geom_abline(slope = 2, intercept = 1) +
  coord_cartesian(xlim = c(10,20), ylim = c(10,35))

#distinguish the two lines
mpg %>%
  ggplot(aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth() +
  geom_abline() +
  geom_abline(slope = 2, intercept = 1, lty = 2) +
  coord_cartesian(xlim = c(10,20), ylim = c(10,35))

#Adding vertical and horizantel lines
mpg %>%
  ggplot(aes(x = cty, y = hwy)) +
  geom_point() +
  geom_smooth() +
  geom_abline() +
  geom_vline(aes(xintercept = 15)) +
  geom_hline(aes(yintercept = 20)) +
  geom_abline(slope = 2, intercept = 1, lty = 2) +
  coord_cartesian(xlim = c(10,20), ylim = c(10,35))
  