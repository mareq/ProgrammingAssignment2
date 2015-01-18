## Cached vector, that is able to cache its mean,
## in order to avoid recomputing it, which, might
## be costly operation in some scenarios (large
## vectors, frequent recomputation)


## Construct and return "special" vector object, which provides
## cache for its mean value.
## Parameters:
## * x: Vector initial value.
## Note: Code of this function is direct copy-paste from README.md
##   file, without any changes.
makeVector <- function(x = numeric()) {
	m <- NULL
	set <- function(y) {
		x <<- y
		m <<- NULL
	}
	get <- function() x
	setmean <- function(mean) m <<- mean
	getmean <- function() m
	list(
		set = set,
		get = get,
		setmean = setmean,
		getmean = getmean
	)
}


## Get mean value from "special" vector object created by 'makeVector'
## function above. If possible, the mean vaule is either retrieved
## from cache, or recomputed, cached and returned otherwise.
## Parameters:
## * x: "Special" vector object (see 'makeVector' function).
## * ...: Optional arguments to be used for recomputing mean
##     value (see all but the first argument of 'mean' function).
##     These arguments will be taken into account only in case
##     mean value is not cached and must be recomputed.
## Note: Code of this function is direct copy-paste from README.md
##   file, without any changes.
cachemean <- function(x, ...) {
	m <- x$getmean()
	if(!is.null(m)) {
		message("getting cached data")
		return(m)
	}
	data <- x$get()
	m <- mean(data, ...)
	x$setmean(m)
	m
}


## Usage example (uncomment the code below to run this basic test).

## create cached vector
#v <- makeVector(1:100)
## print vector contents
#v$get()
## get vector mean (will return NULL, because mean has not been set, yet)
#v$getmean()
## set vector mean to correct value
#v$setmean(mean(v$get()))
## get vector mean (will return correct value, set above)
#v$getmean()
## set vector mean to incorrect value
#v$setmean(2)
## get vector mean (will return incorrect value, set above)
#v$getmean()
## use specialized function to get mean (will return incorrect value, set above)
#cachemean(v)
## assign new value to vector (resets cached value)
#v$set(42:64)
## get vector mean (will return NULL, because mean should have been reset)
#v$getmean()
## use specialized function to compute, cache and return mean value
#cachemean(v)
## get vector mean (will return correct value, set by cachemean)
#v$getmean()


# vim: set ts=2 sw=2 noet:


