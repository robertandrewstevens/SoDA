# Software for Data Analysis:  Programming with R
# by John M. Chambers
# Chapter 5:  Objects
# 5.1 Objects, Names, and References
# 5.2 Replacement Expressions
# 5.3 Environments
# 5.4 Non-localAssignments; Closures
# 5.5 Connections
# 5.6 Reading and Writing Objects and Data

library(SoDA)
help(Examples)
exampleFiles()
#runExample(what, where, TRUE, TRUE)

## 5.1 Objects, Names, and References

## 5.2 Replacement Expressions

## 5.3  Environments

search()

ev2 <- parent.env(.GlobalEnv)
environmentName(ev2)
ev3 <- parent.env(ev2)
environmentName(ev3)

find("summary")
find("Aids2")

require(MASS)
search()
env2 <- parent.env(.GlobalEnv)
environmentName(ev2)
env3 <- parent.env(ev2)
environmentName(ev3)

environment(binaryRep)

## 5.4  Non-local Assignments; Closures

newIQ <- function(nData = 1000, probs = seq(0, 1, 0.25)) {
  dataBuf <- numeric(0)
  qBuf <- numeric(0)
  
  addData <- function(newdata) {
    n <- length(newdata);
    if(n + length(dataBuf) > nData)
      recompute(newdata)
    else
      dataBuf <<- c(dataBuf, newdata)
  }
  
  recompute <- function(newdata = numeric(0)) {
    qBuf <<- doQuantile(qBuf, c(dataBuf, newdata), probs)
    dataBuf <<- numeric(0)
  }
  
  getQ <- function() {
    if(length(dataBuf) > 0)
      doQuantile(qBuf, dataBuf, probs)
    else
      qBuf
  }
  list(addData = addData, getQ = getQ)
}

myData <- newIQ()

myData$addData(newdata) # need "newdata" ?
# Error in myData$addData(newdata) : object 'newdata' not found

quants <- myData$getQ()

newIQ <- function(nData = 1000, probs = seq(0, 1, 0.25)) {
  list(nData = nData, probs = probs,
       dataBuf <- numeric(0), qBuf <- numeric(0))
  
  'addData<-' <- function(IQ, update = FALSE, value) {
    n <- length(value);
    if(update || (n + length(IQ$dataBuf) > IQ$nData))
      recompute(IQ, value)
    else {
      IQ$dataBuf <- c(IQ$dataBuf, value)
      IQ
    }
  }
  
  recompute <- function(IQ, newdata = numeric(0)) {
    IQ$qBuf <<- doQuantile(qBuf, c(IQ$dataBuf, newdata), IQ$probs)
    IQ$dataBuf <<- numeric(0)
    IQ
  }
  
  getQ <- function(IQ) {
    if(length(IQdataBuf) > 0)
      doQuantile(IQ$qBuf, IQ$dataBuf, IQ$probs)
    else
      IQ$qBuf
  }
}


## 5.5 Connections

## 5.6 Reading and Writing Objects and Data
