
cd ..
use agg_2012_slant.dta, clear

gen day = date
replace day = day-20766+1463
keep if day>=-104
gen top = (data_c=="2012top10")

*create opinion dummy (1 if has the word opinion or name of opinion writer in headline; 0 otherwise)
*and 'priority' keyword dummy (key)
gen headl_lower = lower(headline)
gen opinion = 0
gen schoen = 0
gen goodwin = 0
gen rove = 0
gen strassel = 0
gen power_play = 0
gen juan_williams = 0
gen bias_alert = 0
gen gainor = 0
gen reich = 0
gen fivethirtyeight = 0
gen douthat = 0
gen dan_rather = 0
replace opinion = regexm(headl_lower, "opinion")
replace schoen = regexm(headl_lower, "schoen")
replace goodwin = regexm(headl_lower, "goodwin")
replace rove = regexm(headl_lower, "rove")
replace strassel = regexm(headl_lower, "strassel")
replace power_play = regexm(headl_lower, "power play")
replace juan_williams = regexm(headl_lower, "juan williams")
replace bias_alert = regexm(headl_lower, "bias alert")
replace gainor = regexm(headl_lower, "gainor")
replace reich = regexm(headl_lower, "reich")
replace fivethirtyeight = regexm(headl_lower, "fivethirtyeight")
replace douthat = regexm(headl_lower, "douthat")
replace dan_rather = regexm(headl_lower, "dan rather")
replace opinion = 1 if opinion == 1 | schoen == 1 | goodwin == 1 | rove == 1 | ///
 strassel == 1 | power_play == 1 | juan_williams == 1 | bias_alert == 1 | ///
 gainor == 1 | reich == 1 |  douthat == 1 | dan_rather == 1
* fivethirtyeight == 1 | ///
 
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

keep if opinion~=1 & key3==1

replace src = "fox" if src=="fox_politics"

bysort src repeatid date: egen tm = max(top)
bysort src headline date: egen tm2 = max(top)

replace tm = tm2 if repeatid==.

twoway (lpolyci davgslant2 day if src=="usat"&tm==1, title(USAToday Most Viewed) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white))  ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ut))
twoway (lpolyci davgslant2 day if src=="usat"&tm==0, title(USAToday Other) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(u))

twoway (lpolyci davgslant2 day if src=="nyt"&tm==1, title(NYT Most Viewed) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(nt))
twoway (lpolyci davgslant2 day if src=="nyt"&tm==0, title(NYT Other) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ny))

twoway (lpolyci davgslant2 day if src=="hpmg"&tm==1, title(HuffPost Most Viewed) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ht))
twoway (lpolyci davgslant2 day if src=="hpmg"&tm==0, title(HuffPost Other) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(h))

twoway (lpolyci davgslant2 day if src=="fox"&tm==1, title(FoxNews Most Viewed) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ft))
twoway (lpolyci davgslant2 day if src=="fox"&tm==0, title(FoxNews Other) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(f))

twoway (lpolyci davgslant2 day if src=="wsj"&tm==1, title(WSJ Most Viewed) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(wst))
twoway (lpolyci davgslant2 day if src=="wsj"&tm==0, title(WSJ Other) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(ws))


twoway (lpolyci davgslant2 day if src=="yahoo"&tm==1, title(YahooNews Most Viewed) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(yt))
twoway (lpolyci davgslant2 day if src=="yahoo"&tm==0, title(YahooNews Other) yscale(range(-1 1)) xscale(range(-105 0)) graphregion(color(white)) ylabel(#3) ylabel(-1 0 1)  legend(off) xtitle("day") name(y))

graph combine f ft ws wst  y yt u ut ny nt  h ht, cols(4) graphregion(color(white))

