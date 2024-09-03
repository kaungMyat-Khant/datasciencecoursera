
# best --------------------------------------------------------------------

      
rm(list = ls())
      getwd()
      setwd("C:/docs/dataScienceSpecialization/datasciencecoursera/data")
      dir()
      outcome <- read.csv("outcome-of-care-measures.csv", 
                          colClasses = "character")
      str(outcome)
      head(outcome)
      ncol(outcome)
      names(outcome)
      head(outcome[,11])      
      as.numeric(head(outcome[, 11])) 
      outcome[, 11] <- as.numeric(outcome[, 11])
      hist(outcome[, 11])
      # col no. 11, 17 and 23 are mortality rates for 
      # heart attack, heart failure and pneumonia
      # col no. 2 and 7 are hospital name and state
      
      outcome <- read.csv("outcome-of-care-measures.csv", 
                          colClasses = "character")
      dat <- outcome[, c(2,7,11,17,23)]
      names(dat) <- c("hospital", "state","heart attack", "heart failure", 
                      "pneumonia")
      dat[,c(3,4,5)] <- lapply(dat[, c(3, 4, 5)], as.numeric)
      str(dat)
      valid_state <- unique(dat$state)
      valid_outcome <- c("heart attack", "heart failure", "pneumonia")
      if(!("OBD" %in% valid_state)) {
        stop("invalid state")
      }
      if(!("heat attack" %in% valid_outcome)) {
        stop("invalid outcome")
      }
      
      best <- min(dat[which(dat$state == "TX"), "heart attack"], na.rm = T)
      name <- dat[which(dat[, "state"] == "TX" & dat[, "heart attack"] == best),
                  "hospital"]
      name
      
      
      
      # Write the function "best" 
      rm(list = ls())
      best <- function(state, outcome) {
        ## Read the outcome data
        if(file.exists("outcome-of-care-measures.csv")) {
          data <- read.csv(paste0(getwd(),"/","outcome-of-care-measures.csv"))
        } else{
          stop("No file found")
        }
        data <- data[, c(2,7,11,17,23)]
        names(data) <- c("hospital", "state","heart attack", "heart failure", 
                         "pneumonia")
        data[,3:5] <- lapply(data[, 3:5], as.numeric)
        state_selected <- state
        outcome_selected <- tolower(outcome)
        
        ## Check that state and outcomes are valid
        valid_state <- unique(data$state)
        valid_outcome <- c("heart attack", "heart failure", "pneumonia")
        if(!(state_selected %in% valid_state)) {
          stop("invalid state")
        }
        if(!(outcome_selected %in% valid_outcome)) {
          stop("invalid outcome")
        }
        ## Return hospital name in the selected state with lowest 30-day 
        ## death rate
        best <- min(
          data[which(data$state == state_selected), outcome_selected],
          na.rm = TRUE
        )
        hospital_name <- data[
          which(data[, "state"] == state_selected & 
                  data[,outcome_selected] ==  best),"hospital"]
        hospital_name[1]
      }
      ## Test the function
      best("TX", "heart attack")
      best("TX", "heart failure")
      best("MD", "heart attack")
      best("MD", "pneumonia")
      best("BB", "heart attack")
      best("NY", "hert attack")
      ## It is okay now
      

# rankhospital ------------------------------------------------------------

      
      rm(list= ls())
      outcome <- read.csv("outcome-of-care-measures.csv", 
                          colClasses = "character")
      dat <- outcome[, c(2,7,11,17,23)]
      names(dat) <- c("hospital", "state","heart attack", "heart failure", 
                      "pneumonia")
      dat[,c(3,4,5)] <- lapply(dat[, c(3, 4, 5)], as.numeric)
      str(dat)
      dat_rank <- dat[which(dat[, "state"] == "MD"),
                      c("hospital", "heart attack")]
      rank_data <- dat_rank[order(dat_rank$`heart attack`,dat_rank$hospital, na.last = NA),]
      tail(rank_data)
      rank_data[nrow(rank_data),]
      rank_data[nrow(rank_data),]
      head(rank_data)
      rank_data[1,]
      
      dat_rank <- dat[which(dat[, "state"] == "TX"),
                      c("hospital", "heart failure")]
      rank_data <- dat_rank[order(dat_rank$`heart failure`, dat_rank$hospital, na.last = NA),]
      head(rank_data)
      rank_data[4,]
      
      dat_rank <- dat[which(dat[, "state"] == "MN"),
                      c("hospital", "heart attack")]
      rank_data <- dat_rank[order(dat_rank$`heart attack`,dat_rank$hospital, na.last = NA),]
      rank_data[5000,]
      
      # Write the function "rankhospital" 
      rm(list = ls())
      rankhospital <- function(state, outcome, num = "best") {
        ## Read the outcome data
        if(file.exists("outcome-of-care-measures.csv")) {
          data <- read.csv(paste0(getwd(),"/","outcome-of-care-measures.csv"))
        } else{
          stop("No file found")
        }
        data <- data[, c(2,7,11,17,23)]
        names(data) <- c("hospital", "state","heart attack", "heart failure", 
                         "pneumonia")
        data[,3:5] <- lapply(data[, 3:5], as.numeric)
        state_selected <- state
        outcome_selected <- tolower(outcome)
        
        ## Check that state and outcomes are valid
        valid_state <- unique(data$state)
        valid_outcome <- c("heart attack", "heart failure", "pneumonia")
        if(!(state_selected %in% valid_state)) {
          stop("invalid state")
        }
        if(!(outcome_selected %in% valid_outcome)) {
          stop("invalid outcome")
        }
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        data <- data[which(data[, "state"] == state_selected),
                     c(outcome_selected, "hospital")]
        ranked <- data[order(data[, outcome_selected], data[,"hospital"], 
                             na.last = NA),]
        if(num == "best") {
          return(ranked[1, "hospital"])
        } else if(num == "worst") {
          return(ranked[nrow(ranked), "hospital"])
        } else {
          ranked[num, "hospital"]
        }
        
      }
        
      ## Test the function
      rankhospital("TX", "heart failure", 4)
      rankhospital("MD", "heart attack", num = "worst")
      rankhospital("MN", "heart attack", 5000)
      
      rm(list = ls())
      getwd()
      setwd("C:/docs/dataScienceSpecialization/datasciencecoursera/data")
      dir()
      
      ## Read data
      data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
      names(data)
      data <- data[, c(2, 7, 11, 17, 23)]
      head(data, 3)
      names(data) <- c("hospital", "state", 
                       "heart attack", "heart failure",
                       "pneumonia")
      str(data)
      data[,3:5] <- lapply(data[, 3:5], as.numeric)
      str(data)
      
      
      ## test validity of outcome
      outcome_selected <- "heart attack"
      outcome_valid <- names(data)[3:5]
      
      if(!(tolower(outcome_selected) %in% outcome_valid)) {
        stop("invalid outcome")
      }
      
      ## Ranked data frame
      state_unique <- unique(data[,"state"])
      state_unique
      num <- 20
      rank_state_df <- data.frame()
      rank <- function(data) {
        ranked <- data[order(data[,outcome_selected],
                   data[,"hospital"],
                   na.last = NA), "hospital"]
        ranked
      }
      rank_by_state <- lapply(split(data, factor(data[,"state"])),rank)
      for(i in state_unique) {
        add_row <- data.frame(
          hospital = rank_by_state[[i]][num], 
          state = i,
          row.names = i)
        rank_state_df <- rbind(rank_state_df, add_row)
        rank_state_df <- rank_state_df[order(rank_state_df[,2]),]
      }
      rank_state_df
      
      ## Write "rankall" function
      rm(list = ls())
      rankall <- function(outcome, num = "best") {
        ## Read data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        data <- data[, c(2, 7, 11, 17, 23)]
        head(data, 3)
        names(data) <- c("hospital", "state", 
                         "heart attack", "heart failure",
                         "pneumonia")
        data[,3:5] <- lapply(data[, 3:5], as.numeric)
        
        ## test validity of outcome
        outcome_selected <- outcome
        outcome_valid <- names(data)[3:5]
        
        if(!(tolower(outcome_selected) %in% outcome_valid)) {
          stop("invalid outcome")
        }
        
        ## Ranked data frame
        
        ## setup
        state_unique <- unique(data[,"state"])
        num <- num
        rank_state_df <- data.frame()
        
        ## create function to rank the hospital by outcome
        rank <- function(data) {
          ranked <- data[order(data[,outcome_selected],
                               data[,"hospital"],
                               na.last = NA), "hospital"]
          ranked
        }
        rank_by_state <- lapply(split(data, factor(data[,"state"])),rank)
        
        if(num == "best") {
          for(i in state_unique) {
            add_row <- data.frame(
              hospital = rank_by_state[[i]][1], 
              state = i,
              row.names = i)
            rank_state_df <- rbind(rank_state_df, add_row)
            rank_state_df <- rank_state_df[order(rank_state_df[,2]),]
          }
          rank_state_df
        } else if(num == "worst") {
          for(i in state_unique) {
            add_row <- data.frame(
              hospital = rank_by_state[[i]][length(rank_by_state[[i]])], 
              state = i,
              row.names = i)
            rank_state_df <- rbind(rank_state_df, add_row)
            rank_state_df <- rank_state_df[order(rank_state_df[,2]),]
          }
          rank_state_df
        } else {
          if(!(is.na(as.numeric(num)))) {
            for(i in state_unique) {
              add_row <- data.frame(
                hospital = rank_by_state[[i]][as.numeric(num)], 
                state = i,
                row.names = i)
              rank_state_df <- rbind(rank_state_df, add_row)
              rank_state_df <- rank_state_df[order(rank_state_df[,2]),]
            }
            rank_state_df
          } else{
            stop("num argument can only be best , worst or an integer")
          }
        }
      }
      ## Test function
      args(rankall)      
      head(rankall("heart attack", 20),10)
      tail(rankall("pneumonia", "worst"), 3)
      tail(rankall("heart failure"), 10)
      

