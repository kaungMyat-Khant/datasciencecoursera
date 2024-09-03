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