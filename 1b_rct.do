
                         ********************************************************************************
						 *        STATA PRACTICE SESSION-1(b) FOR EC-402(2022) BY SANJOG RAJIV          *
                         ********************************************************************************

											  *****************
											  * RCT EXERCISE  *
											  *****************

* SET FILE PATH
	clear
	global raw "C:/Users/lenovo/Desktop/402_practice/raw"
	global output "C:/Users/lenovo/Desktop/402_practice/output"
	
	use "$raw/rct.dta", clear
 
//1) Rename - male/female

//2) gen total kero expense, total social time & log of expenses

//2) keep only endline data and drop - unique_id, discontent_reason, married and survey 

//3) Var Label

//4) Cleaning and Value Label - apply to religion and caste

//5) sum of male and female and check if it equals children

//6) (99) to 0 - kidslighting -- gen dummy for studying

//7) Choose dep vars --- at least 4-5

//8) Think of Covariates --- Do tests and graphs

//9) Run regressions to find ATT / scatter graphs

//10) Adoption rates - LATE (To be explained)