# Software for Data Analysis:  Programming with R
# by John M. Chambers
# Chapter 4:  R Packages

library(SoDA)
help(Examples)
exampleFiles()
#runExample(what, where, TRUE, TRUE)

## 4.3  Creating a Package

SoDAObjects <- c("geoXY", "geoDist", "packageAdd")
# create subdirectory "RPackages"
package.skeleton("SoDA", SoDAObjects, path = "~/RPackages")

### Adding to source packages

# copy "triDiag.R" from SoDA package Examples directory to working directory and rename as "triDiagonal.R"
packageAdd("SoDA", "triDiagonal.R", "~/RPackages")

## 4.4  Documentation for Packages

promptPackage("SoDA")

### Documentation format and content

class?ts
methods?show
library(Matrix)
package?Matrix
#Error in `?`(package, Matrix) : 
#  no documentation of type ‘package’ and topic ‘Matrix’ (or error in processing help)

prompt(packageAdd)

## 4.5  Testing Packages

example(lm)

## 4.6  Package Namespaces

### Why and when to give your package a namespace

search()

## 4.8  Interfaces to Other Software

system.file(package = "SoDA")
# copy the 3 *.perl files from SoDA Examples subdirectory to Perl subdirectory
system.file("Perl", 
            c("findDateForm.perl", "hashWords.perl", "perlMonths.perl"),
            package = "SoDA")

list.files(system.file(package = "SoDA"))
