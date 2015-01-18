## Following set of functions provides means to construct "special"
## matrix object, allowing to cache its inverse matrix value using
## its lexical scope. This enables user to avoid potentially costly
## recomputation of inverse matrix.


## Construct and return "special" matrix object, which provides
## cache for its inverse matrix value.
## Parameters:
## * m: Matrix initial value.
makeCacheMatrix <- function(m = matrix()) {
	# cached inverse matrix value
	inverse <- NULL

	# function: set matrix value (has to reset cached inverse matrix)
	set <- function(x) {
		m <<- x
		inverse <<- NULL
	}

	# function: get matrix value
	get <- function() {
		m
	}

	# function: set cached inverse matrix value
	setInverse <- function(x) {
		inverse <<- x
	}

	# function: get cached inverse matrix value
	getInverse <- function() {
		inverse
	}

	# construct and return matrix object
	list(
		set = set,
		get = get,
		setInverse = setInverse,
		getInverse = getInverse
	)
}


## Get inverse matrix value from "special" matrix object created
## by 'makeCacheMatrix' function above. If possible, the inverse
## matrix vaule is either retrieved from cache, or recomputed,
## cached and returned otherwise.
## Parameters:
## * x: "Special" matrix object (see 'makeCacheMatrix' function).
## * ...: Optional arguments to be used for recomputing inverse
##     matrix value (see all but the first argument of 'solve'
##     function). These arguments will be taken into account
##     only in case inverse matrix value is not cached and must
##     be recomputed.
cacheSolve <- function(x, ...) {
	# get cached inverse matrix
	inverse <- x$getInverse()

	# check cached inverse matrix and return it, if valid
	if(!is.null(inverse)) {
		message("getting cached data")
		return(inverse)
	}

	# compute inverse matrix, chache and return it, otherwise
	data <- x$get()
	inverse <- solve(data, ...)
	x$setInverse(inverse)
	inverse
}


## Usage example (uncomment the code below to run this basic test).

## create cached matrix
#m <- makeCacheMatrix(matrix(1:4, 2, 2))
## print matrix
#m$get()
## get matrix inverse (will return NULL, because inverse has not been set, yet)
#m$getInverse()
## set matrix inverse to correct value
#m$setInverse(solve(m$get()))
## get matrix inverse (will return correct value, set above)
#m$getInverse()
## set matrix inverse to incorrect value
#m$setInverse(matrix(4:1, 2, 2))
## get matrix inverse (will return incorrect value, set above)
#m$getInverse()
## use specialized function to get matrix inverse (will return incorrect vaue, set above)
#cacheSolve(m)
## assign new value to matrix (resets cached value)
#m$set(matrix(2:5, 2, 2))
## get matrix inverse (will return NULL, because inverse should have been reset)
#m$getInverse()
## use specialized function to compute, cache and return inverse value
#cacheSolve(m)
## get matrix inverse (will return correct value, set by cacheinverse)
#m$getInverse()


# vim: set ts=2 sw=2 noet:


