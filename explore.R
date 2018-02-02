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

# Rebus pattern for file ID ====
file_ID_pattern <- START %R%
  "File No." %R%
  one_or_more(SPC) %R%
  capture(one_or_more(DGT)) %R% BOUNDARY

file_ID_pattern_short <- "9110" %R% one_or_more(DGT)
  

# Rebus pattern for "Q."s ====
q_pattern <- START %R%
  "Q" %R%
  DOT %R%
  SPC %R%
  BOUNDARY

# Rebus pattern for "A."s ====
a_pattern <- START %R%
  "A" %R%
  DOT %R%
  SPC %R%
  BOUNDARY

# Rebus pattern for lines starting in ALL CAPS ====
all_caps <- START %R%
  one_or_more(UPPER) %R%
  PUNCT %R%
  SPC %R%
  BOUNDARY

#Rebus pattern for lines with subject names ====
subject_pattern <- START %R%
  one_or_more(UPPER) %R%
  PUNCT %R%
  SPC %R%
  one_or_more(UPPER) %R%
  BOUNDARY



text_df$file_no <- str_extract(text_df$value, pattern = file_ID_pattern_short)
text_df$subject <- str_extract(text_df$value, pattern = subject_pattern)
text_df$page_no <- str_extract(text_df$value, pattern = START %R% one_or_more(DGT) %R% END)

text_df$breakpoint <- NULL

# Sanity Check: Look at the counts ====

sum(!is.na(text_df$file_no))  # 496 interviews

text_df<- text_df %>% 
  fill(file_no) %>% 
  fill(page_no)


# split into a list ====
text_list <- text_df %>% 
  mutate(file_no = as.factor(file_no)) %>% 
  split(x = ., f = .$file_no)

## list length == 495...? ##

text_df %>% 
  count(subject, sort = TRUE) # Note who is at the top. Goldfarb was EMS Car 6
                              # are they all bosses?

text_df %>% 
  count(file_no, sort = TRUE) # Note which have the most lines. Match this to subjects
                              # 9110145 is Goldfarb and it's second in length
                              # How much of this is just the way it's formatted? Need to clean more and re-run

## Need to scrape that NYT page for names & ranks to match against files.



## Let's just look at Zach Goldfarb's interview ====

View(text_list[["9110145"]])
