# project:	Disability and Information about Climate Disaster
# task:     Load and add weights to FEMA dataset
# github:   fema_disability
# author:   Molly King & Brooke Rose

# --- Load packages ---
library("tidyverse")
library("haven")
library("survey")  

setwd("~/Documents/SocResearch/RA_projects/FEMA_Disability_Climate/")

# --- Import Data ---
nhs <- read.csv("data/data_derv/fema02_clean_FEMA2019.csv")  # Import


# --- Add Weights to Data ---

nhsw <- svydesign(id = ~0, weights = ~combwtall, data = nhs)

summary(nhsw) #summary of weighted dataset


