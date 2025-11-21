import delimited "C:\Users\85832\Documents\Msc_thesis_code\filtered_data.csv", clear
xtset gvkey fyear



xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary, fe

estimates store FE

xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary, re
estimates store RE

xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, fe
estimates store TFE

xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, re
estimates store TRE



hausman FE RE 
hausman TFE TRE

outreg2 [FE RE TFE TRE] using "regression_results.doc", replace excel ///
    title("Panel Regression Results") ///
    ctitle("", "FE (No Year)", "RE (No Year)", "FE (With Year)", "RE (With Year)") ///
    label dec(4) ///
    keep(roa leverage current_ratio debt_to_equity derhedgl_binary)
	
	
xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary, fe

estimates store FE

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary, re
estimates store RE

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, fe
estimates store TFE

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary i.fyear, re
estimates store TRE

hausman FE RE

outreg2 [FE RE TFE TRE] using "tobins_q.doc", replace excel ///
    title("Panel Regression Results") ///
    ctitle("", "FE (No Year)", "RE (No Year)", "FE (With Year)", "RE (With Year)")  ///
    label dec(4) stats(coef se) ///
    addtext(Time FE, "No", Firm FE, "Yes") ///
    keep(roa leverage current_ratio debt_to_equity derhedgl_binary) ///
    addstat(R-squared, e(r2_o), Observations, e(N)) ///
    sortvar(roa leverage current_ratio debt_to_equity derhedgl_binary)
	
	
*** ROA as dependent 


outreg2 [FE RE TFE TRE] using "roa.doc", replace excel ///
    title("Panel Regression Results") ///
    ctitle("", "FE (No Year)", "RE (No Year)", "FE (With Year)", "RE (With Year)")  ///
    label dec(4) stats(coef se) ///
    addtext(Time FE, "No", Firm FE, "Yes") ///
    keep(roa leverage current_ratio debt_to_equity derhedgl_binary) ///
    addstat(R-squared, e(r2_o), Observations, e(N)) ///
    sortvar(roa leverage current_ratio debt_to_equity derhedgl_binary)
	
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


outreg2 [FE RE TFE TRE] using "hedging_mv.doc", replace excel ///
    title("Hedging and Firm Market Value") ///
    ctitle("", "FE (No Year)", "RE (No Year)", "FE (With Year)", "RE (With Year)")  ///
    label dec(4) stats(coef se) ///
    addtext(Time FE, "No", Firm FE, "Yes") ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(R-squared, e(r2_o), Observations, e(N)) ///
	sortvar(leverage current_ratio debt_to_equity derhedgl)

*** test is roa leading and hedge


xtreg roa tobins_q leverage current_ratio debt_to_equity derhedgl, fe

estimates store FE

xtreg roa tobins_q leverage current_ratio debt_to_equity derhedgl, re
estimates store RE

xtreg roa tobins_q leverage current_ratio debt_to_equity derhedgl i.fyear, fe
estimates store TFE

xtreg roa tobins_q leverage current_ratio debt_to_equity derhedgl i.fyear, re
estimates store TRE

hausman FE RE

outreg2 [FE RE TFE TRE] using "hedging_results.doc", replace excel ///
    title("Hedging Intensity and Firm Market Value") ///
    ctitle("", "FE (No Year)", "RE (No Year)", "FE (With Year)", "RE (With Year)")  ///
    label dec(4) stats(coef se) ///
    addtext(Time FE, "No", Firm FE, "Yes") ///
    keep(leverage current_ratio debt_to_equity derhedgl) ///
    addstat(R-squared, e(r2_o), Observations, e(N)) ///
	sortvar(leverage current_ratio debt_to_equity derhedgl)

	
	*sortvar(roa leverage current_ratio debt_to_equity hdgl_at hdgl_capx hdgl_ni)
