library(tidyverse)


#lifts <- tibble(
#	squat = c("heavy", "explosive", "rep"),
#	bench = c("explosive", "rep", "heavy"),
#	deadlift = c("rep", "heavy", "explosive")
#)


cube <- tibble(
	heavy = c("80% x 2 reps x 5 sets", "85% x 2 reps x 3 sets", "90% x 1 rep, 92.5% x 1 rep, 95% x 1 rep"),
	explosive = c("60% x 3 reps x 8 sets", "65% x 3 reps x 6 sets", "70% x 3 reps x 4 sets"),
	rep = c("70% x 8 reps x 1 set", "80% x 6 reps x 1 set", "85% x 4 reps x 1 set")
)


workout_string = Vectorize(function(day, wave) cube[[day]][wave])


tibble(
	wave = rep(1:3, each = 9),
	lift = rep(c("squat", "bench", "dedlift"), 9),
	day = rep(c(names(cube), names(cube)[c(2, 3, 1)], names(cube)[c(3, 1, 2)]), 3)
) %>% 
	mutate(workout = workout_string(day, wave)) %>% 
	print.data.frame()
