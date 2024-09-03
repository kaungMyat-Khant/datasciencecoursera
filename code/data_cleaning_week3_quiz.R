rm(list = ls())
getwd()
setwd(paste(getwd(), "data", sep = "/"))
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "housing_idaho.csv", method = "libcurl")
data <- read.csv("housing_idaho.csv")
head(data, 3)
agricultureLogical <- (data$ACR == 3 & data$AGS == 6)
which(agricultureLogical)

install.packages("jpeg")
jpeg <- jpeg::readJPEG("getdata_jeff.jpg", native = TRUE)
jpeg
quantile(jpeg, probs = 0.3)
quantile(jpeg, probs = 0.8)

gdpUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
eduUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(gdpUrl, destfile = "gdp.csv", method = "libcurl")
download.file(eduUrl, destfile = "edu.csv", method = "libcurl")

gdp <- read.csv("gdp.csv")
edu <- read.csv("edu.csv")
gdp <- gdp[-(1:4),]
head(gdp)
head(edu)
library(dplyr)
intersect(edu$CountryCode, gdp$X)
edu$CountryCode %in% gdp$X
sum(edu$CountryCode %in% gdp$X)

match(edu$CountryCode, gdp$X)



data <- gdp %>% inner_join(edu, by = join_by(X == CountryCode))
sort_data <- data %>% 
  mutate(Gross.domestic.product.2012 = as.integer(Gross.domestic.product.2012)) %>% 
  filter(!is.na(Gross.domestic.product.2012)) %>% 
  arrange(desc(Gross.domestic.product.2012))


data1 <- merge(gdp, edu, by.x = "X", by.y = "CountryCode")
str(data1)
data1$Gross.domestic.product.2012 <- as.integer(data1$Gross.domestic.product.2012)
order_data1 <- data1[order(data1$Gross.domestic.product.2012, decreasing = T, na.last = NA),]
rownames(order_data1) <- 1:nrow(order_data1)
View(order_data1)

data %>% 
  mutate(Gross.domestic.product.2012 = as.numeric(Gross.domestic.product.2012)) %>% 
  group_by(Income.Group) %>% 
  summarize(average = mean(Gross.domestic.product.2012, na.rm = T))

oecd <- order_data1[order_data1$Income.Group == "High income: OECD", "Gross.domestic.product.2012"]
mean(oecd)
non_oecd <- order_data1[order_data1$Income.Group == "High income: nonOECD", "Gross.domestic.product.2012"]
mean(non_oecd)

cp <- quantile(order_data1$Gross.domestic.product.2012, probs = seq(0,1, by=0.2))
order_data1$cut_gdp <- cut(order_data1$Gross.domestic.product.2012,
                           cp)
str(order_data1)
table(order_data1$Income.Group, order_data1$cut_gdp)
xtabs(~ Income.Group + cut_gdp, data = order_data1)
