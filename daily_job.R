# saveRDS(0, file = "counter.rds")

if(weekdays(Sys.Date()) %in% c("måndag", "onsdag", "fredag")) {
	counter <- readRDS("counter.rds") + 1

	cube <- readRDS("cube.rds")

	library(gmailr)

	mime() %>% 
		to("cervus1983@gmail.com") %>% 
		from("cervus1983@gmail.com") %>% 
		subject("Workout") %>% 
		text_body(paste(unlist(cube[counter, ]), collapse = " | ")) %>% 
		send_message()

	saveRDS(counter, file = "counter.rds")
}
