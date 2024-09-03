## These functions cache the inverse of a matrix 
## when they are used as a pair


## makeCacheMatrix creates a special "matrix" object 
## that can cache its inverse
## Note that the matrix must be square matrix
## which means nrow and ncol of argument of the matrix
## must be the same
## For example
## matrix(c(1,2,3,4),nrow = 2, ncol = 2)

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inv_matrix) inv <<- inv_matrix
  getinverse <- function() inv
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}



## cacheSolve computes the inverse of the special "matrix"
## returned by makeCacheMatrix above

cacheSolve <- function(x, ...) {
  inv <- x$getinverse()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinverse(inv)
  inv
}