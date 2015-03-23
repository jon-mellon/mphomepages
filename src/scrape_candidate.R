setwd("D:/candidate")
dir.create()

current.date <- substr(date(),5, 10)
current.date <- gsub(" ", "_", current.date)
dir.create(current.date)
setwd(current.date)

if(Sys.info()["sysname"]=="Linux") {
	download.file("https://yournextmp.com/media/candidates.csv", 
								destfile = "candidates.csv",
								method="curl")
	candidates <- read.csv("candidates.csv",
												 stringsAsFactors = FALSE)	
} else {
	source("C:/Users/Jon/Documents/mphomepages/src/scrape_functions.R")	
	candidates <- read.csv("https://yournextmp.com/media/candidates.csv",
												 stringsAsFactors = FALSE)
	
}

for(i in 1:nrow(candidates)) {
	candidate.row <- candidates[i, ]
	print(candidate.row$name)
	try(scrapeCandidateWebsite(candidate.row = candidate.row)	)
}