********************************************************************************
clear 

cd "Add Path"

global MY_PATH_OUT  "Add Path"

use all_sessions_ready

sort overall_id period 

********************************************************************************
*In text************************************************************************

*Binary Probit******************************************************************
tab treatment, gen(treatment_)

probit decision treatment_1 if (treatment_1 == 1 | treatment_2 == 1) & phase == 1, cluster(overall_id)

probit decision treatment_3 if (treatment_3 == 1 | treatment_4 == 1) & phase == 1, cluster(overall_id)

*Panel Probit*******************************************************************
xtset overall_id period

xtprobit decision treatment_1 if (treatment_1 == 1 | treatment_2 == 1) & phase == 1, re

xtprobit decision treatment_3 if (treatment_3 == 1 | treatment_4 == 1) & phase == 1, re

********************************************************************************
*In text************************************************************************

tab decision if high == 0 & phase == 1
tab decision if high == 1 & phase == 1

probit decision i.high if phase == 1, cluster(overall_id)

xtset overall_id period

xtprobit decision i.high if phase == 1, re

***

gen signal_give = 1 if signal == 1 | signal == 3 
replace signal_give = 0 if signal == 2 | signal == 4

probit decision i.signal_give if high == 0 & phase == 1 & (period == 3 | period == 4 | period == 6), cluster(overall_id)
probit decision i.signal_give if high == 1 & phase == 1 & (period == 3 | period == 4 | period == 6), cluster(overall_id)

xtset overall_id period

xtprobit decision i.signal_give if high == 0 & phase == 1 & (period == 3 | period == 4 | period == 6), re
xtprobit decision i.signal_give if high == 1 & phase == 1 & (period == 3 | period == 4 | period == 6), re

***

tab signal, gen(signal_ind_)

probit decision i.signal_ind_1 if high == 0 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_1 == 1 | signal_ind_3 == 1), cluster(overall_id)
probit decision i.signal_ind_2 if high == 0 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_2 == 1 | signal_ind_4 == 1), cluster(overall_id)

xtset overall_id period

xtprobit decision i.signal_ind_1 if high == 0 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_1 == 1 | signal_ind_3 == 1), re
xtprobit decision i.signal_ind_2 if high == 0 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_2 == 1 | signal_ind_4 == 1), re

probit decision i.signal_ind_1 if high == 1 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_1 == 1 | signal_ind_3 == 1), cluster(overall_id)
probit decision i.signal_ind_2 if high == 1 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_2 == 1 | signal_ind_4 == 1), cluster(overall_id)

xtset overall_id period

xtprobit decision i.signal_ind_1 if high == 1 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_1 == 1 | signal_ind_3 == 1), re
xtprobit decision i.signal_ind_2 if high == 1 & phase == 1 & (period == 3 | period == 4 | period == 6) & (signal_ind_2 == 1 | signal_ind_4 == 1), re

********************************************************************************
*Figure 4: Figure Giving Rate: Phase 1******************************************

grstyle init
grstyle color background white
grstyle color major_grid dimgray
grstyle linewidth major_grid thin
grstyle yesno draw_major_hgrid no
grstyle yesno draw_major_vgrid yes
grstyle yesno grid_draw_min yes
grstyle yesno grid_draw_max yes
grstyle anglestyle vertical_thick horizontal
grstyle linestyle legend none
grstyle ci_area black
grstyle set size 8pt: subheading axis_title
grstyle set size 8pt: heading
grstyle set size 8pt: tick_label
grstyle set size 8pt: key_label
grstyle set size 8pt: legend

bys period: egen mean_round_p1_low = mean(decision) if high == 0 & phase == 1
lab var mean_round_p1_low "Low"

reg decision if high == 0 & period == 1, cluster(session)

generate lh_decision_p1 = mean_round_p1_low + 0.0289388  if period == 1 & high == 0
generate ll_decision_p1 = mean_round_p1_low - 0.0289388  if period == 1 & high == 0

reg decision if high == 0 & period == 2, cluster(session)

generate lh_decision_p2 = mean_round_p1_low + 0.0340522 if period == 2 & high == 0
generate ll_decision_p2 = mean_round_p1_low - 0.0340522 if period == 2 & high == 0

reg decision if high == 0 & period == 3, cluster(session)

generate lh_decision_p3 = mean_round_p1_low + 0.0349853 if period == 3 & high == 0
generate ll_decision_p3 = mean_round_p1_low - 0.0349853 if period == 3 & high == 0

reg decision if high == 0 & period == 4, cluster(session)

generate lh_decision_p4 = mean_round_p1_low + 0.0367368 if period == 4 & high == 0
generate ll_decision_p4 = mean_round_p1_low - 0.0367368 if period == 4 & high == 0

reg decision if high == 0 & period == 5, cluster(session)

generate lh_decision_p5 = mean_round_p1_low + 0.0394428 if period == 5 & high == 0
generate ll_decision_p5 = mean_round_p1_low - 0.0394428 if period == 5 & high == 0

reg decision if high == 0 & period == 6, cluster(session)

generate lh_decision_p6 = mean_round_p1_low + 0.0529972 if period == 6 & high == 0
generate ll_decision_p6 = mean_round_p1_low - 0.0529972 if period == 6 & high == 0

bys period: egen mean_round_p1_high  = mean(decision) if high == 1 & phase == 1
lab var mean_round_p1_high "High"

reg decision if high == 1 & period == 1, cluster(session)

generate hh_decision_p1 = mean_round_p1_high + 0.0353061 if period == 1 & high == 1
generate hl_decision_p1 = mean_round_p1_high - 0.0353061 if period == 1 & high == 1

reg decision if high == 1 & period == 2, cluster(session)

generate hh_decision_p2 = mean_round_p1_high + 0.0356692 if period == 2 & high == 1
generate hl_decision_p2 = mean_round_p1_high - 0.0356692 if period == 2 & high == 1

reg decision if high == 1 & period == 3, cluster(session)

generate hh_decision_p3 = mean_round_p1_high + 0.0493137 if period == 3 & high == 1
generate hl_decision_p3 = mean_round_p1_high - 0.0493137 if period == 3 & high == 1

reg decision if high == 1 & period == 4, cluster(session)

generate hh_decision_p4 = mean_round_p1_high + 0.0425842 if period == 4 & high == 1
generate hl_decision_p4 = mean_round_p1_high - 0.0425842 if period == 4 & high == 1

reg decision if high == 1 & period == 5, cluster(session)

generate hh_decision_p5 = mean_round_p1_high + 0.0349853 if period == 5 & high == 1
generate hl_decision_p5 = mean_round_p1_high - 0.0349853 if period == 5 & high == 1

reg decision if high == 1 & period == 6, cluster(session)

generate hh_decision_p6 = mean_round_p1_high + 0.025381 if period == 6 & high == 1
generate hl_decision_p6 = mean_round_p1_high - 0.025381 if period == 6 & high == 1

bys period: egen mean_round_p1_t1  = mean(decision) if treatment == 1 & phase == 1
lab var mean_round_p1_t1 "Low_NoInfo"

bys period: egen mean_round_p1_t2  = mean(decision) if treatment == 2 & phase == 1
lab var mean_round_p1_t2 "Low_Info"

bys period: egen mean_round_p1_t3  = mean(decision) if treatment == 3 & phase == 1
lab var mean_round_p1_t3 "High_NoInfo"

bys period: egen mean_round_p1_t4  = mean(decision) if treatment == 4 & phase == 1
lab var mean_round_p1_t4 "High_Info"

twoway (connected mean_round_p1_low period if period <7, sort msize(small) msymbol(o) mcolor("235 120 50*1") lcolor("235 120 50*1") title("") xtitle("Phase 1 - Round") ytitle("Share Give: Phase 1")) (connected mean_round_p1_high period if period <7, sort msize(small) msymbol(d) mcolor("140 90 180*1") lcolor("140 90 180*1")) ///
(rcap lh_decision_p1 ll_decision_p1 period if period == 1, color("235 120 50*1") lwidth(thin)) ///
(rcap lh_decision_p2 ll_decision_p2 period if period == 2, color("235 120 50*1") lwidth(thin)) ///
(rcap lh_decision_p3 ll_decision_p3 period if period == 3, color("235 120 50*1") lwidth(thin)) ///
(rcap lh_decision_p4 ll_decision_p4 period if period == 4, color("235 120 50*1") lwidth(thin)) ///
(rcap lh_decision_p5 ll_decision_p5 period if period == 5, color("235 120 50*1") lwidth(thin)) ///
(rcap lh_decision_p6 ll_decision_p6 period if period == 6, color("235 120 50*1") lwidth(thin)) ///
(rcap hh_decision_p1 hl_decision_p1 period if period == 1, color("140 90 180*1") lwidth(thin)) ///
(rcap hh_decision_p2 hl_decision_p2 period if period == 2, color("140 90 180*1") lwidth(thin)) ///
(rcap hh_decision_p3 hl_decision_p3 period if period == 3, color("140 90 180*1") lwidth(thin)) ///
(rcap hh_decision_p4 hl_decision_p4 period if period == 4, color("140 90 180*1") lwidth(thin)) ///
(rcap hh_decision_p5 hl_decision_p5 period if period == 5, color("140 90 180*1") lwidth(thin)) ///
(rcap hh_decision_p6 hl_decision_p6 period if period == 6, color("140 90 180*1") lwidth(thin)) ///
, legend(title("") order(1 2) rows(2) stack)  ylabel(0(0.2)1) legend(position(6) row(1) size(medium)) title("(a)")

graph save "${MY_PATH_OUT}Figure_1_Left", replace

********************************************************************************
*Figure 4: Figure Giving by Signal: Low in Phase 1******************************

gen decision_rev = 1 if decision == 0
replace decision_rev = 0 if decision == 1

egen decision_mean_GG_Low = mean(decision) if high == 0 & signal == 1 & (period == 3 | period == 4 | period == 6)
egen decision_mean_KG_Low = mean(decision) if high == 0 & signal == 2 & (period == 3 | period == 4 | period == 6)
egen decision_mean_GK_Low = mean(decision) if high == 0 & signal == 3 & (period == 3 | period == 4 | period == 6)
egen decision_mean_KK_Low = mean(decision) if high == 0 & signal == 4 & (period == 3 | period == 4 | period == 6)

gen decision_mean_low = decision_mean_GG_Low if signal == 1
replace decision_mean_low = decision_mean_KG_Low if signal == 2
replace decision_mean_low = decision_mean_GK_Low if signal == 3
replace decision_mean_low = decision_mean_KK_Low if signal == 4
lab var decision_mean_low "Give"

egen decision_rev_mean_GG_Low = mean(decision_rev) if high == 0 & signal == 1 & (period == 3 | period == 4 | period == 6)
egen decision_rev_mean_KG_Low = mean(decision_rev) if high == 0 & signal == 2 & (period == 3 | period == 4 | period == 6)
egen decision_rev_mean_GK_Low = mean(decision_rev) if high == 0 & signal == 3 & (period == 3 | period == 4 | period == 6)
egen decision_rev_mean_KK_Low = mean(decision_rev) if high == 0 & signal == 4 & (period == 3 | period == 4 | period == 6)

gen decision_rev_mean_low = decision_rev_mean_GG_Low if signal == 1
replace decision_rev_mean_low = decision_rev_mean_KG_Low if signal == 2
replace decision_rev_mean_low = decision_rev_mean_GK_Low if signal == 3
replace decision_rev_mean_low = decision_rev_mean_KK_Low if signal == 4
lab var decision_mean_low "Keep"

graph bar decision_mean_low decision_rev_mean_low, over(signal, label(angle(45) labsize(medium))) bar(1, color("20 170 140")) bar(2, color("230 140 140")) stack bargap(1) legend(position(6) row(1) size(medium) label(1 "Give") label(2 "Keep")) title("Low")

graph save "${MY_PATH_OUT}Phase_1_Low", replace

********************************************************************************
*Figure 4: Figure Giving by Signal: High in Phase 1*****************************

egen decision_mean_GG_High = mean(decision) if high == 1 & signal == 1 & (period == 3 | period == 4 | period == 6)
egen decision_mean_KG_High = mean(decision) if high == 1 & signal == 2 & (period == 3 | period == 4 | period == 6)
egen decision_mean_GK_High = mean(decision) if high == 1 & signal == 3 & (period == 3 | period == 4 | period == 6)
egen decision_mean_KK_High = mean(decision) if high == 1 & signal == 4 & (period == 3 | period == 4 | period == 6)

gen decision_mean_high = decision_mean_GG_High if signal == 1
replace decision_mean_high = decision_mean_KG_High if signal == 2
replace decision_mean_high = decision_mean_GK_High if signal == 3
replace decision_mean_high = decision_mean_KK_High if signal == 4
lab var decision_mean_high "Give"

egen decision_rev_mean_GG_High = mean(decision_rev) if high == 1 & signal == 1 & (period == 3 | period == 4 | period == 6)
egen decision_rev_mean_KG_High = mean(decision_rev) if high == 1 & signal == 2 & (period == 3 | period == 4 | period == 6)
egen decision_rev_mean_GK_High= mean(decision_rev) if high == 1 & signal == 3 & (period == 3 | period == 4 | period == 6)
egen decision_rev_mean_KK_High = mean(decision_rev) if high == 1 & signal == 4 & (period == 3 | period == 4 | period == 6)

gen decision_rev_mean_high = decision_rev_mean_GG_High if signal == 1
replace decision_rev_mean_high= decision_rev_mean_KG_High if signal == 2
replace decision_rev_mean_high = decision_rev_mean_GK_High if signal == 3
replace decision_rev_mean_high = decision_rev_mean_KK_High if signal == 4
lab var decision_rev_mean_high "Keep"

graph bar decision_mean_high decision_rev_mean_high, over(signal, label(angle(45) labsize(medium)))  bar(1, color("20 170 140")) bar(2, color("230 140 140")) stack bargap(1) legend(position(6) row(1) size(medium) label(1 "Give") label(2 "Keep")) title("High")
graph save "${MY_PATH_OUT}Phase_1_High", replace

grc1leg "${MY_PATH_OUT}Phase_1_Low" "${MY_PATH_OUT}Phase_1_High", row(1) title("(b)")
graph save "${MY_PATH_OUT}Figure_1_Right", replace

gr combine "${MY_PATH_OUT}Figure_1_Left" "${MY_PATH_OUT}Figure_1_Right" , row(1)

********************************************************************************
*Table 4: Personal Descriptive Norms Phase 1************************************

tab decision_S1 if phase == 1 & high == 0
tab decision_S2 if phase == 1 & high == 0
tab decision_S3 if phase == 1 & high == 0
tab decision_S4 if phase == 1 & high == 0

tab decision_S1 if phase == 1 & high == 1
tab decision_S2 if phase == 1 & high == 1
tab decision_S3 if phase == 1 & high == 1
tab decision_S4 if phase == 1 & high == 1

tab desc_norm_short_P1 if high == 0

tab desc_norm_short_P1 if high == 1

gen desc_norm_P1_ALLC = 1 if desc_norm_short_P1 == 1 
replace desc_norm_P1_ALLC = 0 if desc_norm_short_P1 != 1 & desc_norm_short_P1 != . 

gen desc_norm_P1_ALLD = 1 if desc_norm_short_P1 == 2
replace desc_norm_P1_ALLD = 0 if desc_norm_short_P1 != 2 & desc_norm_short_P1 != . 

gen desc_norm_P1_IS = 1 if desc_norm_short_P1 == 3
replace desc_norm_P1_IS = 0 if desc_norm_short_P1 != 3 & desc_norm_short_P1 != . 

gen desc_norm_P1_SS = 1 if desc_norm_short_P1 == 4
replace desc_norm_P1_SS = 0 if desc_norm_short_P1 != 4 & desc_norm_short_P1 != . 

gen desc_norm_P1_SJ = 1 if desc_norm_short_P1 == 5
replace desc_norm_P1_SJ = 0 if desc_norm_short_P1 != 5 & desc_norm_short_P1 != . 

gen desc_norm_P1_S = 1 if desc_norm_short_P1 == 6
replace desc_norm_P1_S = 0 if desc_norm_short_P1 != 6 & desc_norm_short_P1 != . 

gen desc_norm_P1_MS = 1 if desc_norm_short_P1 == 7
replace desc_norm_P1_MS = 0 if desc_norm_short_P1 != 7 & desc_norm_short_P1 != . 

gen desc_norm_P1_Oth = 1 if desc_norm_short_P1 == 8
replace desc_norm_P1_Oth = 0 if desc_norm_short_P1 != 8 & desc_norm_short_P1 != . 

probit desc_norm_P1_ALLC i.high, cluster(session)
probit desc_norm_P1_ALLD i.high, cluster(session)
probit desc_norm_P1_IS i.high, cluster(session)
probit desc_norm_P1_SS i.high, cluster(session)
probit desc_norm_P1_SJ i.high, cluster(session)
probit desc_norm_P1_S i.high, cluster(session)
probit desc_norm_P1_MS i.high, cluster(session)
probit desc_norm_P1_Oth i.high, cluster(session)

********************************************************************************
*Table 5: Personal Injunctive Norms*********************************************

tab personal_S1 if high == 0
tab personal_S2 if high == 0
tab personal_S3 if high == 0
tab personal_S4 if high == 0

tab personal_S1 if high == 1
tab personal_S2 if high == 1
tab personal_S3 if high == 1
tab personal_S4 if high == 1

tab personal_norm_short if high == 0

tab personal_norm_short if high == 1

gen personal_norm_ALLC = 1 if personal_norm_short == 1 
replace personal_norm_ALLC = 0 if personal_norm_short != 1 & personal_norm_short != . 

gen personal_norm_ALLD = 1 if personal_norm_short == 2 
replace personal_norm_ALLD = 0 if personal_norm_short != 2 & personal_norm_short != . 

gen personal_norm_IS = 1 if personal_norm_short == 3 
replace personal_norm_IS = 0 if personal_norm_short != 3 & personal_norm_short != . 

gen personal_norm_SS = 1 if personal_norm_short == 4 
replace personal_norm_SS = 0 if personal_norm_short != 4 & personal_norm_short != . 

gen personal_norm_SJ = 1 if personal_norm_short == 5 
replace personal_norm_SJ = 0 if personal_norm_short != 5 & personal_norm_short != .

gen personal_norm_S = 1 if personal_norm_short == 6
replace personal_norm_S = 0 if personal_norm_short != 6 & personal_norm_short != .

gen personal_norm_MS = 1 if personal_norm_short == 7
replace personal_norm_MS = 0 if personal_norm_short != 7 & personal_norm_short != .

gen personal_norm_Oth = 1 if personal_norm_short == 8
replace personal_norm_Oth = 0 if personal_norm_short != 8 & personal_norm_short != .

probit personal_norm_ALLC i.high, cluster(session)
probit personal_norm_ALLD i.high, cluster(session)
probit personal_norm_IS i.high, cluster(session)
probit personal_norm_SS i.high, cluster(session)
probit personal_norm_SJ i.high, cluster(session)
probit personal_norm_S i.high, cluster(session)
probit personal_norm_MS i.high, cluster(session)
probit personal_norm_Oth i.high, cluster(session)

********************************************************************************
*Table 6: Perceived Social Injunctive Norms*************************************

tab social_S1 if high == 0
tab social_S2 if high == 0
tab social_S3 if high == 0
tab social_S4 if high == 0

tab social_S1 if high == 1
tab social_S2 if high == 1
tab social_S3 if high == 1
tab social_S4 if high == 1

tab social_norm_short if high == 0

tab social_norm_short if high == 1

gen social_norm_ALLC = 1 if social_norm_short == 1 
replace social_norm_ALLC = 0 if social_norm_short != 1 & social_norm_short != . 

gen social_norm_ALLD = 1 if social_norm_short == 2 
replace social_norm_ALLD = 0 if social_norm_short != 2 & social_norm_short != . 

gen social_norm_IS = 1 if social_norm_short == 3 
replace social_norm_IS = 0 if social_norm_short != 3 & social_norm_short != . 

gen social_norm_SS = 1 if social_norm_short == 4 
replace social_norm_SS = 0 if social_norm_short != 4 & social_norm_short != . 

gen social_norm_SJ = 1 if social_norm_short == 5 
replace social_norm_SJ = 0 if social_norm_short != 5 & social_norm_short != .

gen social_norm_S = 1 if social_norm_short == 6
replace social_norm_S = 0 if social_norm_short != 6 & social_norm_short != .

gen social_norm_MS = 1 if social_norm_short == 7
replace social_norm_MS = 0 if social_norm_short != 7 & social_norm_short != .

gen social_norm_Oth = 1 if social_norm_short == 8
replace social_norm_Oth = 0 if social_norm_short != 8 & social_norm_short != .

probit social_norm_ALLC i.high, cluster(session)
probit social_norm_ALLD i.high, cluster(session)
probit social_norm_IS i.high, cluster(session)
probit social_norm_SS i.high, cluster(session)
probit social_norm_SJ i.high, cluster(session)
probit social_norm_S i.high, cluster(session)
probit social_norm_MS i.high, cluster(session)
probit social_norm_Oth i.high, cluster(session)

********************************************************************************
*Table 7: Group Norms***********************************************************

tab group_S3 if high == 0
tab group_S4 if high == 0

tab group_S3 if high == 1
tab group_S4 if high == 1

tab group_norm if high == 0
 
tab group_norm if high == 1

gen group_norm_SS = 1 if group_norm == 1 
replace group_norm_SS = 0 if group_norm  != 1 & group_norm  != . 

gen group_norm_ALLD = 1 if group_norm == 2 
replace group_norm_ALLD = 0 if group_norm  != 2 & group_norm  != .

gen group_norm_IS = 1 if group_norm == 3 
replace group_norm_IS = 0 if group_norm  != 3 & group_norm  != .

gen group_norm_SJ = 1 if group_norm == 4 
replace group_norm_SJ = 0 if group_norm  != 4 & group_norm  != .

probit group_norm_SS i.high, cluster(session)
probit group_norm_ALLD i.high, cluster(session)
probit group_norm_IS i.high, cluster(session)
probit group_norm_SJ i.high, cluster(session)

********************************************************************************
*Figure 5: Sankey Diagram Personal and Group Norms******************************

gen personal_group = 1 if personal_S3 == 1 & personal_S4 == 1
replace personal_group = 2 if personal_S3 == 0 & personal_S4 == 0
replace personal_group = 3 if personal_S3 == 1 & personal_S4 == 0
replace personal_group = 4 if personal_S3 == 0 & personal_S4 == 1

lab def personal_group 1 "(1,1)" 2 "(0,0)" 3 "(1,0)" 4 "(0,1)"
lab val personal_group personal_group

bysort overall_id: egen personal_group_max = max(personal_group)
lab val personal_group_max personal_group

sankey overall_id if period == 1 & high == 0, from(personal_group_max) to(group_norm_max) sort1(name, reverse) wrap(7) boxw(15) novalues laba(0) smooth(3) gap(5) labsize(small) title("Low") palette(HSV qualitative) 
graph save "${MY_PATH_OUT}Low", replace

sankey overall_id if period == 1 & high == 1, from(personal_group_max) to(group_norm_max) sort1(name, reverse) wrap(7) boxw(15) novalues laba(0) smooth(3) gap(5) labsize(small) title("High") palette(HSV qualitative) 
graph save "${MY_PATH_OUT}High", replace

gr combine "${MY_PATH_OUT}Low" "${MY_PATH_OUT}High" , imargin(10 10 10 10 10 10) row(1)

********************************************************************************
*Table 8************************************************************************

bys treatment: tab group_norm_maj if id == 1 & period == 9

********************************************************************************
*Figure 6:  Giving Rates Phase 2************************************************

grstyle init
grstyle color background white
grstyle color major_grid dimgray
grstyle linewidth major_grid thin
grstyle yesno draw_major_hgrid no
grstyle yesno draw_major_vgrid yes
grstyle yesno grid_draw_min yes
grstyle yesno grid_draw_max yes
grstyle anglestyle vertical_thick horizontal
grstyle linestyle legend none
grstyle ci_area black
grstyle set size 8pt: subheading axis_title
grstyle set size 8pt: heading
grstyle set size 8pt: tick_label
grstyle set size 8pt: key_label
grstyle set size 8pt: legend

gen ordering = 1 if period == 1
replace ordering = 2 if period == 2
replace ordering = 3 if period == 3
replace ordering = 4 if period == 4
replace ordering = 5 if period == 5
replace ordering = 6 if period == 6
replace ordering = 7 if period == 9
replace ordering = 8 if period == 10
replace ordering = 9 if period == 11
replace ordering = 10 if period == 12
replace ordering = 11 if period == 13
replace ordering = 12 if period == 14

lab def ordering_2 1 "(1)-1" 2 "(1)-1" 3 "(1)-3" 4 "(1)-4" 5 "(1)-5" 6 "(1)-6"
lab val ordering ordering

bys period: egen mean_round_t1  = mean(decision) if treatment == 1
lab var mean_round_t1 "Low_NoInfo"

bys period: egen mean_round_t2  = mean(decision) if treatment == 2
lab var mean_round_t2 "Low_Info"

bys period: egen mean_round_t3  = mean(decision) if treatment == 3
lab var mean_round_t3 "High_NoInfo"

bys period: egen mean_round_t4  = mean(decision) if treatment == 4
lab var mean_round_t4 "High_Info"

reg decision if treatment == 1 & period == 1, cluster(session)

generate lh_decision_p1_t1 = mean_round_t1 + 0.0439026 if period == 1 & treatment == 1
generate ll_decision_p1_t1 = mean_round_t1 - 0.0439026 if period == 1 & treatment == 1

reg decision if treatment == 1 & period == 2, cluster(session)

generate lh_decision_p2_t1 = mean_round_t1 + 0.047619 if period == 2 & treatment == 1
generate ll_decision_p2_t1 = mean_round_t1 - 0.047619 if period == 2 & treatment == 1

reg decision if treatment == 1 & period == 3, cluster(session)

generate lh_decision_p3_t1 = mean_round_t1 + 0.0542941 if period == 3 & treatment == 1
generate ll_decision_p3_t1 = mean_round_t1 - 0.0542941 if period == 3 & treatment == 1

reg decision if treatment == 1 & period == 4, cluster(session)

generate lh_decision_p4_t1 = mean_round_t1 + 0.0502262 if period == 4 & treatment == 1
generate ll_decision_p4_t1 = mean_round_t1 - 0.0502262 if period == 4 & treatment == 1

reg decision if treatment == 1 & period == 5, cluster(session)

generate lh_decision_p5_t1 = mean_round_t1 + 0.0708308 if period == 5 & treatment == 1
generate ll_decision_p5_t1 = mean_round_t1 - 0.0708308 if period == 5 & treatment == 1

reg decision if treatment == 1 & period == 6, cluster(session)

generate lh_decision_p6_t1 = mean_round_t1 + 0.0812669 if period == 6 & treatment == 1
generate ll_decision_p6_t1 = mean_round_t1 - 0.0812669 if period == 6 & treatment == 1

reg decision if treatment == 1 & period == 9, cluster(session)

generate lh_decision_p9_t1 = mean_round_t1 + 0.0803902 if period == 9 & treatment == 1
generate ll_decision_p9_t1 = mean_round_t1 - 0.0803902 if period == 9 & treatment == 1

reg decision if treatment == 1 & period == 10, cluster(session)

generate lh_decision_p10_t1 = mean_round_t1 + 0.0623155 if period == 10 & treatment == 1
generate ll_decision_p10_t1 = mean_round_t1 - 0.0623155 if period == 10 & treatment == 1

reg decision if treatment == 1 & period == 11, cluster(session)

generate lh_decision_p11_t1 = mean_round_t1 + 0.0817884 if period == 11 & treatment == 1
generate ll_decision_p11_t1 = mean_round_t1 - 0.0817884 if period == 11 & treatment == 1

reg decision if treatment == 1 & period == 12, cluster(session)

generate lh_decision_p12_t1 = mean_round_t1 + 0.0897212 if period == 12 & treatment == 1
generate ll_decision_p12_t1 = mean_round_t1 - 0.0897212 if period == 12 & treatment == 1

reg decision if treatment == 1 & period == 13, cluster(session)

generate lh_decision_p13_t1 = mean_round_t1 + 0.1004525 if period == 13 & treatment == 1
generate ll_decision_p13_t1 = mean_round_t1 - 0.1004525 if period == 13 & treatment == 1

reg decision if treatment == 1 & period == 14, cluster(session)

generate lh_decision_p14_t1 = mean_round_t1 + 0.0747255 if period == 14 & treatment == 1
generate ll_decision_p14_t1 = mean_round_t1 - 0.0747255 if period == 14 & treatment == 1

*T2

reg decision if treatment == 2 & period == 1, cluster(session)

generate lh_decision_p1_t2 = mean_round_t2 + 0.0353152 if period == 1 & treatment == 2
generate ll_decision_p1_t2 = mean_round_t2 - 0.0353152 if period == 1 & treatment == 2

reg decision if treatment == 2 & period == 2, cluster(session)

generate lh_decision_p2_t2 = mean_round_t2 + 0.0510657 if period == 2 & treatment == 2
generate ll_decision_p2_t2 = mean_round_t2 - 0.0510657 if period == 2 & treatment == 2

reg decision if treatment == 2 & period == 3, cluster(session)

generate lh_decision_p3_t2 = mean_round_t2 + 0.048795 if period == 3 & treatment == 2
generate ll_decision_p3_t2 = mean_round_t2 - 0.048795 if period == 3 & treatment == 2

reg decision if treatment == 2 & period == 4, cluster(session)

generate lh_decision_p4_t2 = mean_round_t2 + 0.0573409 if period == 4 & treatment == 2
generate ll_decision_p4_t2 = mean_round_t2 - 0.0573409 if period == 4 & treatment == 2

reg decision if treatment == 2 & period == 5, cluster(session)

generate lh_decision_p5_t2 = mean_round_t2 + 0.0412393 if period == 5 & treatment == 2
generate ll_decision_p5_t2 = mean_round_t2 - 0.0412393 if period == 5 & treatment == 2

reg decision if treatment == 2 & period == 6, cluster(session)

generate lh_decision_p6_t2 = mean_round_t2 + 0.0754803 if period == 6 & treatment == 2
generate ll_decision_p6_t2 = mean_round_t2 - 0.0754803 if period == 6 & treatment == 2

reg decision if treatment == 2 & period == 9, cluster(session)

generate lh_decision_p9_t2 = mean_round_t2 + 0.0368856 if period == 9 & treatment == 2
generate ll_decision_p9_t2 = mean_round_t2 - 0.0368856 if period == 9 & treatment == 2

reg decision if treatment == 2 & period == 10, cluster(session)

generate lh_decision_p10_t2 = mean_round_t2 + 0.0243975 if period == 10 & treatment == 2
generate ll_decision_p10_t2 = mean_round_t2 - 0.0243975 if period == 10 & treatment == 2

reg decision if treatment == 2 & period == 11, cluster(session)

generate lh_decision_p11_t2 = mean_round_t2 + 0.0150585 if period == 11 & treatment == 2
generate ll_decision_p11_t2 = mean_round_t2 - 0.0150585 if period == 11 & treatment == 2

reg decision if treatment == 2 & period == 12, cluster(session)

generate lh_decision_p12_t2 = mean_round_t2 + 0.0319438 if period == 12 & treatment == 2
generate ll_decision_p12_t2 = mean_round_t2 - 0.0319438 if period == 12 & treatment == 2

reg decision if treatment == 2 & period == 13, cluster(session)

generate lh_decision_p13_t2 = mean_round_t2 + 0.0467177 if period == 13 & treatment == 2
generate ll_decision_p13_t2 = mean_round_t2 - 0.0467177 if period == 13 & treatment == 2

reg decision if treatment == 2 & period == 14, cluster(session)

generate lh_decision_p14_t2 = mean_round_t2 + 0.0238095 if period == 14 & treatment == 2
generate ll_decision_p14_t2 = mean_round_t2 - 0.0238095 if period == 14 & treatment == 2

*T3

reg decision if treatment == 3 & period == 1, cluster(session)

generate lh_decision_p1_t3 = mean_round_t3 + 0.0565946 if period == 1 & treatment == 3
generate ll_decision_p1_t3 = mean_round_t3 - 0.0565946 if period == 1 & treatment == 3

reg decision if treatment == 3 & period == 2, cluster(session)

generate lh_decision_p2_t3 = mean_round_t3 + 0.0542941 if period == 2 & treatment == 3
generate ll_decision_p2_t3 = mean_round_t3 - 0.0542941 if period == 2 & treatment == 3

reg decision if treatment == 3 & period == 3, cluster(session)

generate lh_decision_p3_t3 = mean_round_t3 + 0.0769678 if period == 3 & treatment == 3
generate ll_decision_p3_t3 = mean_round_t3 - 0.0769678 if period == 3 & treatment == 3

reg decision if treatment == 3 & period == 4, cluster(session)

generate lh_decision_p4_t3 = mean_round_t3 + 0.0760415 if period == 4 & treatment == 3
generate ll_decision_p4_t3 = mean_round_t3 - 0.0760415 if period == 4 & treatment == 3

reg decision if treatment == 3 & period == 5, cluster(session)

generate lh_decision_p5_t3 = mean_round_t3 + 0.0401951 if period == 5 & treatment == 3
generate ll_decision_p5_t3 = mean_round_t3 - 0.0401951 if period == 5 & treatment == 3

reg decision if treatment == 3 & period == 6, cluster(session)

generate lh_decision_p6_t3 = mean_round_t3 + 0.0412393 if period == 6 & treatment == 3
generate ll_decision_p6_t3 = mean_round_t3 - 0.0412393 if period == 6 & treatment == 3

reg decision if treatment == 3 & period == 9, cluster(session)

generate lh_decision_p9_t3 = mean_round_t3 + 0.0301169 if period == 9 & treatment == 3
generate ll_decision_p9_t3 = mean_round_t3 - 0.0301169 if period == 9 & treatment == 3

reg decision if treatment == 3 & period == 10, cluster(session)

generate lh_decision_p10_t3 = mean_round_t3 + 0.0632187 if period == 10 & treatment == 3
generate ll_decision_p10_t3 = mean_round_t3 - 0.0632187 if period == 10 & treatment == 3

reg decision if treatment == 3 & period == 11, cluster(session)

generate lh_decision_p11_t3 = mean_round_t3 + 0.0565946 if period == 11 & treatment == 3
generate ll_decision_p11_t3 = mean_round_t3 - 0.0565946 if period == 11 & treatment == 3

reg decision if treatment == 3 & period == 12, cluster(session)

generate lh_decision_p12_t3 = mean_round_t3 + 0.0935869 if period == 12 & treatment == 3
generate ll_decision_p12_t3 = mean_round_t3 - 0.0935869 if period == 12 & treatment == 3

reg decision if treatment == 3 & period == 13, cluster(session)

generate lh_decision_p13_t3 = mean_round_t3 + 0.0833333 if period == 13 & treatment == 3
generate ll_decision_p13_t3 = mean_round_t3 - 0.0833333 if period == 13 & treatment == 3

reg decision if treatment == 3 & period == 14, cluster(session)

generate lh_decision_p14_t3 = mean_round_t3 + 0.0629941 if period == 14 & treatment == 3
generate ll_decision_p14_t3 = mean_round_t3 - 0.0629941 if period == 14 & treatment == 3


*T4

reg decision if treatment == 4 & period == 1, cluster(session)

generate lh_decision_p1_t4 = mean_round_t4 + 0.0439026 if period == 1 & treatment == 4
generate ll_decision_p1_t4 = mean_round_t4 - 0.0439026 if period == 1 & treatment == 4

reg decision if treatment == 4 & period == 2, cluster(session)

generate lh_decision_p2_t4 = mean_round_t4 + 0.0442242 if period == 2 & treatment == 4
generate ll_decision_p2_t4 = mean_round_t4 - 0.0442242 if period == 2 & treatment == 4

reg decision if treatment == 4 & period == 3, cluster(session)

generate lh_decision_p3_t4 = mean_round_t4 + 0.0681801 if period == 3 & treatment == 4
generate ll_decision_p3_t4 = mean_round_t4 - 0.0681801 if period == 3 & treatment == 4

reg decision if treatment == 4 & period == 4, cluster(session)

generate lh_decision_p4_t4 = mean_round_t4 + 0.0467177 if period == 4 & treatment == 4
generate ll_decision_p4_t4 = mean_round_t4 - 0.0467177 if period == 4 & treatment == 4

reg decision if treatment == 4 & period == 5, cluster(session)

generate lh_decision_p5_t4 = mean_round_t4 + 0.0535053 if period == 5 & treatment == 4
generate ll_decision_p5_t4 = mean_round_t4 - 0.0535053 if period == 5 & treatment == 4

reg decision if treatment == 4 & period == 6, cluster(session)

generate lh_decision_p6_t4 = mean_round_t4 + 0.0301169 if period == 6 & treatment == 4
generate ll_decision_p6_t4 = mean_round_t4 - 0.0301169 if period == 6 & treatment == 4

reg decision if treatment == 4 & period == 9, cluster(session)

generate lh_decision_p9_t4 = mean_round_t4 + 0.039841 if period == 9 & treatment == 4
generate ll_decision_p9_t4 = mean_round_t4 - 0.039841 if period == 9 & treatment == 4

reg decision if treatment == 4 & period == 10, cluster(session)

generate lh_decision_p10_t4 = mean_round_t4 + 0.047619 if period == 10 & treatment == 4
generate ll_decision_p10_t4 = mean_round_t4 - 0.047619 if period == 10 & treatment == 4

reg decision if treatment == 4 & period == 11, cluster(session)

generate lh_decision_p11_t4 = mean_round_t4 + 0.0535053 if period == 11 & treatment == 4
generate ll_decision_p11_t4 = mean_round_t4 - 0.0535053 if period == 11 & treatment == 4

reg decision if treatment == 4 & period == 12, cluster(session)

generate lh_decision_p12_t4 = mean_round_t4 + 0.0502262 if period == 12 & treatment == 4
generate ll_decision_p12_t4 = mean_round_t4 - 0.0502262 if period == 12 & treatment == 4

reg decision if treatment == 4 & period == 13, cluster(session)

generate lh_decision_p13_t4 = mean_round_t4 + 0.0542941 if period == 13 & treatment == 4
generate ll_decision_p13_t4 = mean_round_t4 - 0.0542941 if period == 13 & treatment == 4

reg decision if treatment == 4 & period == 14, cluster(session)

generate lh_decision_p14_t4 = mean_round_t4 + 0.0429232 if period == 14 & treatment == 4
generate ll_decision_p14_t4 = mean_round_t4 - 0.0429232 if period == 14 & treatment == 4

***

twoway (connected mean_round_t1 ordering, sort msize(small) msymbol(o) mcolor("255 140 0") lcolor("255 140 0") title("") xtitle("Phase - Round") ytitle("Share Give")) ///
(connected mean_round_t2 ordering, sort msize(small) msymbol(X) lcolor("204 85 0") mcolor("204 85 0")) ///
(connected mean_round_t3 ordering, sort msize(small) msymbol(D) lcolor("200 160 230") mcolor("200 160 230")) ///
(connected mean_round_t4 ordering, sort msize(small) msymbol(T) lcolor("90 40 120") mcolor("90 40 120")) ///
(rcap lh_decision_p1_t1 ll_decision_p1_t1 ordering if period == 1, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p2_t1 ll_decision_p2_t1 ordering if period == 2, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p3_t1 ll_decision_p3_t1 ordering if period == 3, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p4_t1 ll_decision_p4_t1 ordering if period == 4, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p5_t1 ll_decision_p5_t1 ordering if period == 5, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p6_t1 ll_decision_p6_t1 ordering if period == 6, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p9_t1 ll_decision_p9_t1 ordering if period == 9, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p10_t1 ll_decision_p10_t1 ordering if period == 10, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p11_t1 ll_decision_p11_t1 ordering if period == 11, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p12_t1 ll_decision_p12_t1 ordering if period == 12, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p13_t1 ll_decision_p13_t1 ordering if period == 13, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p14_t1 ll_decision_p14_t1 ordering if period == 14, color("255 140 0") lwidth(thin)) ///
(rcap lh_decision_p1_t2 ll_decision_p1_t2 ordering if period == 1, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p2_t2 ll_decision_p2_t2 ordering if period == 2, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p3_t2 ll_decision_p3_t2 ordering if period == 3, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p4_t2 ll_decision_p4_t2 ordering if period == 4, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p5_t2 ll_decision_p5_t2 ordering if period == 5, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p6_t2 ll_decision_p6_t2 ordering if period == 6, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p9_t2 ll_decision_p9_t2 ordering if period == 9, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p10_t2 ll_decision_p10_t2 ordering if period == 10, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p11_t2 ll_decision_p11_t2 ordering if period == 11, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p12_t2 ll_decision_p12_t2 ordering if period == 12, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p13_t2 ll_decision_p13_t2 ordering if period == 13, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p14_t2 ll_decision_p14_t2 ordering if period == 14, color("204 85 0") lwidth(thin)) ///
(rcap lh_decision_p1_t3 ll_decision_p1_t3 ordering if period == 1, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p2_t3 ll_decision_p2_t3 ordering if period == 2, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p3_t3 ll_decision_p3_t3 ordering if period == 3, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p4_t3 ll_decision_p4_t3 ordering if period == 4, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p5_t3 ll_decision_p5_t3 ordering if period == 5, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p6_t3 ll_decision_p6_t3 ordering if period == 6, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p9_t3 ll_decision_p9_t3 ordering if period == 9, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p10_t3 ll_decision_p10_t3 ordering if period == 10, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p11_t3 ll_decision_p11_t3 ordering if period == 11, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p12_t3 ll_decision_p12_t3 ordering if period == 12, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p13_t3 ll_decision_p13_t3 ordering if period == 13, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p14_t3 ll_decision_p14_t3 ordering if period == 14, color("200 160 230") lwidth(thin)) ///
(rcap lh_decision_p1_t4 ll_decision_p1_t4 ordering if period == 1, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p2_t4 ll_decision_p2_t4 ordering if period == 2, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p3_t4 ll_decision_p3_t4 ordering if period == 3, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p4_t4 ll_decision_p4_t4 ordering if period == 4, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p5_t4 ll_decision_p5_t4 ordering if period == 5, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p6_t4 ll_decision_p6_t4 ordering if period == 6, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p9_t4 ll_decision_p9_t4 ordering if period == 9, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p10_t4 ll_decision_p10_t4 ordering if period == 10, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p11_t4 ll_decision_p11_t4 ordering if period == 11, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p12_t4 ll_decision_p12_t4 ordering if period == 12, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p13_t4 ll_decision_p13_t4 ordering if period == 13, color("90 40 120") lwidth(thin)) ///
(rcap lh_decision_p14_t4 ll_decision_p14_t4 ordering if period == 14, color("90 40 120") lwidth(thin)) ///
, legend(title("") order(1 2 3 4) rows(2) stack)  ylabel(0(0.2)1) xlabel(1 "1-1" 2 "1-2" 3 "1-3" 4 "1-4" 5 "1-5" 6 "1-6" 7 "2-1" 8 "2-2" 9 "2-3" 10 "2-4" 11 "2-5" 12 "2-6") legend(position(6) row(1) size(medium)) xline(6.5, lpattern(solid) lcolor(black) lwidth(vthin))

graph save "${MY_PATH_OUT}Figure_1_Left", replace

********************************************************************************
*Figure 6 In Text: Giving Phase 1 and Phase 2***********************************

probit decision i.phase if treatment == 1, cluster(overall_id)
probit decision i.phase if treatment == 2, cluster(overall_id)
probit decision i.phase if treatment == 3, cluster(overall_id)
probit decision i.phase if treatment == 4, cluster(overall_id)

xtset overall_id period

xtprobit decision i.phase if treatment == 1, re
xtprobit decision i.phase if treatment == 2, re
xtprobit decision i.phase if treatment == 3, re
xtprobit decision i.phase if treatment == 4, re

********************************************************************************
*Figure 6 In Text: Inform effect on Giving**************************************

*Low all Sessions

gen phase_new = 1 if phase == 2
replace phase_new = 0 if phase == 1

lab def phase_new 0 "Phase 1" 1 "Phase 2"
lab val phase_new phase_new

probit decision i.phase_new##i.inform if (treatment == 1 | treatment == 2), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High all Sessions

probit decision i.phase_new##i.inform if (treatment == 3 | treatment == 4), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*Low Session with (1,1)

tab session group_norm_maj if high == 0

probit decision i.phase_new##i.inform if (session == 2 | session == 4 | session == 7 | session == 8 | session == 12 | session == 14 | session == 18 | session == 20 | session == 22), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High Session with (1,1)

tab session group_norm_maj if high == 1

probit decision i.phase_new##i.inform if (session == 9 | session == 17 | session == 19 | session == 21 | session == 23), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

********************************************************************************
*Figure 7: Norm Alignment*******************************************************
*Low S3

probit norm_align_strat_3 i.phase_new##i.inform if high == 0 & (period == 5 | period == 13), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("Low - S3: Give/Keep") ci1opts(color("255 140 0")) plot1opts(lcolor("255 140 0") mcolor("255 140 0") msymbol(D)) ci2opts(color("204 85 0")) plot2opts(lcolor("204 85 0") mcolor("204 85 0") msymbol(O))
graph save "${MY_PATH_OUT}MarginsStrat_1", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High S3

probit norm_align_strat_3 i.phase_new##i.inform if high == 1 & (period == 5 | period == 13), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("High - S3: Give/Keep") ci1opts(color("200 160 230")) plot1opts(lcolor("200 160 230") mcolor("200 160 230") msymbol(D)) ci2opts(color("90 40 120")) plot2opts(lcolor("90 40 120") mcolor("90 40 120") msymbol(O))
graph save "${MY_PATH_OUT}MarginsStrat_2", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

* Low S4

probit norm_align_strat_4 i.phase_new##i.inform if high == 0 & (period == 5 | period == 13), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend(order(1 "NoInfo" 2 "Info")) title("Low - S4: Keep/Keep") ci1opts(color("255 140 0")) plot1opts(lcolor("255 140 0") mcolor("255 140 0") msymbol(D)) ci2opts(color("204 85 0")) plot2opts(lcolor("204 85 0") mcolor("204 85 0") msymbol(O))
graph save "${MY_PATH_OUT}MarginsStrat_3", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High S4

probit norm_align_strat_4 i.phase_new##i.inform if high == 1 & (period == 5 | period == 13), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("High - S4: Keep/Keep") ci1opts(color("200 160 230")) plot1opts(lcolor("200 160 230") mcolor("200 160 230") msymbol(D)) ci2opts(color("90 40 120")) plot2opts(lcolor("90 40 120") mcolor("90 40 120") msymbol(O))
graph save "${MY_PATH_OUT}MarginsStrat_4", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

gr combine "${MY_PATH_OUT}MarginsStrat_1" "${MY_PATH_OUT}MarginsStrat_2" "${MY_PATH_OUT}MarginsStrat_3" "${MY_PATH_OUT}MarginsStrat_4", xcommon ycommon

********************************************************************************
*In Text: Norm Alignment********************************************************

*Low S3

probit norm_align_3 i.phase_new##i.inform if high == 0, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High S3

probit norm_align_3 i.phase_new##i.inform if high == 1, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

* Low S4

probit norm_align_4 i.phase_new##i.inform if high == 0, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High S4

probit norm_align_4 i.phase_new##i.inform if high == 1, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

********************************************************************************
*APPENDIX***********************************************************************
********************************************************************************
*Table A1: Overview Sample******************************************************

tab experiments, gen(experiments_)
tab gender, gen(gender_)

sum gender_1 gender_2 gender_3 gender_4 age game_theory experiments_1 experiments_2 experiments_3 experiments_4 forgiveness pos_rec neg_rec diff if period == 1
sum gender_1 gender_2 gender_3 gender_4 age game_theory experiments_1 experiments_2 experiments_3 experiments_4 forgiveness pos_rec neg_rec diff if period == 1 & treatment == 1
sum gender_1 gender_2 gender_3 gender_4 age game_theory experiments_1 experiments_2 experiments_3 experiments_4 forgiveness pos_rec neg_rec diff if period == 1 & treatment == 2
sum gender_1 gender_2 gender_3 gender_4 age game_theory experiments_1 experiments_2 experiments_3 experiments_4 forgiveness pos_rec neg_rec diff if period == 1 & treatment == 3
sum gender_1 gender_2 gender_3 gender_4 age game_theory experiments_1 experiments_2 experiments_3 experiments_4 forgiveness pos_rec neg_rec diff if period == 1 & treatment == 4

tab gender_1 treatment if period == 1, chi2
tab gender_2 treatment if period == 1, chi2
tab gender_3 treatment if period == 1, chi2
tab gender_4 treatment if period == 1, chi2

kwallis age if period == 1, by(treatment)
tab game_theory treatment if period == 1, chi2

tab experiments_1 treatment if period == 1, chi2
tab experiments_2 treatment if period == 1, chi2
tab experiments_3 treatment if period == 1, chi2
tab experiments_4 treatment if period == 1, chi2

kwallis forgiveness if period == 1, by(treatment)
kwallis pos_rec if period == 1, by(treatment)
kwallis neg_rec if period == 1, by(treatment)
kwallis diff if period == 1, by(treatment)

********************************************************************************
*Table A3: Giving Rate: Phase 1*************************************************

tab decision if high == 0 & period == 1
tab decision if high == 1 & period == 1

tab decision if high == 0 & period == 2 & signal_2 == 1
tab decision if high == 0 & period == 2 & signal_2 == 0
tab decision if high == 0 & period == 2

tab decision if high == 1 & period == 2 & signal_2 == 1
tab decision if high == 1 & period == 2 & signal_2 == 0
tab decision if high == 1 & period == 2 

tab decision if high == 0 & signal == 1 & (period == 3 | period == 4 | period == 6)
tab decision if high == 0 & signal == 2 & (period == 3 | period == 4 | period == 6)
tab decision if high == 0 & signal == 3 & (period == 3 | period == 4 | period == 6)
tab decision if high == 0 & signal == 4 & (period == 3 | period == 4 | period == 6)
tab decision if high == 0 & (period == 3 | period == 4 | period == 6)

tab decision if high == 1 & signal == 1 & (period == 3 | period == 4 | period == 6)
tab decision if high == 1 & signal == 2 & (period == 3 | period == 4 | period == 6)
tab decision if high == 1 & signal == 3 & (period == 3 | period == 4 | period == 6)
tab decision if high == 1 & signal == 4 & (period == 3 | period == 4 | period == 6)
tab decision if high == 1 & (period == 3 | period == 4 | period == 6)

tab decision_S1 if phase == 1 & high == 0
tab decision_S2 if phase == 1 & high == 0
tab decision_S3 if phase == 1 & high == 0
tab decision_S4 if phase == 1 & high == 0

tab decision_S1 if phase == 1 & high == 1
tab decision_S2 if phase == 1 & high == 1
tab decision_S3 if phase == 1 & high == 1
tab decision_S4 if phase == 1 & high == 1

tab decision if phase == 1 & period == 5 & high == 0
tab decision if phase == 1 & period == 5 & high == 1

tab decision if phase == 1 & high == 0
tab decision if phase == 1 & high == 1

********************************************************************************
*Table A4: Person Descriptive Norms Phase 1*************************************

tab desc_norm_long_P1 if high == 0

tab desc_norm_long_P1 if high == 1

********************************************************************************
*Table A5/A6: Personal Injunctive Norms********************************************

tab personal_norm_long if high == 0

tab personal_norm_long if high == 1

mlogit personal_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(1)) post 
est sto r1

mlogit personal_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(2)) post 
est sto r2

mlogit personal_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(3)) post
est sto r3
 
mlogit personal_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(4)) post 
est sto r4

mlogit personal_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(5)) post 
est sto r5

mlogit personal_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(6)) post 
est sto r6

esttab r1 r2 r3 r4 r5 r6 using Table_Multi_1.rtf, varwidth(12) cells(b(star fmt(4)) se(par fmt(4))) stats(N, fmt(0 4 4)) starlevel(* 0.10 ** 0.05 *** 0.01) legend nobase style(fixed) nocons replace 

********************************************************************************
*Table A7/A8: Social Injunctive Norms**********************************************

tab social_norm_long if high == 0

tab social_norm_long if high == 1

mlogit social_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(1)) post 
est sto r1

mlogit social_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(2)) post 
est sto r2

mlogit social_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(3)) post
est sto r3
 
mlogit social_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(4)) post 
est sto r4

mlogit social_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(5)) post 
est sto r5

mlogit social_norm_short2 i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(6)) post 
est sto r6

esttab r1 r2 r3 r4 r5 r6 using Table_Multi_2.rtf, varwidth(12) cells(b(star fmt(4)) se(par fmt(4))) stats(N, fmt(0 4 4)) starlevel(* 0.10 ** 0.05 *** 0.01) legend nobase style(fixed) nocons replace 

********************************************************************************
*Table A9: Group Norms**********************************************************

mlogit group_norm i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(1)) post 
est sto r1

mlogit group_norm i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(2)) post 
est sto r2

mlogit group_norm i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(3)) post
est sto r3
 
mlogit group_norm i.high i.female c.age i.game_theory i.experiments c.forgiveness c.pos_rec c.neg_rec, cluster(session) base(3)
margins, dydx(*) atmeans predict(outcome(4)) post 
est sto r4

esttab r1 r2 r3 r4 using Table_Multi_3.rtf, varwidth(12) cells(b(star fmt(4)) se(par fmt(4))) stats(N, fmt(0 4 4)) starlevel(* 0.10 ** 0.05 *** 0.01) legend nobase style(fixed) nocons replace 

********************************************************************************
*Table A10: Giving Rate Phase 2**************************************************

tab decision if treatment == 1 & period == 9
tab decision if treatment == 2 & period == 9
tab decision if treatment == 3 & period == 9
tab decision if treatment == 4 & period == 9

tab decision if treatment == 1 & period == 10 & signal_2 == 1
tab decision if treatment == 1 & period == 10 & signal_2 == 0
tab decision if treatment == 1 & period == 10 

tab decision if treatment == 2 & period == 10 & signal_2 == 1
tab decision if treatment == 2 & period == 10 & signal_2 == 0
tab decision if treatment == 2 & period == 10 

tab decision if treatment == 3 & period == 10 & signal_2 == 1
tab decision if treatment == 3 & period == 10 & signal_2 == 0
tab decision if treatment == 3 & period == 10 

tab decision if treatment == 4 & period == 10 & signal_2 == 1
tab decision if treatment == 4 & period == 10 & signal_2 == 0
tab decision if treatment == 4 & period == 10 

tab decision if treatment == 1 & signal == 1 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 1 & signal == 2 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 1 & signal == 3 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 1 & signal == 4 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 1 & (period == 11 | period == 12 | period == 14)

tab decision if treatment == 2 & signal == 1 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 2 & signal == 2 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 2 & signal == 3 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 2 & signal == 4 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 2 & (period == 11 | period == 12 | period == 14)

tab decision if treatment == 3 & signal == 1 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 3 & signal == 2 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 3 & signal == 3 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 3 & signal == 4 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 3 & (period == 11 | period == 12 | period == 14)

tab decision if treatment == 4 & signal == 1 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 4 & signal == 2 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 4 & signal == 3 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 4 & signal == 4 & (period == 11 | period == 12 | period == 14)
tab decision if treatment == 4 & (period == 11 | period == 12 | period == 14)

tab decision_S1 if phase == 1 & treatment == 1
tab decision_S2 if phase == 1 & treatment == 1
tab decision_S3 if phase == 1 & treatment == 1
tab decision_S4 if phase == 1 & treatment == 1
tab decision if period == 13 & treatment == 1

tab decision_S1 if phase == 1 & treatment == 2
tab decision_S2 if phase == 1 & treatment == 2
tab decision_S3 if phase == 1 & treatment == 2
tab decision_S4 if phase == 1 & treatment == 2
tab decision if period == 13 & treatment == 2

tab decision_S1 if phase == 1 & treatment == 3
tab decision_S2 if phase == 1 & treatment == 3
tab decision_S3 if phase == 1 & treatment == 3
tab decision_S4 if phase == 1 & treatment == 3
tab decision if period == 13 & treatment == 3

tab decision_S1 if phase == 1 & treatment == 4
tab decision_S2 if phase == 1 & treatment == 4
tab decision_S3 if phase == 1 & treatment == 4
tab decision_S4 if phase == 1 & treatment == 4
tab decision if period == 13 & treatment == 4

tab decision if phase == 2 & treatment == 1
tab decision if phase == 2 & treatment == 2
tab decision if phase == 2 & treatment == 3
tab decision if phase == 2 & treatment == 4

********************************************************************************
*Table A11: Personal Descriptive Norms Phase 2**********************************

tab desc_norm_long_P2 if treatment == 1

tab desc_norm_long_P2 if treatment == 2

tab desc_norm_long_P2 if treatment == 3

tab desc_norm_long_P2 if treatment == 4

********************************************************************************
*Figure A2 Info on Giving*******************************************************

*Low all Sessions

probit decision i.phase_new##i.inform if (treatment == 1 | treatment == 2), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Give)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("Low - Norm: all") ci1opts(color("255 140 0")) plot1opts(lcolor("255 140 0") mcolor("255 140 0") msymbol(D)) ci2opts(color("204 85 0")) plot2opts(lcolor("204 85 0") mcolor("204 85 0") msymbol(O))
graph save "${MY_PATH_OUT}Margins_1", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High all Sessions

probit decision i.phase_new##i.inform if (treatment == 3 | treatment == 4), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Give)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("High - Norm: all") ci1opts(color("200 160 230")) plot1opts(lcolor("200 160 230") mcolor("200 160 230") msymbol(D)) ci2opts(color("90 40 120")) plot2opts(lcolor("90 40 120") mcolor("90 40 120") msymbol(O))
graph save "${MY_PATH_OUT}Margins_2", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*Low Session with (1,1)

tab session group_norm_maj if high == 0

probit decision i.phase_new##i.inform if (session == 2 | session == 4 | session == 7 | session == 8 | session == 12 | session == 14 | session == 18 | session == 20 | session == 22), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Give)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("Low - Norm: (1,1)") ci1opts(color("255 140 0")) plot1opts(lcolor("255 140 0") mcolor("255 140 0") msymbol(D)) ci2opts(color("204 85 0")) plot2opts(lcolor("204 85 0") mcolor("204 85 0") msymbol(O))
graph save "${MY_PATH_OUT}Margins_3", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High Session with (1,1)

tab session group_norm_maj if high == 1

probit decision i.phase_new##i.inform if (session == 9 | session == 17 | session == 19 | session == 21 | session == 23), cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Give)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("High - Norm: (1,0)")  ci1opts(color("200 160 230")) plot1opts(lcolor("200 160 230") mcolor("200 160 230") msymbol(D)) ci2opts(color("90 40 120")) plot2opts(lcolor("90 40 120") mcolor("90 40 120") msymbol(O))
graph save "${MY_PATH_OUT}Margins_4", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

gr combine "${MY_PATH_OUT}Margins_1" "${MY_PATH_OUT}Margins_2" "${MY_PATH_OUT}Margins_3" "${MY_PATH_OUT}Margins_4", xcommon ycommon

********************************************************************************
*Figure A3: Information Effect on Alignment*************************************

*Low S3

probit norm_align_3 i.phase_new##i.inform if high == 0, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("Low - S3: Give/Keep") ci1opts(color("255 140 0")) plot1opts(lcolor("255 140 0") mcolor("255 140 0") msymbol(D)) ci2opts(color("204 85 0")) plot2opts(lcolor("204 85 0") mcolor("204 85 0") msymbol(O))
graph save "${MY_PATH_OUT}MarginsD_1", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High S3

probit norm_align_3 i.phase_new##i.inform if high == 1, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("High - S3: Give/Keep") ci1opts(color("200 160 230")) plot1opts(lcolor("200 160 230") mcolor("200 160 230") msymbol(D)) ci2opts(color("90 40 120")) plot2opts(lcolor("90 40 120") mcolor("90 40 120") msymbol(O))
graph save "${MY_PATH_OUT}MarginsD_2", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

* Low S4

probit norm_align_4 i.phase_new##i.inform if high == 0, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("Low - S4: Keep/Keep") ci1opts(color("255 140 0")) plot1opts(lcolor("255 140 0") mcolor("255 140 0") msymbol(D)) ci2opts(color("204 85 0")) plot2opts(lcolor("204 85 0") mcolor("204 85 0") msymbol(O))
graph save "${MY_PATH_OUT}MarginsD_3", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

*High S4

probit norm_align_4 i.phase_new##i.inform if high == 1, cluster(overall_id)

margins, at(phase_new=(0 1) inform=(0 1) ) atmeans post

marginsplot, ytitle("Pr(Alignment)") ylab(.2(.2)1) xtitle("") title("") legend(position(6) cols(2)) legend (order(1 "NoInfo" 2 "Info")) title("High- S4: Keep/Keep")  ci1opts(color("200 160 230")) plot1opts(lcolor("200 160 230") mcolor("200 160 230") msymbol(D)) ci2opts(color("90 40 120")) plot2opts(lcolor("90 40 120") mcolor("90 40 120") msymbol(O))
graph save "${MY_PATH_OUT}MarginsD_4", replace

mlincom 3 - 1, stat(all) 
mlincom 4 - 2, stat(all) 
mlincom (1 - 2) - (3 - 4), stat(all) 

gr combine "${MY_PATH_OUT}MarginsD_1" "${MY_PATH_OUT}MarginsD_2" "${MY_PATH_OUT}MarginsD_3" "${MY_PATH_OUT}MarginsD_4", xcommon ycommon

********************************************************************************
********************************************************************************



















