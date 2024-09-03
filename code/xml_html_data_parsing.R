
## Download data 
getwd()
setwd(paste(getwd(),"data", sep = "/"))
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
destfile <- "simple.xml"
download.file(url = fileUrl,destfile = destfile, method = "curl")
### View the file by clicking it in the folder

## Load xml package 
library(XML)

## Read the file with xmlTreeParse()
## useInternal must be TRUE to create the objects class XMLInternalDocument
doc <- xmlTreeParse("simple.xml", useInternalNodes = T)
class(doc)


## Access the top node with xmlRoot(here is the breakfast menu in the xml file)
xmlRoot(doc)
topNode <- xmlRoot(doc)
class(topNode)
xmlName(topNode)

## Obtain all the nodes with the tag we want (here is food) with getNodeSet
getNodeSet(topNode, "//food")
nodeSet <- getNodeSet(topNode, "//food")
class(nodeSet)
nodeSet

## Use xmlSApply and xmlValue to obtain the values
nodeValue <- xmlSApply(nodeSet, xmlValue)
class(nodeValue)
names(nodeValue)
nodeValue

nodeValue2 <- xmlSApply(nodeSet, function(x)xmlSApply(x, xmlValue))
class(nodeValue2)
names(nodeValue2)
nodeValue2
t(nodeValue2)
df1 <- data.frame(t(nodeValue2))
class(df1)
View(df1)


## Althernative method using xpathSapply and xmlValue for each child nodes
name <- xpathSApply(topNode,"//name",xmlValue )
price <- xpathSApply(topNode, "//price",xmlValue)
description <-xpathSApply(topNode, "//description", xmlValue)
calories <- xpathSApply(topNode, "//calories", xmlValue)

df2 <- data.frame(name, price, description, calories)
View(df2)
str(df2)



# Reading Json ------------------------------------------------------------

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names((jsonData))
names(jsonData$owner)
names(jsonData$owner$login)

muJson <- toJSON(iris, pretty = T)
cat(muJson)
iros2 <- fromJSON(muJson)
head(iros2)
