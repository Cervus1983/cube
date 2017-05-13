library(stringr)
library(tidyverse)


cube <- tibble(
	heavy = c("80% x 2 reps x 5 sets", "85% x 2 reps x 3 sets", "90% x 1 rep, 92.5% x 1 rep, 95% x 1 rep"),
	explosive = c("60% x 3 reps x 8 sets", "65% x 3 reps x 6 sets", "70% x 3 reps x 4 sets"),
	rep = c("70% x 8 reps x 1 set", "80% x 6 reps x 1 set", "85% x 4 reps x 1 set")
)


# remove "rep(s)"
cube <- as.tibble(
	apply(cube, 2, function(x) x %>% str_replace_all(c(" reps " = " ", "x 1 rep" = "-")))
)


# remove "set(s)"
cube <- as.tibble(
	apply(cube, 2, function(x) str_replace_all(
		x, "x \\d set(?:s)?", function(x) strrep("-", as.integer(substr(x, 3, 3)))
	))
)


one_rep_max <- c(
	squat = 130,
	bench = 95,
	deadlift = 140
)


step <- 2.5


workout_string = Vectorize(
	function(wave, lift, day) str_replace_all(
		cube[[day]][wave],
		"[1-9]\\d*(?:\\.\\d+)?%",
		function(x) round(as.numeric(sub("%", "", x)) * one_rep_max[lift] / 100 / step) * step
	)
)


tibble(
	wave = rep(1:3, each = 9),
	lift = rep(c("squat", "bench", "deadlift"), 9),
	day = rep(c(names(cube), names(cube)[c(2, 3, 1)], names(cube)[c(3, 1, 2)]), 3)
) %>% 
	mutate(workout = workout_string(wave, lift, day)) %>% 
	print.data.frame()
