
clear
use survey1results.dta
gen politicalinterest = "filler"
append using survey2results.dta
append using survey3results.dta

replace survey1=0 if survey1 != 1
replace survey2=0 if survey2 != 1
replace survey3=0 if survey3 != 1

replace correctAnswer1=0 if correctAnswer1!=1
replace correctAnswer2=0 if correctAnswer2!=1
replace correctAnswer3=0 if correctAnswer3!=1


bysort workerid: egen ctHR = count(HR)
gen repeat = (ctHR>1)
gen workerid2 = workerid if repeat==1
replace workerid2 = "no repeat" if repeat != 1

gen correctanswer = correctAnswer1 + correctAnswer2 + correctAnswer3
gen rTotalCong = totalCong*R
gen dTotalCong = totalCong*D
gen rCong = cong*R
gen rUncong = uncong*R
gen dCong = cong*D
gen dUncong = uncong*D

gen rCandidateCong = candidateCong*R
gen dCandidateCong = candidateCong*D
*regressions*
keep if correctanswer>0

gen cand=(candidatech ~= "Not voting/other")

egen pid = group(partyid)

*strong party identifier
gen strong = (pid==1|pid==6)

*'other' party identifier
gen other = (pid==5)

*'other' is fishy - either partisans who don't admit it or not interested in politics at all
drop if other==1


gen OtherNews = 1-NYT-Fox


gen survey = 1
replace survey = 2 if survey2==1
replace survey = 3 if survey3==1


gen pcong = 0
replace pcong = 1 if D2==1 & survey==1
replace pcong = 1 if R2==1 & survey>1

gen puncong = 0
replace puncong = 1 if D2==1 & survey>1
replace puncong = 1 if R2==1 & survey==1
    
replace puncong = 0 if D2==1 & survey==3 & NYT==1

    
gen pid2 = -1 if D2==1

replace pid2= 1 if R2==1

replace pid2 = 0 if pid2==.

gen party  = "Democrats (N=346)" if pid2==-1
replace party = "Independent (N=115)" if pid2==0
replace party = "Republicans (N=177)" if pid2==1


bysort workerid2: egen widobs = count(HR)

gen HC = candidatech=="Hillary Clinton"
gen DT = candidatech=="Donald Trump"

*get news from 'favorite' outlet
gen fav = 1 if D2==1&NYT==1
replace fav = 1 if R2==1 & Fox==1
replace fav = 0 if fav==.


*favorite outlet congeniality
gen favcong = 1 if survey==1 & D2==1
replace favcong =  -1 if survey==2 & D2==1
replace favcong = 1 if survey>=2 & R2==1
replace favcong =  -1 if survey==1 & R2==1
replace favcong = 0 if favcong == .

*favorite outlet congeniality + uncong
gen fc=0
replace fc = 1 if survey==1 & D2==1
replace fc = 1 if survey>=2 & R2==1

gen fuc = 0
replace fuc =  -1 if survey==2 & D2==1
replace fuc =  -1 if survey==1 & R2==1



*get news from 'non-favorite' outlet
gen nonfav = 1 if D2==1&Fox==1
replace nonfav = 1 if R2==1 & NYT==1
replace nonfav = 0 if nonfav==.

*non-favorite outlet congeniality
gen nfavcong = 1 if survey==1 & D2==1
replace nfavcong =  -1 if survey>=2 & D2==1
replace nfavcong = 1 if survey==2 & R2==1
replace nfavcong =  -1 if survey==1 & R2==1
replace nfavcong = 0 if nfavcong == .


gen nfc = 0
replace nfc = 1 if survey==1 & D2==1
replace nfc = 1 if survey==2 & R2==1
replace nfc = 0 if nfavcong == .

gen nfuc=0
replace nfuc =  -1 if survey>=2 & D2==1
replace nfuc =  -1 if survey==1 & R2==1

collapse (mean) mean_NYT=NYT mean_OtherNews=OtherNews mean_Fox=Fox ///
 (sd) sd_NYT=NYT sd_OtherNews=OtherNews sd_Fox=Fox ///
 (count) n_NYT=NYT n_OtherNews=OtherNews n_Fox=Fox, by(party survey)
 
generate hi_NYT = mean_NYT + invttail(n_NYT-1,0.025)*(sd_NYT / sqrt(n_NYT))
generate lo_NYT = mean_NYT - invttail(n_NYT-1,0.025)*(sd_NYT / sqrt(n_NYT))

generate hi_OtherNews = mean_OtherNews + invttail(n_OtherNews-1,0.025)*(sd_OtherNews / sqrt(n_OtherNews))
generate lo_OtherNews = mean_OtherNews - invttail(n_OtherNews-1,0.025)*(sd_OtherNews / sqrt(n_OtherNews))

generate hi_Fox = mean_Fox + invttail(n_Fox-1,0.025)*(sd_Fox / sqrt(n_Fox))
generate lo_Fox = mean_Fox - invttail(n_Fox-1,0.025)*(sd_Fox / sqrt(n_Fox))

egen partysurvey = group(party survey)

reshape long mean_ hi_ lo_, i(partysurvey) j(outlet) string

replace  partysurvey = partysurvey+11 if party == "Independent (N=115)"
replace  partysurvey = partysurvey+22 if party == "Republicans (N=177)"

replace  partysurvey = partysurvey+3  if survey == 2
replace  partysurvey = partysurvey+6  if survey == 3

replace  partysurvey = partysurvey+1  if outlet == "OtherNews"
replace  partysurvey = partysurvey+2  if outlet == "Fox"

twoway ///
 (bar mean partysurvey if survey == 1 & outlet == "NYT", fcolor(blue)) ///
 (bar mean partysurvey if survey == 1 & outlet == "OtherNews", fcolor(gs12)) ///
 (bar mean partysurvey if survey == 1 & outlet == "Fox", fcolor(red)) ///
 (bar mean partysurvey if survey == 2 & outlet == "NYT", fcolor(blue)) ///
 (bar mean partysurvey if survey == 2 & outlet == "OtherNews", fcolor(gs12)) ///
 (bar mean partysurvey if survey == 2 & outlet == "Fox", fcolor(red)) ///
 (bar mean partysurvey if survey == 3 & outlet == "NYT", fcolor(blue)) ///
 (bar mean partysurvey if survey == 3 & outlet == "OtherNews", fcolor(gs12)) ///
 (bar mean partysurvey if survey == 3 & outlet == "Fox", fcolor(red)) ///
 (rcap hi_ lo_ partysurvey), ///
 legend(order(1 "NYT" 2 "Other News" 3 "Fox") rows(1)) ytitle(" ") xtitle(" ") ///
 xlabel(2 `""Debate 1" "(congenial)""' 6 `""Debate 2" "(uncong.)""' 10 `""Debate 3" "(ambiguous)""' 16 "Debate 1" 20 "Debate 2" 24 "Debate 3" 30 `""Debate 1" "(uncong.)""' 34 `""Debate 2" "(congenial)""' 38 `""Debate 3" "(congenial)""', labsize(vsmall) noticks) ///
 plotregion(margin(zero))  ylabel(0(0.2)1) ytitle("%") ///
 text(1.03 6 "Democrats", box just(center) width(33) bcolor(none)) ///
 text(1.03 20 "Independents", box just(center) width(33) bcolor(none)) ///
 text(1.03 34 "Republicans", box just(center) width(33) bcolor(none)) ///
 graphregion(margin(medlarge)) graphregion(color(white))
 
