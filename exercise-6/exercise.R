# Exercise 6: DPLYR join introduction

# Install the nycflights13 package and read it in. Require the dplyr package.
# install.packages("nycflights13")
# install.packages("dplyr")
library(nycflights13)
library(dplyr)

flights <- nycflights13::flights
#View(flights)
# Create a dataframe of the average arrival delay for each destination, then use left_join
# to join on the "airports" dataframe, which has the airport info
avg.arrival.delay <- flights %>% 
  group_by(dest) %>% 
  summarise(avg.delay = mean(arr_delay, na.rm = TRUE)) %>% 
  mutate(faa = dest) %>% 
  left_join(airports, by = 'faa') %>% 
  arrange(-avg.delay)

# Create a dataframe of the average arrival delay for each airline, then use left_join
# to join on the "airlines" dataframe, which has the airline info
avg.arrival.delay.airline <- flights %>%
  group_by(carrier) %>%
  summarise(avg.airline.delay = mean(arr_delay, na.rm=TRUE)) %>%
  mutate(faa = carrier) %>%
  left_join(airlines, by='carrier') %>%
  arrange(-avg.airline.delay)


### Bonus ###
# Calculate the average delay by city AND airline, then merge on the city and airline information
avg.city.airline.delay <- flights %>%
  group_by(dest, carrier) %>%
  summarise(average.city.delay = mean(arr_delay, na.rm=TRUE)) %>%
  mutate('faa' = dest) %>%
  left_join(airlines, by='carrier') %>%
  left_join(airports, by='faa') %>%
  ungroup() %>%
  arrange(-average.city.delay)

# If you're running into sorting issues:
# http://stackoverflow.com/questions/26555297/dplyr-arrange-a-grouped-df-by-group-variable-not-working