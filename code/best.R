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