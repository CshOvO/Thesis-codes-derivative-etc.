import delimited "C:\Users\85832\Documents\Msc_thesis_code\filtered_data.csv", clear
xtset gvkey fyear



xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary,fe

estimates store FE

xtreg ln_mkvalt roa leverage current_ratio debt_to_equity derhedgl_binary,re
estimates store RE

hausman FE RE

outreg2 [FE RE] using "regression_results.xlsx", replace excel ///
    title("Panel Regression Results") ///
    ctitle("", "Fixed Effects", "Random Effects") ///
    label dec(4) stats(coef se) ///
    addtext(Time FE, "No", Firm FE, "Yes") ///
    keep(roa leverage current_ratio debt_to_equity derhedgl_binary) ///
    addstat(R-squared, e(r2_o), Observations, e(N)) ///
    sortvar(roa leverage current_ratio debt_to_equity derhedgl_binary)
	
xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary,fe

estimates store FE

xtreg tobins_q roa leverage current_ratio debt_to_equity derhedgl_binary,re
estimates store RE	

hausman FE RE

outreg2 [FE RE] using "tobins_q.xlsx", replace excel ///
    title("Panel Regression Results") ///
    ctitle("", "Fixed Effects", "Random Effects") ///
    label dec(4) stats(coef se) ///
    addtext(Time FE, "No", Firm FE, "Yes") ///
    keep(roa leverage current_ratio debt_to_equity derhedgl_binary) ///
    addstat(R-squared, e(r2_o), Observations, e(N)) ///
    sortvar(roa leverage current_ratio debt_to_equity derhedgl_binary)
	
import delimited "C:\Users\85832\Documents\Msc_thesis_code\der_set.csv", clear
xtset gvkey fyear
xtreg ln_mkvalt roa leverage current_ratio debt_to_equity hdgl_at,fe
estimates store hdgl_at
xtreg ln_mkvalt roa leverage current_ratio debt_to_equity hdgl_capx,fe
estimates store hdgl_capx
xtreg ln_mkvalt roa leverage current_ratio debt_to_equity hdgl_ni,fe
estimates store hdgl_ni

outreg2 [hdgl_at hdgl_capx hdgl_ni] using "hedging_results.xlsx", replace excel ///
    title("Hedging Intensity and Firm Market Value") ///
    ctitle("", "(1) Assets", "(2) CapEx", "(3) Net Income") ///
    label dec(4) stats(coef se) ///
    keep(roa leverage current_ratio debt_to_equity hdgl_at hdgl_capx hdgl_ni) ///
    addstat(R-squared, e(r2), Within R-squared, e(r2_w), Between R-squared, e(r2_b), ///
            Overall R-squared, e(r2_o), Observations, e(N)) ///
    addtext(Firm Fixed Effects, "Yes", Time Fixed Effects, "No") ///
    addnote("Notes: All models include firm fixed effects. Robust standard errors in parentheses. *** p<0.01, ** p<0.05, * p<0.1.") ///
    sortvar(roa leverage current_ratio debt_to_equity hdgl_at hdgl_capx hdgl_ni)
