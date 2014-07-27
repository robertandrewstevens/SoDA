# Software for Data Analysis:  Programming with R
# by John M. Chambers
# Chapter 3:  Programming with R:  The Basics

library(SoDA)
help(Examples)
exampleFiles()
#runExample(what, where, TRUE, TRUE)

## 3.1  From Commands to Functions

library(HSAUR)

str(clouds)

formula <- rainfall ~ seeding * (sne + cloudcover + prewetness + echomotion) + time
model <- lm(fromula, data = clouds) # intensional error
model <- lm(formula, data = clouds)

model2 <- update(model, ~ . - sne - seeding:sne)
par(pty = "s")
plot(resid(model), resid(model2))
abline(0, 1)

#identify(resid(model), resid(model2))

upd <- function(drop) {
  model2 <- update(model, drop)
  plot(resid(model), resid(model2))
  abline(0, 1)
  model2
}

modelSne   <- upd(~ . - sne        - seeding:sne       )
modelCover <- upd(~ . - cloudcover - seeding:cloudcover)
modelEcho  <- upd(~ . - echomotion - seeding:echomotion)

# dropFormula in Section 8.4, page 304

dropFormula
dropModel

modelSne   <- dropModel(model, "sne")
modelCover <- dropModel(model, "cloudcover")
modelEcho  <- dropModel(model, "echomotion")

## 3.3  Function Objects and Function Calls

### Function objects

f <- function(x) x + 1
environment(f)
identical(environment(f), .GlobalEnv)

### Function calls

myCall <- quote(mad(xx[ , j], constant = curConst, na.rm = TRUE))
myCall[[1]]
myCall[[2]]
names(myCall)

### Example:  A function and calls to it

mad

dput(formals(mad))

xDefault <- formals(mad)$x
class(xDefault)
missing(xDefault)

match.call(mad,
  quote(mad(xx[ , j], constant = curConst, na.rm = TRUE)))

### Operators

'%perp%' <- function(y, x)
  lsfit(x, y, intercept = FALSE)$residuals
x <- 1:10
y <- x + 0.25*rnorm(10)
y %perp% x

## 3.5  Interactive Debugging by Browsing

### Browsing in multiple contexts:  recover()

str(npk)
aov(yield ~ N + K + Error(block/(N + K)), data = npk)

### Browsing on warnings

bar(rnorm(10)) # can't locate this function
# Error: could not find function "bar"

options(warn = 2)

## 3.6  Interactive Tracing and Editing

zapsmall()
trace(zapsmall, browser)
zapsmall(xx)

trace(zapsmall, edit = TRUE)

binaryCount <- function(nodes, leafValues) {
  nL <- length(leafValues)
  nN <- nrow(nodes)
  left  <- nodes[ , 1]
  right <- nodes[ , 2]
  left  <- ifelse(left  < 0, -left , left  + nL)
  right <- ifelse(right < 0, -right, right + nl)
  count <- c(leaftValues, rep(NA, nN))
  while(any(is.na(count)))
    count <- c(leaftValues, count[left] + count[right])
  count[-seq(length = nL)]
}

trace(binaryCount, edit = TRUE)

binaryCount <- function(nodes, leafValues) {
  nL <- length(leafValues)
  nN <- nrow(nodes)
  left  <- nodes[ , 1]
  right <- nodes[ , 2]
  left  <- ifelse(left  < 0, -left , left  + nL)
  right <- ifelse(right < 0, -right, right + nl)
  count <- c(leaftValues, rep(NA, nN))
  iter <- 1
  while(any(is.na(count))) {
    message(iter, ": ", sum(is.na(count)))
    iter <- iter + 1
    count <- c(leaftValues, count[left] + count[right])
  }
  count[-seq(length = nL)]
}

nodeArea <- binaryCount(usTree@nodes, Area) # can't locate this dataset
# Error in binaryCount(usTree@nodes, Area) : object 'Area' not found

### How tracing works

trace(methods:::.onUnload, exit = browser)

trace(.Fortran, recover)
# Error in .makeTracedFunction(def, tracer, exit, at, print, doEdit) : 
#   (converted from warning) making a traced version of a primitive; arguments will be treated as '...'
