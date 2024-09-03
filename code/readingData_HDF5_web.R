
# Reading from HDF5 -------------------------------------------------------

## Install HDF5 package from bioconductor
install.packages("BiocManager")
BiocManager::install("rhdf5")

## Load the rhdf5 package
library(rhdf5)

## Create hdf5 file
getwd()
setwd(paste(getwd(), "data",sep = "/"))
rm(list=ls())
created = h5createFile("example.h5")

created ###Check if the file is created

## Create groups in the file
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa") ###subgroup
h5ls("example.h5") ### list the content of h5 file

## Write to the group
A = matrix(1:10, nr = 5, nc = 2) ###create a matrix first
h5write(A, "example.h5","foo/A")

B = array(seq(0.1, 2.0, by = 0.1), dim = c(5,2,2))
attr(B, "scale") <- "litre"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

## Write a dataset directly
df = data.frame(1L:5L, seq(0, 1, length.out = 5),
                c("ab", "cde", "fghi","a", "s"), stringsAsFactors = F)
h5write(df, "example.h5", "df")
h5ls("example.h5")


## Read data from h5 file with readh5("file", "path")
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5","df" )

readA
readB
readdf

## Writing and reading chunks (here replace the cells)
h5write(c(12,13,14), "example.h5", "foo/A", index =list(1:3, 1))
h5read("example.h5", "foo/A")


# Reading Web -------------------------------------------------------------

rm(list = ls())
## Open a connection to a particular url
connection <- url(
  "https://scholar.google.com/citations?hl=en&user=HI-I6C0AAAAJ"
)
htmlCode <- readLines(connection)

## Close the connection
close(connection)
htmlCode

## Parsing with XML package
library(XML)
url <- "https://scholar.google.com/citations?hl=en&user=HI-I6C0AAAAJ"
download.file(url, "jtleek.html", method = "curl")
html <- htmlTreeParse("jtleek.html", useInternalNodes = T)
class(html)
html
xpathApply(html, "//title", xmlValue)
x <- xpathSApply(html, "//td//a", xmlValue)
x <- x[4:43]
length(x)
m <- matrix(x, nrow = 20, ncol = 2, byrow = T)

## GET from httr package
library(httr)
rm(list = ls())
url <- "https://scholar.google.com/citations?hl=en&user=HI-I6C0AAAAJ"
html <- GET(url)
class(html)
content <- content(html, as ="text")
class(content)
parsedhtml <- htmlParse(content, asText = TRUE)
class(parsedhtml)
xmlRoot(parsedhtml)
xmlName(xmlRoot(parsedhtml))
xpathSApply(parsedhtml,"//title", xmlValue)
article <- xpathSApply(parsedhtml,"//td//a[@class='gsc_a_at']", xmlValue)
cite <- xpathSApply(parsedhtml,"//td[@class='gsc_a_c']//a", xmlValue)

## Accessing websites with password
pg1 <- httr::GET("http://httpbin.org/basic-auth/user/passwd",
                 authenticate("user", "passwd"))
pg1
names(pg1)

## Use handle to save the authentication
google <- handle("http://google.com")
pg2 <- GET(handle = google,path ="/")
pg3 <- GET(handle = google, path = "search")

