############## EXEMPEL PostgreSQL ##############
# Calling R in command mode
# R --no-save < RpostgreSQL.R 

library("DBI")
library("RPostgreSQL")

############## SETS LOGIN INFORMATION ##############
#
# Sets database login information for the other scripts
#
source("../.gitignore/login.R")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, user=login$user, password=login$password, dbname=login$dbname)

res <- dbSendQuery(con, "select * from genotype")
chunk <- fetch(res, n = 100) # Return only 100 rows

# look at the results 
chunk
class(chunk)
chunk$index_nr

data <- dbGetQuery(con, "select * from genotype") # return whole table
plot(data$type_nr,
     xlab="Sample space",
     ylab="Genotype Nr",
     main="Genotype distribution of ASFV Sardinia")

dbClearResult(res)
dbDisconnect(con)
dbUnloadDriver(drv)
