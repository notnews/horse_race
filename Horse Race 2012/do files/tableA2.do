*local directory  "C:\Users\dstone\Dropbox\new research\horse race\"
local directory  "C:\Users\marce\Dropbox\Shared\horse race\"

use "`directory'\data\agg\regs_2012.dta", replace

sort month d
drop _m

merge m:1 month d using "`directory'\data\agg\polls.dta"

gen dm = (dif + d2+d3+d4+d5+d6+d7)

gen dayst2 = daysto^2
gen dayst3 = daysto^3


*'FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2' placeholder vars

gen FoxmSlant2 =FoxSlant1
gen NYTmSlant2 =NYTSlant1
gen USATodaymSlant2 =USATodaySlant1
gen WSJmSlant2 =WSJSlant1
gen HuffPostmSlant2 =HuffPostSlant1
gen YahoomSlant2 =YahooSlant1

qui xi: reg poll FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store a

qui xi: reg dm FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store b

qui xi: reg poll dayst* FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store a2

qui xi: reg dm dayst*  FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store b2


estout a b a2 b2, keep (FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)


replace FoxmSlant2 =FoxSlant2
replace NYTmSlant2 =NYTSlant2
replace USATodaymSlant2 =USATodaySlant2
replace WSJmSlant2 =WSJSlant2
replace HuffPostmSlant2 =HuffPostSlant2
replace YahoomSlant2 =YahooSlant2

qui xi: reg poll FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store a

qui xi: reg dm FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store b

qui xi: reg poll dayst* FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store a2

qui xi: reg dm dayst*  FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store b2


estout a b a2 b2, keep (FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)



replace FoxmSlant2 =FoxSlant3
replace NYTmSlant2 =NYTSlant3
replace USATodaymSlant2 =USATodaySlant3
replace WSJmSlant2 =WSJSlant3
replace HuffPostmSlant2 =HuffPostSlant3
replace YahoomSlant2 =YahooSlant3

qui xi: reg poll FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store a

qui xi: reg dm FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store b

qui xi: reg poll dayst* FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store a2

qui xi: reg dm dayst*  FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 , cluster(mindate)
est store b2


estout a b a2 b2, keep (FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 ) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)
