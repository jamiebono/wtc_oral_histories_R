library(tidyverse)
library(rvest)

nyt_url <- "http://graphics8.nytimes.com/packages/html/nyregion/20050812_WTC_GRAPHIC/met_WTC_histories_full_01.html"

subjects <- nyt_url %>% 
  read_html() %>% 
  html_nodes(xpath = '/html/body/table[4]') %>% 
  html_table(fill = TRUE)

  
  '/html/body/table[4]/tbody/tr[1]/td/table/tbody/tr[2]/td[2]/nyt_text/table/tbody/tr/td/table'