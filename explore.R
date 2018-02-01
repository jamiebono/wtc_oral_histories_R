library(tidyverse)
library(rebus)
library(stringr)

text_file_url <- "https://ia800301.us.archive.org/32/items/911OralHistoryProject-AllTestimoniesInOneSearchablePdf/911truthFull_djvu.txt"

raw_text <- readLines(text_file_url)
text_df <- as.tibble(raw_text)

text_df$breakpoint <- str_detect(text_df$value, "^File No")
View(text_df)
text_list <- split(text_df, text_df$breakpoint)
text_list <- split(text_df, text_df$breakpoint == TRUE)
View(text_df)


text_df$file_no <- ifelse(str_detect(text_df$value, "^File No"), text_df$value, FALSE)
text_df$subject <- ifelse(str_detect(text_df$value, "^[[:upper:]]"), text_df$value, FALSE)
text_df$page_no <- ifelse(str_detect(text_df$value, "^[0-9]+"), text_df$value, FALSE )
