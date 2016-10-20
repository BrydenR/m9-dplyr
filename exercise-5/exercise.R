# Exercise 5: DPLYR Grouped Operations

# Install the nycflights13 package and read it in. Require the dplyr package.
# install.packages("nycflights13")
library(nycflights13)
library(dplyr)

View(flights)

# In which month was the average departure delay the greatest?
# Hint: you'll have to perform a grouping operation before summarizing your data
greatest.average.delay = flights %>% 
                         group_by(month) %>% 
                         summarize(delay = mean(dep_delay, na.rm=TRUE)) %>% 
                         filter(delay==max(delay)) %>% 
                         select(month)

# If you create a data.frame with the columns "month", and "delay" above, you should be able to create 
# a scatterplot by passing it to the 'plot' function
plot(greatest.average.delay)

# In which airport were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation before summarizing your data
airport.with.greatest.delay = flights %>%
                              group_by(origin) %>%
                              summarize(delay = mean(arr_delay, na.rm=TRUE)) %>%
                              filter(delay==max(delay)) %>%
                              select(origin)

### Bonus ###
# Which city was flown to with the highest average speed?
city.with.highest.speed = flights %>%
                          group_by(dest) %>%
                          summarize(speed = mean(distance/((hour/60)+minute), na.rm=TRUE)) %>%
                          filter(speed==max(speed)) %>%
                          select(dest)
