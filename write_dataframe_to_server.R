## create 3-5 dataframes => write table into server

library(RPostgreSQL)
library(tidyverse)

## 1. create dataframe
## 1.1 customers

customers <- tribble(
  ~customerid, ~name, ~phone, ~gender, ~age,
  1, "Eye", 0999995555, "F", 24,
  2, "Frong", 0988884444, "M", 25,
  3, "Bew", 0977773333, "F", 40,
  4, "Amy", 0966662222, "F", 15,
  5, "Armer", 0955551111, "M", 50
)
customers

## 1.2 orders

orders <- tribble(
  ~orderid, ~customerid, ~productid, ~orderdate,
  1, 1, 2, "2023-11-08",
  2, 2, 5, "2023-10-01",
  3, 3, 1, "2022-12-30",
  4, 4, 4, "2023-09-06",
  5, 5, 3, "2022-10-15"
)
orders

## 1.3 menus

menus <- tribble(
  ~productid, ~productname, ~productprice,
  1, "Hawaiian", 120,
  2, "Pepperoni", 100,
  3, "Double cheese", 150,
  4, "Meat Lover", 120,
  5, "Vegetarian", 80
)
menus

## 2. create connection

con <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "ktycgaio",
  user = "ktycgaio",
  password = "xxxxxxxxxxxxxxxxx",
  port = 5432
)
con

# db List Tables
dbListTables(con)

## 3. write table into server

dbWriteTable(con, "customers", customers)
dbWriteTable(con, "orders", orders)
dbWriteTable(con, "menus", menus)

## 4. get data

dbGetQuery(con, "select * from customers")
dbGetQuery(con, "select * from orders")
dbGetQuery(con, "select * from menus")

## 5. close connection

dbDisconnect(con)