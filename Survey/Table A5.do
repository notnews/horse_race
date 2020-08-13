
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

*bysort workerid2: egen widobs = count(HR)
gen HC = candidatech=="Hillary Clinton"
gen DT = candidatech=="Donald Trump"

*for sum stats:
replace partyi = "Ind (lean Rep)" if partyi=="Independent (lean towards Republican)"
encode educ, gen(educ2)
replace educ2 = 0 if educ2==6
replace educ2 = 0.5 if educ2==3
replace educ2 = 0.6 if educ2==4

xi, noomit: sum i.partyi i.candidatech i.educ2 i.gender i.age

