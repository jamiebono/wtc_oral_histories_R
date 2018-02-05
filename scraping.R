library(tidyverse)
library(rvest)
library(stringr)

nyt_url <- "http://graphics8.nytimes.com/packages/html/nyregion/20050812_WTC_GRAPHIC/met_WTC_histories_full_01.html"

page <- nyt_url %>% 
  read_html() 

#### ULTIMATELY, I Ended Up Doing This With Regex ####

library(readr)
nyt_list <- read_delim("nyt_list.txt", "\t", 
                       escape_double = FALSE, col_types = cols(`DATE OF INTERVIEW` = col_date(format = "%m/%d/%y")), 
                       trim_ws = TRUE)
View(nyt_list)

nyt_list<- nyt_list %>% 
  mutate(NAME = gsub("\\(pdf file\\)", "", NAME))

  