
cd ..
clear all

use agg_2016_slant.dta, clear

gen day = date
replace day = day-20766
keep if day>=-104
gen top = (data_c=="2016top10")

gen headl_lower = lower(headline)

gen lead = regexm(headl_lower, "lead")
gen tied = regexm(headl_lower, "tied")
gen poll = regexm(headl_lower, "poll")
gen momentum = regexm(headl_lower, "momentum")
gen bounce = regexm(headl_lower, "bounce")
gen bump = regexm(headl_lower, "bump")
gen win = regexm(headl_lower, "win")
gen win2 = regexm(headl_lower, " win ")
gen gallup = regexm(headl_l, "gallup")
gen leader = regexm(headl_lower, "leader")
gen winning = regexm(headl_lower, "winning")

gen key3 = (lead==1|tied==1|poll==1|momentum==1|bounce==1|bump==1|win2==1|gall==1|winning==1) 
replace key3 = 0 if (leader==1 & (tied==0&poll==0&momentum==0&bounce==0&bump==0&win2==0&gall==0&winning==0))

keep if key3==1

bysort src repeatid date: egen tm = max(top)
bysort src headline date: egen tm2 = max(top)

replace tm = tm2 if repeatid==.

gen d = day(date)

gen month = month(date)

drop _m
drop poll

merge m:1 month d using "polls.dta"

twoway (lpolyci davgslant2 day , title(Slant 1) yscale(range(-1 1)) graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(s1))
twoway (lpolyci davgslant1b day , title(Slant 2) yscale(range(-1 1)) graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(s2))
twoway (lpolyci davgslant3 day , title(Slant 3) yscale(range(-1 1)) graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(s3))
twoway (lpolyci poll day , title(Polls (% Republican - % Democrat)) graphregion(color(white))    yscale(range(-1 1))  ylabel(#3) legend(off) xtitle("day") name(p))

graph combine s1 s2 s3 p, cols(2) graphregion(color(white)) 
