library(stringr)
library(tidyverse)


# main lifts ----
one_rep_max <- c(
	squat = 130,
	bench = 95,
	deadlift = 140
)

step <- 2.5


# method ----
cube <- tibble(
	heavy = c("80% x 2 x 5", "85% x 2 x 3", "90%, 92.5%, 95%"),
	explosive = c("60% x 3 x 8", "65% x 3 x 6", "70% x 3 x 4"),
	rep = c("70% x 8", "80% x 6", "85% x 4")
)


# assistance exercises ----
assistance <- c(
	squat = c(
		every_week = "OHP",
		heavy = "back raise",
		explosive = "box jump",
		rep = "barbell lunge"
	),
	bench = c(
		every_week = "barbell row",
		heavy = "bicep curl",
		explosive = "plyo push-up",
		rep = "dip"
	),
	deadlift = c(
		every_week = "crunch",
		heavy = "farmer's walk",
		explosive = "good morning",
		rep = "shrug"
	)
)


# function to convert % to weight ----
workout_string = Vectorize(
	function(wave, lift, day) str_replace_all(
		cube[[day]][wave],
		"[1-9]\\d*(?:\\.\\d+)?%",
		function(x) round(as.numeric(sub("%", "", x)) * one_rep_max[lift] / 100 / step) * step
	)
)


# output ----
cube <-	tibble(
	wave = rep(1:3, each = 9),
	lift = rep(names(one_rep_max), 9),
	day = rep(c(names(cube), names(cube)[c(2, 3, 1)], names(cube)[c(3, 1, 2)]), 3)
) %>% 
	mutate(
		workout = workout_string(wave, lift, day),
		assistance = paste(
			assistance[paste(lift, "every_week", sep = ".")],
			assistance[paste(lift, day, sep = ".")],
			sep = ", "
		)
	) %>% 
	select(-wave)
