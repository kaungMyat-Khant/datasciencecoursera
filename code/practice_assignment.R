rm(list = ls())
getwd()
setwd("C:/docs/dataScienceSpecialization/datasciencecoursera/data")
dir()
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")


# Check the downloaded files
getwd()
list.files("diet_data")
andy <- read.csv("diet_data/Andy.csv")
head(andy)

dim(andy)
str(andy)
names(andy)

# Andy's starting weight
andy[1,"Weight"]
# Andy's end weight
andy[30, "Weight"]
# Alternative 
andy[which(andy$Day == 30), "Weight"]
andy[andy[,"Day"]==30, "Weight"]

# Subset
subset(andy$Weight, andy$Day==30)

andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]
andy_loss <- andy_start - andy_end

list.files("diet_data")
files <- list.files("diet_data")
files
files[1]
files[2]
files[3:5]

#head(read.csv(files[3]))

files_full <- list.files("diet_data", full.names = T)
files_full
head(read.csv(files_full[3]))
andy_david <- rbind(andy, read.csv(files_full[2]))
head(andy_david)
tail(andy_david)

day_25 <- andy_david[which(andy_david$Day == 25),]
day_25

# Looping
for(i in 1:5){print(i)}

for(i in 1:5){
  dat <- rbind(dat,read.csv(files_full[i]))
}

dat <- data.frame()
for(i in 1:5){
  dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)

for(i in 1:5){
  dat2 <- data.frame()
  dat2 <- rbind(dat2, read.csv(files_full[i]))
}

median(dat$Weight)
median(dat$Weight, na.rm = TRUE)

dat_30 <- dat[which(dat$Day == 30),]
dat_30
median(dat_30$Weight)

# creating function 
weightmedian <- function(directory, day) {
  files_list <- list.files(directory, full.names = TRUE)
  dat <- data.frame()
  for(i in 1:5) {
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  dat_subset <- dat[which(dat[,"Day"] == day),]
  median(dat_subset[, "Weight"], na.rm = TRUE)
}

weightmedian("diet_data",4)
weightmedian(directory = "diet_data",day = 25)

summary(files_full)
tmp <- vector(mode = "list", length = length(files_full))
str(tmp)

for(i in seq_along(files_full)) {
  tmp[[i]] <- read.csv(files_full[[i]])
}
str(tmp)
str(lapply(files_full, read.csv))

str(tmp[[1]])
head(tmp[[1]][,"Day"])

output <- do.call(rbind, tmp)
str(output)
