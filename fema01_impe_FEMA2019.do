local dataset `"FEMA2019"'
local category `"01_impe"'

capture log close fema`category'_`dataset'
log using $stata/fema`category'_`dataset'.log, name(fema`category'_`dataset') replace text
***-----------------------------***

// 	project:	Disability and Information about Climate Disaster
//  task:     	Import "fema_national-household-survey-raw-data-and-weights_2019.xlsx" and save to Derived folder
/*  data:    */ di "`dataset'"

//  github:   	fema_disability
//  OSF:		

//  author:   	Molly King & Brooke Rose

display "$S_DATE  $S_TIME"

***--------------------------***
// # PROGRAM SETUP
***-----------------------------***

version 16 // keeps program consistent for future replications
set linesize 80
clear all
set more off

***-----------------------------***
// # IMPORT
***-----------------------------***

import excel ///
$source/fema_national-household-survey-raw-data-and-weights_2019.xlsx, ///
	sheet("2019 NHS - Raw Data and weights") ///
	firstrow clear

***--------------------------***
// # SAVE DATA
***-----------------------------***

label data "`dataset' data: FEMA National Household Survey 2019"
notes: fema`category'_`dataset'.dta \ FEMA National Household Survey 2019 \ fema`category'_`dataset'.do mmk $S_DATE
compress
datasignature set

save $deriv/fema`category'_`dataset'.dta, replace

***--------------------------***

log close fema`category'_`dataset'
exit
