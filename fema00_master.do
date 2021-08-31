cd "~/Documents/SocResearch/RA_projects/FEMA_Disability_Climate/"

capture log close master
log using code/fema00_master.log, name(master) replace text

** COVID_Knowledge_News - Master Data Management Do File ***

//	project:	Disability and Information about Climate Disaster

//  task:		Master file to rerun sequence of do-files to reproduce all work
//				related to data import, cleaning, and variable creation
//				This will run all files in stata folders

//  program:	fema00_master.do
//	log:		fema00_master.log

//  github:		disability_fema
//  OSF:		

//  author:		Molly King & Brooke Rose


// # PROGRAM SETUP
version 16 // keeps program consistent for future replications
set linesize 80
clear all
set more off

display "$S_DATE  $S_TIME"

***--------------------------***

*do file folders 

 *Globals
global source	"~/Documents/SocResearch/RA_projects/FEMA_Disability_Climate/data/data_sorc"  	// original datasets
global deriv	"~/Documents/SocResearch/RA_projects/FEMA_Disability_Climate/data/data_derv"  	// derived datasets
global stata	"~/Documents/SocResearch/RA_projects/FEMA_Disability_Climate/code"  	// stata


/*
***--------------------------***
// 01 IMPORT AND EXTRACTION 
***--------------------------***

do $stata/fema01_impeFEMA2019.do 				// Import "fema_national-household-survey-raw-data-and-weights_2019.xlsx"


/*
***--------------------------***
log close master
exit
