### CLEANING DATA ###
# this script takes a .csv file containing a lot of residential tax assessor data and 
# turns it into a .csv file with the building segment assignment and related variables
# for all parcels containing single-family homes in Pima County, AZ

# for guidance on accessing the tax assessor dataset, see SBE-580-Pilot-Study/data/README.md

# set working directory - update this once you have accessed the dataset
getwd()
setwd("//apporto.com/dfs/ARIZONA/Users/alyssafink_arizona/Desktop/SBE 580")
getwd()

# install and load required packages. if the packages have already been loaded, only run the library commands
# install.packages("vtable", repos = "http://cran.us.r-project.org") 
# install.packages("janitor", repos = "http://cran.us.r-project.org")  
# install.packages("dplyr", repos = "http://cran.us.r-project.org")
# install.packages("jtools", repos = "http://cran.us.r-project.org")
library(vtable)
library(janitor)
library(dplyr)
library(jtools)

# read and load the residential tax assessor dataset (accessed online, see note above)
Mas25 <- read.csv("tax_assessor/Mas25.csv", header = TRUE, sep = ",")

# turn off scientific notation
options(scipen = 999)

# rename all variables with lower case letters
Mas25 <- Mas25 %>%
  clean_names(., "snake")

# create a new dataset with only the parcels with single-family residences
parcel_year_wall_v1 <- Mas25 %>% filter(sfrcondo == "S       ")

# clean the dataset to include only the variables that are needed: parcel # (parcel), effective construction year (year), and exterior wall type (walls)
parcel_year_wall_v2 <- parcel_year_wall_v1 %>%
  dplyr::select(parcel, year, walls)

# remove any cases with missing values on any variables in the dataset
parcel_year_wall_v3 <- parcel_year_wall_v2 %>%
  na.omit()

# check variable class
vtable(parcel_year_wall_v3)

# change variables to correct class
  parcel_year_wall_v4 <- parcel_year_wall_v3 %>%
  dplyr::mutate(year = as.numeric(year), 
                walls = as.factor(walls),
                parcel = as.factor(parcel))
  
# check variable class
vtable(parcel_year_wall_v4)

# confirm unique values in 'walls'. there are some odd spaces in the values that need to be accounted for
unique(parcel_year_wall_v4$walls)

# trim trailing spaces in 'walls' values
parcel_year_wall_v4$walls <- trimws(parcel_year_wall_v4$walls)

# confirm unique values in 'walls' without extra spaces
unique(parcel_year_wall_v4$walls)

# recode variable 'walls'
# to find coding information, go to https://www.asr.pima.gov/Download
# click the "Real Property" tab, and set the Real Property Valuation Data year to 2025 (or most recent)
# expand "Notice of Value Data"
# Open the File Layout modal for the Mas25.ZIP file
# click on Field Name "Walls" to view coding information
parcel_year_wall_v5 <- parcel_year_wall_v4 %>% 
  dplyr::mutate(walls = case_when(walls == "0" ~ "Framed Wood", 
                                 walls == "1" ~ "Framed Block", 
                                 walls == "2" ~ "8 inch Painted",
                                 walls == "3" ~ "8 inch Stucco",
                                 walls == "4" ~ "Brick",
                                 walls == "5" ~ "Stone",
                                 walls == "6" ~ "Slump Block",
                                 walls == "7" ~ "Adobe",
                                 walls == "8" ~ "Other",
                                 TRUE ~ NA),
                walls = factor(walls, levels=c("Framed Wood","Framed Block","8 inch Painted","8 inch Stucco","Brick","Stone","Slump Block","Adobe","Other")))

# create a new variable walls_c with the broader wall category that each parcel falls into
parcel_year_wall_v6 <- parcel_year_wall_v5 %>%
  dplyr::mutate(walls_c = case_when(
    walls == "Framed Wood" ~ "Wood",
    walls == "Other" ~ "Other",
    TRUE ~ "Masonry"
  ))      

# create a new variable year_c with the construction year category that each parcel falls into
parcel_year_wall_v6 <- parcel_year_wall_v6 %>%
  dplyr::mutate(year = as.numeric(year),  # Ensure 'year' is numeric for comparisons
                year_c = case_when(
                  year < 1940 ~ "<1940",
                  year >= 1940 & year <= 1979 ~ "1940-1979",
                  year > 1979 ~ ">1979",
                  TRUE ~ NA_character_  # Handles any NAs in 'year'
                ))

# create a new variable "segment" with the wall type and construction year range
parcel_year_wall_v7 <- parcel_year_wall_v6 %>%
  dplyr::mutate(segment = paste(walls_c, year_c))

# check variable class
vtable(parcel_year_wall_v7)

# change variables to correct class
parcel_year_wall_v8 <- parcel_year_wall_v7 %>%
  dplyr::mutate(walls_c = as.factor(walls_c), 
                year_c = as.factor(year_c),
                segment = as.factor(segment))

# check variable class
vtable(parcel_year_wall_v8)

# save cleaned dataset as a .csv file
write.csv(parcel_year_wall_v8, "parcel_year_wall_v8.csv", row.names = FALSE)
