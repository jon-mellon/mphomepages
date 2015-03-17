setwd("D:/candidate")
source("C:/Users/Jon/Documents/mphomepages/src/scrape_functions.R")

candidates <- read.csv("https://yournextmp.com/media/candidates.csv",
				 stringsAsFactors = FALSE)

for(i in 1:nrow(candidates)) {
	candidate.row <- candidates[i, ]
	print(candidate.row$name)
	try(scrapeCandidateWebsite(candidate.row = candidate.row)	)
}