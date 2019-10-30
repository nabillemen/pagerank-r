library("igraph")
# Swap out path to your Screaming Frog All Outlink CSV. For Windows, remember to change backslashes to forward slashes.
links <- read.csv("C:/Users/nabil/projects/bridge/ambient-it_2710/all_inlinks.csv")#, skip = 1) # CSV Path
View(links)
# This line of code is optional. It filters out JavaScript, CSS, and Images. Technically you should keep them in there.
links <- subset(links, Type=="AHREF") # Optional line. Filter.
links <- subset(links, Follow=="true")
links <- subset(links, Status.Code!=0)
links <- subset(links, select=c(Source,Destination))
g <- graph.data.frame(links)
pr <- page.rank(g, algo = "prpack", vids = V(g), directed = TRUE, damping = 0.85)
values <- data.frame(pr$vector)
values$names <- rownames(values)
row.names(values) <- NULL
values <- values[c(2,1)]
names(values)[1] <- "url"
names(values)[2] <- "pr"
View(values)
# Swap out 'domain' and 'com' to represent your website address.
values <- values[grepl("https?:\\/\\/www\\.ambient\\-it\\.net.*", values$url),] # Domain filter.
View(values)
# Replace with your desired filename for the output file.
write.csv(values, file = "C:/Users/nabil/projects/bridge/ambient-it_2710/internal_pagerank.csv") # Output file.

rm(list=ls())
cat("\014")
