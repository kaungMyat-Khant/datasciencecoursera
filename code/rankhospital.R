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
      