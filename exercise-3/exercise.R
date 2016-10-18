# Exercise 3: Data Frame Practice with `dplyr`.
# Use a different appraoch to accomplish the same tasks as exercise-1


# Install devtools package: allows installations from GitHub
install.packages('devtools')
install.packages('dplyr')

# Install "fueleconomy" package from GitHub
devtools::install_github("hadley/fueleconomy")

# Require/library the fueleconomy package
library(fueleconomy)
library(dplyr)

# Which Accura model has the best hwy MPG in 2015? (without method chaining)
filtered.acura = filter(vehicles, make=='Acura')
filtered.year = filter(filtered.acura, year==2015)
filtered.max = filter(filtered.year, hwy==max(hwy))
best.acura.2015 = select(filtered.max, model)

# Which Accura model has the best hwy MPG in 2015? (nesting functions)
best.acura.2015.nest = select(filter(filter(vehicles, make=='Acura', year==2015), hwy==max(hwy)), model)

# Which Accura model has the best hwy MPG in 2015? (pipe operator)
best.acura.2015.pipe = filter(vehicles, make=='Acura', year==2015) %>% filter(hwy==max(hwy)) %>% select(model)

### Bonus ###

# Write 3 functions, one for each approach.  Then, 
# Test how long it takes to perform each one 1000 times

WithoutChaining <- function(car.make, car.year){
  start.time = Sys.time()
  for(i in 1000){
    filtered.acura = filter(vehicles, make==car.make)
    filtered.year = filter(filtered.acura, year==car.year)
    filtered.max = filter(filtered.year, hwy==max(hwy))
    best.acura.2015 = select(filtered.max, model)
  }
  end.time = Sys.time()
  return(end.time-start.time)
}

NestedFunction <- function(car.make, car.year){
  start.time = Sys.time()
  for(i in 1000){
    select(filter(filter(vehicles, make==car.make, year==car.year), hwy==max(hwy)), model)
  }
  end.time = Sys.time()
  return(end.time-start.time)
}

PipeOperator <- function(car.make, car.year){
  start.time = Sys.time()
  for(i in 1000){
    filter(vehicles, make==car.make, year==car.year) %>% filter(hwy==max(hwy)) %>% select(model)
  }
  end.time = Sys.time()
  return(end.time-start.time)
}

time.without.chaining = WithoutChaining('Acura', 1995)
time.nested.function = NestedFunction('Acura', 1995)
time.pipe.operator = PipeOperator('Acura', 1995)
