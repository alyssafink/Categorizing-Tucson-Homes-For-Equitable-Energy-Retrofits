### CHI-SQUARED TEST FOR BUILDING SEGMENTS ###

# Set working directory
getwd()
setwd("//apporto.com/dfs/ARIZONA/Users/alyssafink_arizona/Desktop/SBE 580")
getwd()

# install and load required packages
# install.packages("tidyverse", repos = "http://cran.us.r-project.org")
# install.packages("haven", repos = "http://cran.us.r-project.org")  
# install.packages("janitor", repos = "http://cran.us.r-project.org")  
# install.packages("vtable", repos = "http://cran.us.r-project.org") 
# install.packages("sjPlot", repos = "http://cran.us.r-project.org") 
# install.packages("kableExtra", repos = "http://cran.us.r-project.org")
library(tidyverse)
library(haven)
library(janitor)
library(vtable)
library(sjPlot)
library(kableExtra)

# importing data
tucsonparcels_v1 <- read_csv("arcgisexport_11.18.csv")

# rename all variables with lower case letters
tucsonparcels_v1 <- tucsonparcels_v1 %>%
  clean_names(., "snake")

# select only the variables that are needed
segments_chisquared_v1 <- tucsonparcels_v1 %>%
  dplyr::select(walls2, year2)

# check variable class
vtable(segments_chisquared_v1)

# change variables to class factor and ensure they are in the correct order
segments_chisquared_v1 <- segments_chisquared_v1 %>%
  dplyr::mutate(walls2 = factor(walls2, levels=c("WOOD", "MASONRY", "OTHER")),
                year2 = factor(year2, levels=c("<1940", "1940-1979", ">1979"))
                )

# check to make sure iy worked
sumtable(segments_chisquared_v1)

# calculate two-way table and chi-squared
sjPlot::tab_xtab(var.row = segments_chisquared_v1$walls2, var.col = segments_chisquared_v1$year2, 
                 show.cell.prc = TRUE,    show.row.prc = TRUE, show.col.prc = TRUE, show.exp = TRUE,  show.legend = TRUE, digits = 2)

### CHI-SQUARE TEST FOR BUILDING SEGMENT AND LIDAC STATUS ###

# select only the variables that are needed
vuln_segments_chisquare_v1 <- tucsonparcels_v1 %>%
  dplyr::select(segment, sn_c)

# check variable class
vtable(vuln_segments_chisquare_v1)

# change variables to class factor and ensure they are in the correct order
vuln_segments_chisquare_v2 <- vuln_segments_chisquare_v1 %>%
  dplyr::mutate(sn_c = case_when(sn_c == "0" ~ "Not LIDAC",
                                 sn_c == "1" ~ "LIDAC"),
                sn_c = factor(sn_c, levels=c("LIDAC", "Not LIDAC")),
                segment = factor(segment)
  )

# check to make sure iy worked
sumtable(vuln_segments_chisquare_v2)

# calculate two-way table and chi-squared
sjPlot::tab_xtab(var.row = vuln_segments_chisquare_v2$segment, var.col = vuln_segments_chisquare_v2$sn_c, 
                 show.cell.prc = TRUE,    show.row.prc = TRUE, show.col.prc = TRUE, show.exp = TRUE,  show.legend = TRUE, digits = 2)