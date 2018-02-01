# Libraries ====
library(tidyverse)
library(stringr)
library(rebus)
library(tidytext)

# Download file ===========

download.file("https://archive.org/download/911OralHistoryProject-AllTestimoniesInOneSearchablePdf/911truthFull_djvu.txt", "911truthFull_djvu.txt")

# Read file ====
text_lines <- readLines("911truthFull_djvu.txt")

# Rebus pattern for file ID ====
file_ID_pattern <- START %R%
  "File No." %R%
  one_or_more(SPC) %R%
  capture(one_or_more(DGT) %R% BOUNDARY
  )

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

# str_view(text_lines, pattern = file_ID_pattern)
# text_characters <- str_extract(text_lines, pattern = file_ID_pattern)
# table(text_characters)

#### This Method Just gets Q's and A's ====
for (i in 1:length(text_lines))
  if (str_detect(text_lines[i], pattern = q_pattern)) {
    cat("\n", text_lines[i], file = "temp.txt", append = TRUE)
    while (!str_detect(text_lines[i + 1], pattern = a_pattern)) {
      cat(text_lines[i + 1], file = "temp.txt", append = TRUE)
      i <- i + 1
    } 
    cat("\t", file = "temp.txt", append = TRUE)
    while (!str_detect(text_lines[i + 1], pattern = q_pattern)) {
      cat(text_lines[i + 1], file = "temp.txt", append = TRUE)
      i <- i + 1
    } 
  } else {
    i <- i + 1
  }

lines <- read.delim("temp.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)

## BUILDING ON IT ====
for (i in 1:length(text_lines))
  if (str_detect(text_lines[i], pattern = all_caps)) {
    cat("\n", text_lines[i], file = "temp.txt", append = TRUE)
    while (!str_detect(text_lines[i + 1], pattern = all_caps)) {
      cat(text_lines[i + 1], file = "temp.txt", append = TRUE)
      i <- i + 1
    } 
    cat("\t", file = "temp.txt", append = TRUE)
    while (!str_detect(text_lines[i + 1], pattern = q_pattern)) {
      cat(text_lines[i + 1], file = "temp.txt", append = TRUE)
      i <- i + 1
    } 
  } else {
    i <- i + 1
  }

lines <- read.delim("temp.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)






# for (i in 1:length(text_lines))
# 	if (str_detect(text_lines[i], pattern = q_pattern)) {
# 		cat("\n", text_lines[i], file = "temp.txt", append = TRUE)
# 		while (!str_detect(text_lines[i + 1], pattern = a_pattern)) {
# 			cat(text_lines[i + 1], file = "temp.txt", append = TRUE)
# 			i <- i + 1
# 		} 
# 	} else {
# 		i <- i + 1
# 	}
# 
# lines <- read.delim("temp.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)
# 
# 
# 
# for (i in 1:length(text_lines))
# 	if (str_detect(text_lines[i], pattern = a_pattern)) {
# 		cat("\n", text_lines[i], file = "temp.txt", append = TRUE)
# 		while (!str_detect(text_lines[i + 1], pattern = q_pattern)) {
# 			cat(text_lines[i + 1], file = "temp.txt", append = TRUE)
# 			i <- i + 1
# 		} 
# 	} else {
# 		i <- i + 1
# 	}
# 
# lines <- read.delim("temp.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)










