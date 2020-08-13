
cd ..
use "regs_2012.dta", replace

egen start = min(mindate)
replace date = mindate - start

gen d2 = date^2
gen d3 = date^3
gen d4= date^4

preserve

gen FoxmSlant2 =FoxSlant1
gen NYTmSlant2 =NYTSlant1
gen USATodaymSlant2 =USATodaySlant1
gen WSJmSlant2 =WSJSlant1
gen HuffPostmSlant2 =HuffPostSlant1
gen YahoomSlant2 =YahooSlant1

qui xi: reg on2012top10 FoxmSlant2 WSJmSlant2 USATodaymSlant2 YahoomSlant2 NYTmSlant2 HuffPostmSlant2 Fox NYT USAToday WSJ HuffPost Yahoo on2012homepage on2012politics date d2-d4  , cluster(mindate)
est store a

replace FoxmSlant2 =FoxSlant2
replace NYTmSlant2 =NYTSlant2
replace USATodaymSlant2 =USATodaySlant2
replace WSJmSlant2 =WSJSlant2
replace HuffPostmSlant2 =HuffPostSlant2
replace YahoomSlant2 =YahooSlant2

qui xi: reg on2012top10 FoxmSlant2 NYTmSlant2 USATodaymSlant2 WSJmSlant2 HuffPostmSlant2 YahoomSlant2   Fox NYT USAToday WSJ HuffPost Yahoo on2012homepage on2012politics date d2-d4 , cluster(mindate)
est store b


replace FoxmSlant2 =FoxSlant3
replace NYTmSlant2 =NYTSlant3
replace USATodaymSlant2 =USATodaySlant3
replace WSJmSlant2 =WSJSlant3
replace HuffPostmSlant2 =HuffPostSlant3
replace YahoomSlant2 =YahooSlant3

qui xi: reg on2012top10 FoxmSlant2 NYTmSlant2 USATodaymSlant2 WSJmSlant2 HuffPostmSlant2 YahoomSlant2   Fox NYT USAToday WSJ HuffPost Yahoo on2012homepage on2012politics date d2-d4 , cluster(mindate)
est store c

restore


preserve


gen FoxmSlant2 =FoxSlant1
gen NYTmSlant2 =NYTSlant1
gen USATodaymSlant2 =USATodaySlant1
gen WSJmSlant2 =WSJSlant1
gen HuffPostmSlant2 =HuffPostSlant1
gen YahoomSlant2 =YahooSlant1

qui xi: reg on2012top10 FoxmSlant2 NYTmSlant2 USATodaymSlant2 WSJmSlant2 HuffPostmSlant2 YahoomSlant2  i.numHR  Fox NYT USAToday WSJ HuffPost Yahoo on2012homepage on2012politics date d2-d4  , cluster(mindate)
est store aa

replace FoxmSlant2 =FoxSlant2
replace NYTmSlant2 =NYTSlant2
replace USATodaymSlant2 =USATodaySlant2
replace WSJmSlant2 =WSJSlant2
replace HuffPostmSlant2 =HuffPostSlant2
replace YahoomSlant2 =YahooSlant2

qui xi: reg on2012top10 FoxmSlant2 NYTmSlant2 USATodaymSlant2 WSJmSlant2 HuffPostmSlant2 YahoomSlant2   i.numHR  Fox NYT USAToday WSJ HuffPost Yahoo on2012homepage on2012politics date d2-d4 , cluster(mindate)
est store ab


replace FoxmSlant2 =FoxSlant3
replace NYTmSlant2 =NYTSlant3
replace USATodaymSlant2 =USATodaySlant3
replace WSJmSlant2 =WSJSlant3
replace HuffPostmSlant2 =HuffPostSlant3
replace YahoomSlant2 =YahooSlant3

qui xi: reg on2012top10 FoxmSlant2 NYTmSlant2 USATodaymSlant2 WSJmSlant2 HuffPostmSlant2 YahoomSlant2   i.numHR  Fox NYT USAToday WSJ HuffPost Yahoo on2012homepage on2012politics date d2-d4 , cluster(mindate)
est store ac

restore

estout a b c aa ab ac , keep (  FoxmSlant2 NYTmSlant2 USATodaymSlant2 WSJmSlant2 HuffPostmSlant2 YahoomSlant2) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)



