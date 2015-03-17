setwd("D:/candidate")

candidates <- read.csv("_source/candidates.csv",
				 stringsAsFactors = FALSE)

for(i in 1:nrow(candidates)) {
	candidate.row <- candidates[i, ]
	print(candidate.row$name)
	try(scrapeCandidateWebsite(candidate.row = candidate.row)	)
}




candidate.row <- candidates[44, ]
candidate.row <- candidates[candidates$id==2607, ]



getwd()
