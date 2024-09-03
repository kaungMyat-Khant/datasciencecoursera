
# Time of data sharing repo created ---------------------------------------

rm(list = ls())
library(httr)

oauth_endpoints("github")

myapp <- oauth_app("collectKMK",
                   key = "Ov23liVjF0K2QY1k2Px5",  #Client ID
                   secret = "497d936aea2c68b748ae244b1e3988fe7593d8c8") #Client secrets

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content <- content(req)
content[[24]]$created_at

# SQLDF -------------------------------------------------------------------

rm(list = ls())
install.packages("sqldf")

library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
getwd()
setwd(paste(getwd(),"data",sep = "/"))
destinationFile <- "americanCommunitySurvey.csv"
download.file(
  url = fileUrl,
  destfile = destinationFile,
  method = "libcurl"
)

acs <- read.csv("americanCommunitySurvey.csv")
sort(names(acs))
p1_lessthan_50yr <- sqldf("SELECT pwgtp1 FROM acs WHERE AGEP < 50;")

unique(acs$AGEP)
sqldf("SELECT DISTINCT AGEP FROM acs;")

# HTML webpage line and character --------------------------------------------------------------------

library(httr)
library(XML)
rm(list = ls())
connect <- url("http://biostat.jhsph.edu/~jleek/contact.html")
lines <- readLines(connect)
lines[c(10, 20, 30, 100)]
nchar(lines[c(10, 20, 30, 100)])


# Fixed width format file -------------------------------------------------

rm(list = ls())
readLines(url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"))
## No space  is accepted in fwf file format. 
## To get nine column the file is read like this:
### " 21JAN2009     25.3 0.5     25.5-0.2     25.8-0.8     27.4-0.8"
### ( 12       )(4 )(  9    )(4 )(  9    )(4 )(  9    )(4 )(  9    )
url <- "http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"

widths <- c(12,4,9,4,9,4,9,4,9)
df <- readr::read_fwf(url, fwf_widths(widths), skip = 4)
sum(df[,"X4"], na.rm = T)
## Answer not in the choice but approximate, there are only 2 in 4th column

## Try another split
rm(list = ls())
readLines(url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"))
## No space  is accepted in fwf file format. 
## To get nine column the file is read like this:
### " 21JAN2009     25.3 0.5     25.5-0.2     25.8-0.8     27.4-0.8"
### ( 10      )(   9    )(4 )(   9  )(4 )(   9  )(4 )(  9     )(4  )
### 4 lines that are and not data
url <- "http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"

widths <- c(10,9,4,9,4,9,4,9,4)
df <- readr::read_fwf(url, fwf_widths(widths), skip = 4)
head(df,4); tail(df, 4)
sum(df[,"X4"], na.rm = T)
