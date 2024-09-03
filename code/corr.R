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