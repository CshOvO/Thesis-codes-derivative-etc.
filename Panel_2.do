 import delimited "C:\Users\85832\Documents\Msc_thesis_code\filtered_data.csv", clear
 *PoolOLS
 
 reg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary
 estimates store ln_mkvalt
 reg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary
 estimates store tbq
 outreg2 [ln_mkvalt tbq] using "PoolOLS_results.xls", replace excel ///
   title("PoolOLS Results") ///
   label dec(4) stats(coef se) ///
   addstat(R-squared, e(N)) ///
   ctitle("", "ln market value", "Tobin's Q")
   
 
xtset gvkey fyear



* This regression is to estimate the ln market value  \label{Mkv0}
xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary, fe
estimates store FE
outreg2 [FE] using "hedging_mkv0.xls", replace excel ///
    title("Hedging Intensity and ln(Market Value)") ///
    ctitle("FE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary, re
estimates store RE
outreg2 [RE] using "hedging_mkv0.xls", append excel ///
    ctitle("Firm RE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")
xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, fe
estimates store TFE
outreg2 [TFE] using "hedging_mkv0.xls", append excel ///
    ctitle("Twoway FE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, re
estimates store TRE
outreg2 [TRE] using "hedging_mkv0.xls", append excel ///
    ctitle("Twoway RE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")


hausman FE RE 
hausman TFE TRE

	
* Tbq \label{Tbq0} \caption{Hedging Intensity and Tobin's Q Results}
xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary, fe

estimates store FE

outreg2 [FE] using "hedging_tbq.xls", replace excel ///
    title("Hedging Intensity and Tobins'Q") ///
    ctitle("Firm FE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary, re
estimates store RE

outreg2 [RE] using "hedging_tbq.xls", append excel ///
    title("Hedging Intensity and Tobins'Q") ///
    ctitle("Firm RE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, fe
estimates store TFE

outreg2 [TFE] using "hedging_tbq.xls", append excel ///
    ctitle("Twoway FE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, re
estimates store TRE
outreg2 [TRE] using "hedging_tbq.xls", append excel ///
    ctitle("Twoway RE") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity roa derhedgl_binary) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")

	hausman FE RE sigmamore

	

*Further test how is the hedge value affecting market value
import delimited "C:\Users\85832\Documents\Msc_thesis_code\der_set.csv", clear
xtset gvkey fyear
xtreg ln_mkval leverage current_ratio debt_to_equity derhedgl,fe
estimates store FE
xtreg ln_mkvalt leverage current_ratio debt_to_equity derhedgl,re
estimates store RE
xtreg ln_mkvalt leverage current_ratio debt_to_equity derhedgl i.fyear,re
estimates store TRE
xtreg ln_mkvalt leverage current_ratio debt_to_equity derhedgl i.fyear,fe
estimates store TFE

outreg2 [FE] using "hedging_mv.xls", replace excel ///
    title("Derivative gain or loss and ln(Firm Market Value)") ///
    ctitle("Firm FE Only") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

outreg2 [RE] using "hedging_mv.xls", excel ///
    ctitle("Random Effects") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")

outreg2 [TFE] using "hedging_mv.xls", excel ///
    ctitle("Two-way FE") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [TRE] using "hedging_mv.xls", excel ///
    ctitle("RE + Time FE") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")


**************************************************************************************

	*Dividing to groups with High, Medium and low. Regression after.
	*Sub regressions
**************************************************************************************
	
	import delimited "C:\Users\85832\Documents\Msc_thesis_code\der_set.csv", clear
	sort fyear dt
	bysort fyear: egen size_tercile = xtile(dt), nq(3)
	label define size_label 1 "Low" 2 "Medium" 3 "High"
	label values size_tercile size_label
	
	eststo clear
	xtset gvkey fyear
	eststo Low: xtreg ln_mkvalt derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 1, fe
	eststo Medium: xtreg ln_mkvalt derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 2, fe
	eststo High: xtreg ln_mkvalt derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 3, fe
	
	outreg2 [Low] using "Divided_mkvalt.doc", replace excel ///
    title("Hedging Intensity and Firm Market Value") ///
    ctitle("Low Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [Medium] using "Divided_mkvalt.doc", excel ///
    ctitle("Medium Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")

outreg2 [High] using "Divided_mkvalt.doc", excel ///
    ctitle("High Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")
	eststo clear
	xtset gvkey fyear
	eststo Low: xtreg ln_mkvalt derhedgl leverage current_ratio debt_to_equity if size_tercile == 1, fe
	eststo Medium: xtreg ln_mkvalt derhedgl leverage current_ratio debt_to_equity if size_tercile == 2, fe
	eststo High: xtreg ln_mkvalt derhedgl leverage current_ratio debt_to_equity if size_tercile == 3, fe
	
	
	eststo clear
	xtset gvkey fyear
eststo Low_Tobinsq: xtreg tobins_q derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 1, fe
eststo Medium_Tobinsq: xtreg tobins_q derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 2, fe
eststo High_Tobinsq: xtreg tobins_q derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 3, fe

outreg2 [Low_Tobinsq] using "Divided_tbq.doc", replace excel ///
    title("Hedging Intensity and Tobin's Q") ///
    ctitle("Low Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [Medium_Tobinsq] using "Divided_tbq.doc", excel ///
    ctitle("Medium Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")

outreg2 [High_Tobinsq] using "Divided_tbq.doc", excel ///
    ctitle("High Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

/*
eststo clear
xtset gvkey fyear
eststo Low_ROA_TFE: xtreg roa derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 1, fe
eststo Medium_ROA_TFE: xtreg roa derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 2, fe
eststo High_ROA_TFE: xtreg roa derhedgl leverage current_ratio debt_to_equity i.fyear if size_tercile == 3, fe

outreg2 [Low_ROA_TFE] using "Divided_ROA.doc", replace excel ///
    title("Hedging Intensity and ROA") ///
    ctitle("Low Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [Medium_ROA_TFE] using "Divided_ROA.doc", excel ///
    ctitle("Medium Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")

outreg2 [High_ROA_TFE] using "Divided_ROA.doc", excel ///
    ctitle("High Debt") ///
    label dec(4) ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

eststo Low_ROA_FE: xtreg roa derhedgl leverage current_ratio debt_to_equity if size_tercile == 1, fe
eststo Medium_ROA_FE: xtreg roa derhedgl leverage current_ratio debt_to_equity if size_tercile == 2, fe
eststo High_ROA_FE: xtreg roa derhedgl leverage current_ratio debt_to_equity if size_tercile == 3, fe
*/

*The regressions above shows mixing results， revealing the possible existence of Hetrogenity. In order to further investigate how is the Treatment effects, Causual forests are usd.

	
	
	