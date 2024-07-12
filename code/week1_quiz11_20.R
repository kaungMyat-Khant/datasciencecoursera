## Week 1 quiz ##

# Setup -------------------------------------------------------------------

getwd()
dir()
data <- read.csv("data/hw1_data.csv")

# What are the column names
colnames(data)
dimnames(data)

# Extract two first row
data[1:2,]
head(data,2)

# How many observations (row)
nrow(data)

# Extract last two rows
data[c(152,153),]
tail(data,2)

# value of Ozone in the 47th row
data[47,"Ozone"]

# missing values in Ozone column
missing <- is.na(data$Ozone)
nrow(data[missing,])
sum(is.na(data$Ozone))

# mean of the Ozone column
mean(data[!missing,"Ozone"])
mean(data$Ozone, na.rm = T)

# Extract Ozone values above 31 and Temp values above 90 and 
# calculate the mean of solar in this subset
extract <- data$Ozone > 31 & data$Temp > 90
subset <- data[extract,]
solar.rm <- is.na(subset$Solar.R)
subset[!solar.rm,"Solar.R"]
mean(subset[!solar.rm,"Solar.R"])
mean(data[data$Ozone > 31 & data$Temp > 90, "Solar.R"], na.rm = T)

# mean of Temp when Month  is 6
month <- data[,"Month"] ; month
mean(data[month==6,"Temp"])

# maximum ozone value in May
oz.may <- data[month==5, "Ozone"]
oz.may
oz.may <- oz.may[!is.na(oz.may)]
max(oz.may)
max(data[month==5, "Ozone"], na.rm = T)

rm(list = ls())
