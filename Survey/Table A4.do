
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

gen survey = 1
replace survey = 2 if survey2==1
replace survey = 3 if survey3==1

gen HC = candidatech=="Hillary Clinton"
gen DT = candidatech=="Donald Trump"

eststo clear

eststo: qui xi: reg NYT i.survey*D2 i.survey*R2 i.educ i.gender i.age    i.partyid   , r
est store a
eststo: qui xi: reg Fox i.survey*D2 i.survey*R2 i.educ i.gender i.age    i.partyid    , r
est store b
eststo: qui xi: reg HR i.survey*D2 i.survey*R2 i.educ i.gender i.age    i.partyid    , r
est store c

estout a b c  , keep (   _IsurXD2_2 _IsurXD2_3 _IsurXR2_2 _IsurXR2_3 ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)

replace D2 = HC
replace R2 = DT

eststo: qui xi: reg NYT i.survey*D2 i.survey*R2 i.educ i.gender i.age  i.partyid      , r 
est store d
eststo: qui xi: reg Fox i.survey*D2 i.survey*R2 i.educ i.gender i.age  i.partyid    , r
est store e
eststo: qui xi: reg HR i.survey*D2 i.survey*R2 i.educ i.gender i.age  i.partyid    , r
est store f

estout d e f , keep (   _IsurXD2_2 _IsurXD2_3 _IsurXR2_2 _IsurXR2_3 ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)

