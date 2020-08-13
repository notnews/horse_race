
cd ..
use "days2016.dta", clear

collapse (sum) slsum=Slant1 (count) ct=Slant1 , by(src date)

gen sl = slsum/ct

encode src, gen(src_num)
tsset src_num date
tsfill, full

gen month = month(date)
gen d = day(date)
drop if month==7 & d < 27


merge m:1 month d using "polls.dta"
gen dm = (dif + d2+d3+d4+d5+d6+d7)
*sum of poll changes in last 7 days


replace ct = 0 if ct==.

replace sls = 0 if sls==.

sort src_n date



bysort date: egen dsls = sum(sls) 
bysort date: egen dslc = sum(ct)
gen totsl = dsls/dslc
gen other_sl = (dsls - sls)/(dslc -ct) 
replace other_sl = 0 if other_sl==.
*replace other_sl = sls/ct - (mown-mos) if sls~=. & ct~=0

gen other_ct = dslc-ct
gen other_ct2 = other_ct^2
gen other_ct3 = other_ct^3
gen other_ct4 = other_ct^4

gen daystoelection = 20766-date
gen days2=dayst^2
gen days3=dayst^3
gen days4=dayst^4

sort src_n date
*regress own count of HR stories on average other slant (other_sl) and polynomial of other HR stories (other_ct) and polynomial time trend
poisson ct other* days* if src_n==1, vce(bootstrap)
est store a
poisson ct other* days* if src_n==7, vce(bootstrap)
est store b
poisson ct other* days* if src_n==4, vce(bootstrap)
est store c
poisson ct other* days* if src_n==6, vce(bootstrap)
est store d



poisson ct other_c* poll if src_n==1, vce(bootstrap)
est store a2
poisson ct other_c* poll if src_n==7, vce(bootstrap)
est store b2
poisson ct other_c* poll if src_n==4, vce(bootstrap)
est store c2
poisson ct other_c* poll if src_n==6, vce(bootstrap)
est store d2




use "days2016.dta", clear
collapse (sum) slsum=Slant2 (count) ct=Slant2 , by(src date)

gen sl = slsum/ct

encode src, gen(src_num)
tsset src_num date
tsfill, full

gen month = month(date)
gen d = day(date)
drop if month==7 & d < 27


merge m:1 month d using "polls.dta"
gen dm = (dif + d2+d3+d4+d5+d6+d7)
*sum of poll changes in last 7 days


replace ct = 0 if ct==.

replace sls = 0 if sls==.

sort src_n date



bysort date: egen dsls = sum(sls) 
bysort date: egen dslc = sum(ct)
gen totsl = dsls/dslc
gen other_sl = (dsls - sls)/(dslc -ct) 
replace other_sl = 0 if other_sl==.
*replace other_sl = sls/ct - (mown-mos) if sls~=. & ct~=0

gen other_ct = dslc-ct
gen other_ct2 = other_ct^2
gen other_ct3 = other_ct^3
gen other_ct4 = other_ct^4

gen daystoelection = 20766-date
gen days2=dayst^2
gen days3=dayst^3
gen days4=dayst^4

sort src_n date
*regress own count of HR stories on average other slant (other_sl) and polynomial of other HR stories (other_ct) and polynomial time trend
poisson ct other* days* if src_n==1, vce(bootstrap)
est store aa
poisson ct other* days* if src_n==7, vce(bootstrap)
est store ab
poisson ct other* days* if src_n==4, vce(bootstrap)
est store ac
poisson ct other* days* if src_n==6, vce(bootstrap)
est store ad



poisson ct other_c* poll if src_n==1, vce(bootstrap)
est store aa2
poisson ct other_c* poll if src_n==7, vce(bootstrap)
est store ab2
poisson ct other_c* poll if src_n==4, vce(bootstrap)
est store ac2
poisson ct other_c* poll if src_n==6, vce(bootstrap)
est store ad2





use "days2016.dta", clear
collapse (sum) slsum=Slant3 (count) ct=Slant3 , by(src date)

gen sl = slsum/ct

encode src, gen(src_num)
tsset src_num date
tsfill, full

gen month = month(date)
gen d = day(date)
drop if month==7 & d < 27


merge m:1 month d using "polls.dta"
gen dm = (dif + d2+d3+d4+d5+d6+d7)
*sum of poll changes in last 7 days


replace ct = 0 if ct==.

replace sls = 0 if sls==.

sort src_n date



bysort date: egen dsls = sum(sls) 
bysort date: egen dslc = sum(ct)
gen totsl = dsls/dslc
gen other_sl = (dsls - sls)/(dslc -ct) 
replace other_sl = 0 if other_sl==.
*replace other_sl = sls/ct - (mown-mos) if sls~=. & ct~=0

gen other_ct = dslc-ct
gen other_ct2 = other_ct^2
gen other_ct3 = other_ct^3
gen other_ct4 = other_ct^4

gen daystoelection = 20766-date
gen days2=dayst^2
gen days3=dayst^3
gen days4=dayst^4

sort src_n date
*regress own count of HR stories on average other slant (other_sl) and polynomial of other HR stories (other_ct) and polynomial time trend
poisson ct other* days* if src_n==1, vce(bootstrap)
est store aaa
poisson ct other* days* if src_n==7, vce(bootstrap)
est store aab
poisson ct other* days* if src_n==4, vce(bootstrap)
est store aac
poisson ct other* days* if src_n==6, vce(bootstrap)
est store aad



poisson ct other_c* poll if src_n==1, vce(bootstrap)
est store aaa2
poisson ct other_c* poll if src_n==7, vce(bootstrap)
est store aab2
poisson ct other_c* poll if src_n==4, vce(bootstrap)
est store aac2
poisson ct other_c* poll if src_n==6, vce(bootstrap)
est store aad2



estout a b c d , keep (  other_sl ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)
estout aa ab ac ad , keep (  other_sl ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)
estout aaa aab aac aad , keep (  other_sl ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)



estout a2 b2 c2 d2 , keep (  poll  ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)
estout aa2 ab2 ac2 ad2 , keep (  poll ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)
estout aaa2 aab2 aac2 aad2 , keep (  poll ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)

