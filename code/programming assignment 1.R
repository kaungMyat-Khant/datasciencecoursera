rm(list = ls())
getwd()
setwd("C:/docs/dataScienceSpecialization/datasciencecoursera/data")
dir()
unzip("specdata.zip", exdir = ".")
files_names <- list.files("specdata", full.names = TRUE)
head(read.csv(files_names[31]))

dat <- data.frame()
for(i in seq_along(files_names)) {
  dat <- rbind(dat, read.csv(files_names[[i]]))
}
head(dat)
sulfate_1_10 <- dat[dat$ID  == as.integer(1:10), "sulfate"]
sulfate_data <- dat[which(dat[,"ID"] == as.integer(180:192)),"sulfate"]
mean(sulfate_1_10, na.rm = F)
mean(sulfate_1_10, na.rm = TRUE)

  # Creating pollutantmean function
  pollutantmean <- function(directory, pollutant, id = 1: 332){
    files <- list.files(directory, full.names = TRUE)
    data <- data.frame()
    for(i in id){
      data <- rbind(data, read.csv(files[i]))
    }
    mean(subset[,pollutant], na.rm = TRUE)
  }
  print(R.version.string)
pollutantmean(directory = "specdata", pollutant = "nitrate", id = 200)  
pollutantmean(directory = "specdata", pollutant = "sulfate", id = 200:300)  
pollutantmean(directory = "specdata", pollutant = "nitrate", id = 200:300)  

rm(list = ls())
getwd()
dir()
file_names <- list.files("specdata", full.names = TRUE)
file_names
data <- data.frame()
for(i in 5:7){
  data <- rbind(data, read.csv(file_names[i]))
}
head(data, n = 200)

complete.cases(data)
sum(complete.cases(data))

for(i in 30:25){
  data <- read.csv(file_names[i])
  nobs <- sum(complete.cases(data))
  data.frame(id = i, nobs = nobs)
}

data <- read.csv(file_names[30])
nobs <- sum(complete.cases(data))
data.frame(id = 30, nobs= nobs)

df <- data.frame()
for(i in 30:25){
  data <- read.csv(file_names[i])
  nobs <- sum(complete.cases(data))
  df <- rbind(df,data.frame(id = i, nobs = nobs))
}
df

# Create Complete function
complete <- function(directory, id = 1:332){
  file_names <- list.files(directory, full.names = TRUE)
  df <- data.frame()
  for(i in id){
    data <- read.csv(file_names[i])
    nobs <- sum(complete.cases(data))
    df <- rbind(df,data.frame(id = i, nobs = nobs))
  }
  df
}
getwd()
dir()
complete("specdata",1)
complete("specdata",c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)
# OK now


rm(list = ls())
getwd()
dir()
complete <- function(directory, id = 1:332){
  file_names <- list.files(directory, full.names = TRUE)
  df <- data.frame()
  for(i in id){
    data <- read.csv(file_names[i])
    nobs <- sum(complete.cases(data))
    df <- rbind(df,data.frame(id = i, nobs = nobs))
  }
  df
}
df <- complete("specdata")
threshold <- 150
selected <- df[which(df[,"nobs"] > threshold),"id"] 
selected
file_names <- list.files("specdata", full.names = TRUE)
corr <- numeric(0)
corr
for(i in selected){
  data <- read.csv(file_names[i])
  nitrate <- data[complete.cases(data), "nitrate"]
  sulfate <- data[complete.cases(data), "sulfate"]
  corr <- c(corr,cor(nitrate, sulfate))
}
corr

# Create the corr function
corr <- function(directory, threshold = 0){
  df <- complete(directory)
  threshold <- threshold
  selected <- df[which(df[,"nobs"] > threshold), "id"]
  file_names <- list.files(directory, full.names = TRUE)
  corr <- numeric(0)
  for(i in selected){
    data <- read.csv(file_names[i])
    nitrate <- data[complete.cases(data), "nitrate"]
    sulfate <- data[complete.cases(data), "sulfate"]
    corr <- c(corr,cor(nitrate, sulfate))
  }
  corr
}
# Test it
cr <- corr("specdata",threshold = 150)
head(cr)
summary(cr)

cr <- corr("specdata",threshold = 400)
head(cr)
summary(cr)

cr <- corr("specdata",threshold = 5000)
summary(cr)
length(cr)

cr <- corr("specdata")
summary(cr)
length(cr)

# It's okay now