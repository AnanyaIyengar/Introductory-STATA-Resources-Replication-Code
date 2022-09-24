
                         ********************************************************************************
						 *        STATA PRACTICE SESSION-1(a) FOR EC-402(2022) BY SANJOG RAJIV          *
                         ********************************************************************************
						 
clear // clears any dataset in memory

*Note : * or // creates comments

********************************************************************************

//1) Opening a file

	use "C:/Users/lenovo/Desktop/402_practice/raw/auto.dta", clear
	
	*OR*
	
	global raw "C:/Users/lenovo/Desktop/402_practice/raw"
	global output "C:/Users/lenovo/Desktop/402_practice/output"
	
	use "$raw/auto.dta", clear
	
	//data exploration
		*count
		*br
		*edit
		*help
		*describe

********************************************************************************

//2) Renaming a Variable

	rename Cost price
	rename (rep78 mpg) (repair78 mileage)
	
********************************************************************************

//3) Labelling a Variable
	
	label variable foreign "Car Type: Domestic or Foreign"	
	
********************************************************************************

//4) Cleaning a Variable

	*Logical operations : == , != , >=, <=, >, <, &, |

	tab foreign
	replace foreign = "1" if foreign == "F" | foreign == "Foreign"
	replace foreign = "0" if foreign == "D" | foreign == "Domestic"
	replace foreign = "" if foreign == "Unknown"
	destring foreign, replace

	destring *, replace
	summarize

********************************************************************************

//5) Value Label

	label define type 0 "Domestic" 1 "Foreign"
	label values foreign type
	
********************************************************************************	
	
//6) Generate and drop

	gen logprice = log(price)	
	
	drop turn trunk
	
	drop if missing(foreign)
	
********************************************************************************	
	
//7) Graphs

	twoway (scatter price length) (lfit price length), name(my_graph, replace)
	graph export "$output/scatter_price_length.pdf", as(pdf) name(my_graph) replace


********************************************************************************

//8) Regressions

	//1)
	reg price foreign
	margins, over(foreign)
	marginsplot, name(reg_1, replace)
	
	//2)
	reg price foreign mileage
	
	tw (kdensity weight if foreign == 0) (kdensity weight if foreign == 1), ///
	legend(label(1 "Domestic") label(2 "Foreign")) xtitle("Weight") ytitle("Kernel Density") ///
	name(kdensity_weight, replace)
	ttest weight, by(foreign)
	
	//3)
	reg price foreign mileage weight
	estat hettest
	rvfplot, name(heteroscedastic, replace)
	
	//4)
	reg logprice foreign mileage weight
	estat hettest
	rvfplot, name(homoscedastic, replace)
	margins, at(weight=(1500(250)5000)) over(foreign)
	marginsplot, name(reg_4, replace)
	
	//5)
	reg logprice foreign mileage c.weight##c.weight
	*Predict values
	margins, at(weight=(1500(250)5000)) over(foreign)
	marginsplot , name(reg_5, replace)
	
********************************************************************************

//8) Tables

	reg price foreign
	estimates store a1
	reg price foreign mileage
	estimates store a2
	reg price foreign mileage weight
	estimates store a3
	reg logprice foreign mileage weight
	estimates store a4
	reg logprice foreign mileage c.weight##c.weight
	estimates store a5

	esttab a1 a2 a3 a4 a5, b(3) se(3) star r2
	esttab a1 a2 a3 a4 a5 using "$output/reg.doc",  b(3) se(3) star r2 replace

********************************************************************************

//9) Categorical Variables
	
	reg price i.length_quart
	
********************************************************************************	
	
//10) Saving a dta file

	save "$output/auto_final.dta", replace
	
********************************************************************************	
	
/*					BONUS : for cleanplots :- 

	net install cleanplots, from("https://tdmize.github.io/data/cleanplots")
	set scheme cleanplots, perm  // To apply cleanplots scheme
	set scheme s2color, perm // To revert to defualt scheme
*/

	