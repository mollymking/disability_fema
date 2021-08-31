local category `"02_clean"'

capture log close fema`category'_FEMA
log using $stata/fema`category'_FEMA.log, name(fema`category'_FEMA) replace text
***-----------------------------***

// 	project:	Disability and Information about Climate Disaster
//  task:     	Clean raw dataset
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


foreach dataset in FEMA2019 FEMA2020 {

use $deriv/fema01_impe_`dataset'.dta, clear
save $deriv/fema`category'_`dataset'.dta, replace

***--------------------------***
// # DROP OBSERVATIONS
***-----------------------------***

*Drop observations where did not respond to key variables (and do robustness checks later)
sum combwtall
drop if combwtall == .
order combwtall
sort  combwtall
summarize
describe

keep combwtall ///
	a1 d4a c2 a2b d2 qnsc7 d6* ///
	d13 d14 /// income
	d401 d402 d403 d404 d405 /// race
	d3 /// hispanic
	fema_reg_code /// FEMA region
	fp3	fp4 fp4_1 /// emergency money
	b9 b9_1 /// emergency supplies
	genexp1 ///  previous experience of disaster
	st_stg1 // stage of preparedness (factor)
	
	
/*	
tab a1
gen infoPrep = .
replace infoPrep = 1 if a1 == 1
replace infoPrep = 0 if a1 == 2


gen countobs = 1

gen inc_under60 = 0
replace inc_under60 = 1 if d13  == 1

gen inc_60to499 = 0
replace inc_60to499 = 1 if d13  == 2

gen inc_500to999 = 0
replace  inc_500to999 = 1 if d13 == 3

gen inc_1kto2k = 0
replace  inc_1kto2k = 1 if d13 == 4

gen inc_2kto3k = 0
replace inc_2kto3k = 1 if d13 == 5

gen inc_3kto4k = 0
replace inc_3kto4k = 1 if d13 == 6

gen inc_4kto5k = 0
replace inc_4kto5k = 1 if d13 == 7

gen inc_5kto75k = 0
replace inc_5kto75k = 1 if d13 == 8

gen inc_75kto10k = 0
replace inc_75kto10k = 1 if d13 == 9

gen inc_10kto15k = 0
replace inc_10kto15k = 1 if d13 == 10

gen inc_15kto20k = 0
replace inc_15kto20k = 1 if d13 == 11

gen inc_20kp = 0
replace inc_20kp = 1 if d13 == 12

*/
***--------------------------***
// # SAVE DATA
***-----------------------------***

label data "`dataset' data: National Household Survey"
notes: fema`category'_`dataset'.dta \ `dataset' National Household Survey \ fema`category'_`dataset'.do mmk $S_DATE
compress
datasignature set, reset

save $deriv/fema`category'_`dataset'.dta, replace

***--------------------------***
// # EXPORT DATA
***-----------------------------***

export delimited using ///
	$deriv/fema`category'_`dataset'.csv, replace

} // close loop through FEMA datasets
	
***--------------------------***

log close fema`category'_FEMA
exit
