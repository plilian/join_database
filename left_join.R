install.packages("odbc")
library(odbc)

csv_data <- read.csv("file_path//csv_file.csv")
csv_unique <- csv_data$uniquevalues

url <- "address" 
database <- "db_name" 
username <- "username" 
password <- "password" 

con <- dbConnect(odbc::odbc(), 
                 Driver = "ODBC Driver 17 for SQL Server",
                 Server = url,
                 Database = database,
                 UID = username,
                 PWD = password)

query <- paste(
  "SELECT * FROM transactions",
  "WHERE userid IN (", paste("'", csv_unique, "'", collapse = ","), ")"
)
result <- dbGetQuery(con, query)

write.csv(result, file = "file_path//csv_file_output.csv", row.names = FALSE)

dbDisconnect(con)
