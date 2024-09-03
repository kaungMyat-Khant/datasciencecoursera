library(RMySQL)
args(dbConnect)
?dbConnect
## Create a connection object from the host with a given user name
ucscDb <- dbConnect(MySQL(),user = "genome",
          host="genome-mysql.cse.ucsc.edu")
str(ucscDb)
class(ucscDb)
### Here we get MySQLConnection object

## Run the query using the connection object and SQL language 
### Syntax -> dbGetquery(<object>, "SQL command;")
result <- dbGetQuery(ucscDb, "show databases;")
?dbGetQuery #get the result from a SQL query

## Disconnect from the host/ server after we finish our query
dbDisconnect(ucscDb)
result

## Collect hg19 database from the databases in result
hg19 <- dbConnect(MySQL(), user = "genome",
                  db = "hg19",
                  host = "genome-mysql.cse.ucsc.edu")

## We are not finish with hg19 database as we need more query
str(hg19)
## List the tables in the database hg19
allTables <- dbListTables(hg19)



## See the number of tables in the database
str(allTables)
length(allTables)

### There are 12672 tables in the database hg19.
allTables[1:5]

## List the field(variables) in the tables
dbListFields(hg19, "HInv")
dbListFields(hg19, "affyU133Plus2")

## Get the query we want from the fields in the table
### Here we will count all the records in the tables (nrows)
dbGetQuery(hg19, "SELECT COUNT(*) FROM affyU133Plus2")

## Read the table from the database
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
?dbReadTable


## Select a specific subset from the database

## Send the query to the database and fetch the records (row subsetting)
query <- dbSendQuery(hg19, 
                "SELECT * FROM affyU133Plus2 WHERE misMatches BETWEEN 1 AND 3;")
warnings()
str(query)
affyMis <- fetch(query)
### *Note dbGetQuery cannot be used if dbSendQuery is running

quantile(affyMis$misMatches)

### The connection is not stable enough for the query. 

affyMisSmall <- fetch(query, n = 10)

## Clear the query that you have sent to the server
dbClearResult(query)

dim(affyMisSmall)

## Don't forget to disconnect from the server
dbDisconnect(hg19)
