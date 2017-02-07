## Assign ISO codes to DF
assign_iso <- function(df) {
	
	# Load ISO DF
	ISO <- read.csv("https://github.com/JeremyBowyer/Assign_ISO/raw/master/ISO%20Country%20Codes.csv")
	ISO[, grep("Name",names(ISO))] <- apply(ISO[, grep("Name",names(ISO))], 2, tolower)
	
	# create temporary data frame
	tempdf <- df
	columnorder <- c("Country", names(tempdf[-grep("Country", names(tempdf))]))
	tempdf <- tempdf[, columnorder]
	tempdf$Country <- tolower(tempdf$Country)
	tempdf$Country <- trimws(tempdf$Country)
	
	# merge tempdf with iso on multiple possible names
	suppressWarnings(tempdf_iso <- merge(tempdf, ISO[,c("Name.1", "Code")], by.x = "Country", by.y = "Name.1", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.2", "Code")], by.x = "Country", by.y = "Name.2", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.3", "Code")], by.x = "Country", by.y = "Name.3", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.4", "Code")], by.x = "Country", by.y = "Name.4", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.5", "Code")], by.x = "Country", by.y = "Name.5", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.6", "Code")], by.x = "Country", by.y = "Name.6", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.7", "Code")], by.x = "Country", by.y = "Name.7", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.8", "Code")], by.x = "Country", by.y = "Name.8", all.x = TRUE))
	suppressWarnings(tempdf_iso <- merge(tempdf_iso, ISO[,c("Name.9", "Code")], by.x = "Country", by.y = "Name.9", all.x = TRUE))
	
	# rename columns
	isonames <- c("Name1", "Name2", "Name3", "Name4", "Name5", "Name6", "Name7", "Name8", "Name9")
	names(tempdf_iso) <- c(names(tempdf),isonames)
	
	# find first non-NA code
	tempdf_iso$ISO <- t(na.locf(t(tempdf_iso[,isonames]), na.rm = FALSE, fromLast = TRUE))[,1]
	
	# remove unnecessary iso code columns
	tempdf_iso <- tempdf_iso[,c(names(tempdf), "ISO")]
	
	# send final df
	tempdf_iso
}
