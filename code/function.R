  rm(list = ls())
  add2 <- function(x, y){
    x + y
  }
  add2(3, 5)
  
  above10 <- function(x) {
    use <- x > 10
    x[use]
  }
  above10(5)
  above10(15)
  
  above <- function(x, n) {
    use <- x > n
    x[use]
  }
  x <- 1:20
  above(x, 12)
  
  getwd()
  dir()
  head(read.csv("hw1_data.csv"))
  
  columnmean <- function(y, removeNA = TRUE) {
    nc <- ncol(y)
    means <- numeric(nc)
    for(i in 1:nc) {
      means[i] <- mean(y[,i], na.rm = removeNA)
    }
    means
  }
  columnmean(read.csv("hw1_data.csv"))
  
  make.NegLogLik <- function(data, fixed = c(FALSE,FALSE)) {
    params <- fixed
    function(p) {
      params[!fixed] <- p
      mu <- params[1]
      sigma <- params[2]
      a <- -0.5*length(data)*log(2*pi*sigma^2)
      b <- -0.5*sum((data-mu)^2)/(sigma^2)
      -(a + b)
    }
  }
  make.NegLogLik(read.csv("hw1_data.csv"),c(1,1))
  
