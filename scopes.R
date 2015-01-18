# modifying parent scope variable
new_counter <- function() {
	i <- 0  # this is the variable being modified
	function() {
		i <<- i + 1  # modifies parent scope variable
		i  # prints parent scope variable
	}
}
counter_one <- new_counter()
counter_two <- new_counter()
counter_one()  # [1] 1
counter_one()  # [1] 2
counter_two()  # [1] 1

# parent scope variable overshadowed by the current scope variable
new_counter <- function() {
	i <- 0  # this variable will be overshadowed
	function() {
		i <- 42  # overshadows the parent scope variable
		i <<- i + 1  # modifies current scope variable
		i  # prints current scope variable
	}
}
counter_one <- new_counter()
counter_two <- new_counter()
counter_one()  # [1] 43
counter_one()  # [1] 43
counter_two()  # [1] 43

# modified example from 02.10 Scoping Rules: R Scoping Rules
y <- 10
f <- function(x) {
	y <- 2  # overshadows the global scope variable
	y^2 + g(x)  # uses current scope variable (value 2)
}
g <- function(x) {
	y <<- y + 42  # modifies gloval scope variable (42 added to y, which is 10 at the beginning)
	x * y # uses global scope variable (value 42), because g is defined in global environment
}
f(3) # 2^2 + 3*52 = 160
y # 42 (changed by call to g)
f(3) # 2^2 + 3*94 = 286
y # 94 (changed by call to g)


# vim: set ts=2 sw=2 noet:


