rm(list= ls())
getwd()
setwd("C:/docs/dataScienceSpecialization/datasciencecoursera/data")
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = fileurl,
              destfile = "housing.csv",
              method = "curl")
dateDownloaded <- date()
dateDownloaded

data <- read.csv("housing.csv")
dim(data)
head(data, n = 3)
View(data)
head(data$VAL)
head(data$TAXP)

library(dplyr)
count(filter(select(data, VAL), VAL == 24))
distinct(data, FES)
head(data$FES)


fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = fileurl,
              destfile = "gas_aquisition.xlsx",
              mode = "wb")

dat <- readxl::read_xlsx("gas_aquisition.xlsx", col_names = F)
dat <- dat %>% select(7:15) %>% 
  slice(18:23)
col_name <- as.character(dat[1,])
col_name
dat <- dat[-1,]
colnames(dat) <- col_name
str(dat)
dat <- lapply(dat, as.numeric)
sum(dat$Zip*dat$Ext, na.rm = T)

install.packages("XML")
library(XML)
rm(list = ls())
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternalNodes = T)
class(doc)
rootNode <- xmlRoot(doc)
class(rootNode)
xmlName(rootNode)
rootNode[[1]]
xmlSApply(rootNode, xmlValue)
zipcodes <- xpathSApply(rootNode, "//zipcode",xmlValue)
zipcodes
length(zipcodes[zipcodes == "21231"])

rm(list = ls())
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,"Fdata.csv", method = "curl")
library(data.table)
DT <- fread(file = "Fdata.csv")
DT$pwgtp15

sapply(split(DT$pwgtp15, DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15, DT$SEX),mean))

rowMeans(DT)[DT$SEX == 1] ; rowMeans(DT)[DT$SEX == 2]
mean(DT$pwgtp15, by = DT$SEX)

tapply(DT$pwgtp15, DT$SEX, mean)
system.time(tapply(DT$pwgtp15, DT$SEX, mean))

DT[, mean(pwgtp15), by = SEX]
system.time(DT[, mean(pwgtp15), by = SEX])
