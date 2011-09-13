############## EXEMPEL PostgreSQL ##############
#R --no-save < mysql_virus.R 

library("DBI")
library("RMySQL")

############## SETS LOGIN INFORMATION ##############
#
# Sets database login information for the other scripts
#
source("../.gitignore/login.R")

drv <- dbDriver("MySQL")
con <- dbConnect(drv, user=login$user, password=login$password, dbname=login$dbname, host=login$host)

# Plotting genotype distribution
data <- dbGetQuery(con, "SELECT * FROM orf where chr_id=1")
plot((data$first_pos + data$last_pos)/2, abs(data$first_pos - data$last_pos),
     xlab="Gene position on genome",
     ylab="Gene length",
     main="Gene plot for ASFV Sardinia")
data$first_pos

#dbClearResult(res)
dbDisconnect(con)
dbUnloadDriver(drv)
