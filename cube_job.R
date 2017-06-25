counter <- readRDS("counter.rds") + 1

source("cube.R")
source("../nexmo.R")

send_text(
	from = "Cube",
	text = sprintf("%s %s %s, %s", cube[counter, 2], cube[counter, 1], cube[counter, 3], cube[counter, 4])
)

saveRDS(counter, "counter.rds")
