# Software for Data Analysis:  Programming with R
# by John M. Chambers
# Chapter 2:  Using R

library(SoDA)
help(Examples)
exampleFiles()
runExample(what, where, TRUE, TRUE)

## 2.2 An Interactive Session

### See p. 176-177
### http://www.pafko.com/tycho/observe.html
### mars.xls -> mars.csv

mars <- read.csv("mars.csv", skip = 5, as.is = TRUE)
dim(mars)
sapply(mars, class)

with(mars, quantile(Declination))

with(mars, plot(Date, Declination))

## Options during evaluation

getOption("digits")

1.234567890
options(digits = 4)
1.234567890

## 2.3 The Language

## Function Calls

with(mars, plot(Date, Declination))

?jitter

formalArgs(jitter)

jitter

## Operators

mars$Date
mars[["Date"]]

## Iteration:  A quick introduction

for(what in c("p", "l", "b")) with(mars, plot(Date, Declination, type = what))

for(j in names(mars)) print(class(mars[, j]))

sapply(mars, class)

## 2.5 Functions and Packages

find("dotplot")

library(lattice)
find("dotplot")

find("gam")
library(gam)
find("gam")
library(mgcv)
find("gam")
