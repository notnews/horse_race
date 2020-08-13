
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

gen key = (lead==1|tied==1|poll==1|momentum==1|bounce==1|bump==1|win==1|gall==1) 
replace key = 0 if (leader==1 & (tied==0&poll==0&momentum==0&bounce==0&bump==0&win==0&gall==0))

gen key2 = (lead==1|tied==1|poll==1|momentum==1|bounce==1|bump==1|win2==1|gall==1) 
replace key2 = 0 if (leader==1 & (tied==0&poll==0&momentum==0&bounce==0&bump==0&win2==0&gall==0))

gen key3 = (lead==1|tied==1|poll==1|momentum==1|bounce==1|bump==1|win2==1|gall==1|winning==1) 
replace key3 = 0 if (leader==1 & (tied==0&poll==0&momentum==0&bounce==0&bump==0&win2==0&gall==0&winning==0))

keep if key3==1

bysort src repeatid date: egen tm = max(top)
bysort src headline date: egen tm2 = max(top)

replace tm = tm2 if repeatid==.

twoway (lpolyci davgslant2 day if src=="wapo"&tm==1, title(WaPo Most Viewed) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(wt))
twoway (lpolyci davgslant2 day if src=="wapo"&tm==0, title(WaPo Other) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(w))

twoway (lpolyci davgslant2 day if src=="nyt"&tm==1, title(NYT Most Viewed) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(nt))
twoway (lpolyci davgslant2 day if src=="nyt"&tm==0, title(NYT Other) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ny))

twoway (lpolyci davgslant2 day if src=="hpmg"&tm==1, title(HuffPost Most Viewed) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ht))
twoway (lpolyci davgslant2 day if src=="hpmg"&tm==0, title(HuffPost Other) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(h))

twoway (lpolyci davgslant2 day if src=="fox"&tm==1, title(FoxNews Most Viewed) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ft))
twoway (lpolyci davgslant2 day if src=="fox"&tm==0, title(FoxNews Other) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(f))

twoway (lpolyci davgslant2 day if src=="wsj"&tm==1, title(WSJ Most Viewed) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(wst))
twoway (lpolyci davgslant2 day if src=="wsj"&tm==0, title(WSJ Other) yscale(range(-1 1)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ws))

twoway (lpolyci davgslant2 day if src=="google"&tm==1, title(GoogleNews Most Viewed) graphregion(color(white)) yscale(range(-1 1)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(gt))
twoway (lpolyci davgslant2 day if src=="google"&tm==0, title(GoogleNews Other) graphregion(color(white)) yscale(range(-1 1)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(g))

twoway (lpolyci davgslant2 day if src=="yahoo"&tm==1, title(Yahoo Most Viewed) graphregion(color(white)) yscale(range(-1 1)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(yt))
twoway (lpolyci davgslant2 day if src=="yahoo"&tm==0, title(Yahoo Other) graphregion(color(white)) yscale(range(-1 1)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(y))

graph combine f ft ws wst g gt y yt ny nt w wt , cols(4) graphregion(color(white))
