rm(list = ls())
library(httr)

## Find oauth setting for github
oauth_endpoints("github")

## Register your own application on github:
### urlPath: https://github.com/settings/developers
### homepageURL: http://github.com
### callbackURL: localhost:1410

myapp <- oauth_app("collectKMK",
                   key = "Ov23liVjF0K2QY1k2Px5",  #Client ID
                   secret = "497d936aea2c68b748ae244b1e3988fe7593d8c8") #Client secrets
str(myapp)

## Get OAuth credentials and generate a token
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
### Let yourself access credentials and authenticate yourself
str(github_token)

## Use API to get the content
gtoken <- config(token = github_token)
str(gtoken)
req <- GET("https://api.github.com/rate_limit", gtoken)
str(req)
stop_for_status(req)
content(req)
