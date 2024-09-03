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
    