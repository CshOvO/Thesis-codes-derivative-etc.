 import delimited "C:\Users\85832\Documents\Msc_thesis_code\filtered_data.csv", clear
 *PoolOLS
 xtset gvkey fyear
 
 reg mb roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth 
 estimates store mb
 outreg2 [mb] using "PoolOLS_results.xls", replace excel ///
    title("PoolOLS Results") ///
    label dec(4) stats(coef se) ///
    addstat(Observations, e(N), R-squared, e(r2)) ///
    ctitle("Market-to-Book")
	
 reg tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth
 estimates store tbq
  outreg2 [tbq] using "PoolOLS_results.xls", append excel ///
    title("PoolOLS Results") ///
    label dec(4) stats(coef se) ///
    addstat(Observations, e(N), R-squared, e(r2)) ///
    ctitle("Tobin's Q")
	
 reg ln_tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth
  estimates store lntbq
   outreg2 [lntbq] using "PoolOLS_results.xls", append excel ///
    title("PoolOLS Results") ///
    label dec(4) stats(coef se) ///
    addstat(Observations, e(N), R-squared, e(r2)) ///
    ctitle("ln(Tobin's Q)")
 
outreg2 [tbq lntbq mb] using "PoolOLS_results.xls", replace excel ///
    title("PoolOLS Results") ///
    label dec(4) stats(coef se) ///
    addstat(Observations, e(N), R-squared, e(r2)) ///
    ctitle(" "，"Tobin's Q","ln(Tobin's Q)","Market-to-Book")
 
xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary ln_at dividend_binary growth,fe 
 xtreg ln_tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary ln_at dividend_binary growth,fe 
 
 xtreg mb roa leverage current_ratio debt_to_equity l.derhedgl_binary ln_at dividend_binary growth i.fyear,fe 
 xtreg mb roa leverage current_ratio debt_to_equity derhedgl_binary ln_at dividend_binary growth,fe 


reg tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth



reg ln_tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth
outreg2 using "temp2.xls", replace excel ///
    title("PoolOLS Results") ///
    label dec(4) stats(coef se) ///
    addstat(Observations, e(N), R-squared, e(r2)) ///
    ctitle("ln(Tobin's Q)")

reg mb roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth



outreg2 using "PoolOLS_results.xls", replace excel ///
    title("PoolOLS Results") ///
    label dec(4) stats(coef se) ///
    ctitle("Tobin's Q")
    
outreg2 using "PoolOLS_results.xls", append excel ///
    label dec(4) stats(coef se) ///
    ctitle("ln(Tobin's Q)")
    
outreg2 using "PoolOLS_results.xls", append excel ///
    label dec(4) stats(coef se) ///
    ctitle("Market-to-Book")
 
 
 
 


* This regression is to estimate the ln market value  \label{Mb ratio and derivative usage}
xtreg mb roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth, fe
estimates store FE
outreg2 [FE] using "hedging_mb.xls", replace excel ///
    title("Hedging Intensity and market-to-book") ///
    ctitle("FE Only") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

xtreg mb roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth, re
estimates store RE
outreg2 [RE] using "hedging_mb.xls", append excel ///
    ctitle("Firm RE Only") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")
xtreg mb roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth i.fyear, fe
estimates store TFE
outreg2 [TFE] using "hedging_mb.xls", append excel ///
    ctitle("Twoway FE Only") ///
    label dec(4) /// ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

xtreg mb roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth i.fyear, re
estimates store TRE
outreg2 [TRE] using "hedging_mb.xls", append excel ///
    ctitle("RE Time FE Only") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")


hausman FE RE 
hausman TFE TRE

	
* Tbq \label{Tbq0} \caption{Hedging Intensity and Tobin's Q Results}
xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth, fe

estimates store FE

outreg2 [FE] using "hedging_ln_tbq.xls", replace excel ///
    title("Hedging Intensity and log Tobins'Q") ///
    ctitle("Firm FE") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth, re
estimates store RE

outreg2 [RE] using "hedging_ln_tbq.xls", append excel ///
    title("Hedging Intensity and Tobins'Q") ///
    ctitle("Firm RE") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")

xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth i.fyear, fe
estimates store TFE

outreg2 [TFE] using "hedging_ln_tbq.xls", append excel ///
    ctitle("Twoway FE") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l_derhedgl_binary ln_at dividend_binary growth i.fyear, re
estimates store TRE
outreg2 [TRE] using "hedging_ln_tbq.xls", append excel ///
    ctitle("Twoway RE") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")

	hausman FE RE

	

*Further test how is the hedge value affecting market value
import delimited "C:\Users\85832\Documents\Msc_thesis_code\der_set.csv", clear
xtset gvkey fyear
xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth, fe
estimates store FE
xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth, re
estimates store RE
xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear, fe
estimates store TFE
xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear, re
estimates store TRE

outreg2 [FE] using "gl_lntbq.xls", replace excel ///
    title("Derivative gain or loss and ln(Firm Market Value)") ///
    ctitle("Firm FE Only") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "Yes")

outreg2 [RE] using "gl_lntbq.xls", excel ///
    ctitle("Random Effects") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "No", Firm FE, "No")

outreg2 [TFE] using "gl_lntbq.xls", excel ///
    ctitle("Two-way FE") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [TRE] using "gl_lntbq.xls", excel ///
    ctitle("RE + Time FE") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "No")


	
xtreg mb roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth, fe
estimates store FE

xtreg mb roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth, re
estimates store RE
xtreg mb roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear, fe
estimates store TFE
xtreg mb roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear, re
estimates store TRE

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
	eststo Low: xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear if size_tercile == 1, fe
	eststo Medium: xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear if size_tercile == 2, fe
	eststo High: xtreg ln_tobins_q roa leverage current_ratio debt_to_equity l.derhedgl ln_at dividend_binary growth i.fyear if size_tercile == 3, fe
	
	outreg2 [Low] using "Divided_q.xls", replace excel ///
    title("Hedging Intensity and Q") ///
    ctitle("Low Debt") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [Medium] using "Divided_q.xls", append excel ///
    ctitle("Medium Debt") ///
    label dec(4) ///
    addstat(Within R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Time FE, "Yes", Firm FE, "Yes")

outreg2 [High] using "Divided_q.xls", append excel ///
    ctitle("High Debt") ///
    label dec(4) ///
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

	
	
	