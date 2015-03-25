scrapeCandidateWebsite <- function(candidate.row, homepage = TRUE) {
	require(RCurl)
	require(XML)
	folder <- paste(candidate.row$name, candidate.row$id, sep = "_")
	folder <- gsub("[^[:alnum:]]", "_", folder)
	
	if(homepage) {
		url <- candidate.row$homepage_url
	} else {
		url <- candidate.row$party_ppc_page_url
	}
	if(url=="") {
		return(NULL)
	}
	dir.create(folder)
	scrapeDepthOne <- function(url) {
		cleanURL <- function(x) {
			x <- gsub("http[s]*:*/*w*\\.*", "", x)
			return(x)
		}
		doc <- htmlParse(url)
		links <- xpathSApply(doc, "//a/@href")
		links[grepl("^/", links)] <- paste0(url, gsub("^/", "", links[grepl("^/", links)]))
		links <- unique(c(url, links[grepl(cleanURL(url), cleanURL(links))]))
		links <- unique(gsub("www\\.", "", links))
		links <- as.character(links)
		return(links)
	}
	links <- scrapeDepthOne(url = url)
	
	downloadPage <- function(url, folder) {
		if(!grepl("\\.[[:alpha:]]+$", url)) {
			download.file(url, 
										destfile = paste0(folder, "/",
																			gsub("[/:\\.]", "_", url), ".html"))
		} else {
			file.type <- strsplit(url, "\\.")[[1]] 
			file.type <- file.type[length(file.type)]
			download.file(URLencode(url), 
										destfile = paste0(folder, "/",
																			gsub("[/:\\.]", "_", url), ".", file.type))	
		}
	}
	lapply(links, downloadPage, folder = folder)
	
	return(length(links))
}