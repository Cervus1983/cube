counter <- readRDS("counter.rds") + 1

source("cube.R")
message <- sprintf("%s %s %s, %s", cube[counter, 2], cube[counter, 1], cube[counter, 3], cube[counter, 4])

topic <- readRDS("topic.rds")

aws.sns::publish(topic = topic, message = message)

saveRDS(counter, "counter.rds")
