
cd ..
use "regs_2016.dta", clear

gen usaD = ((month==8 & day>=26) | (month==9 & (day==1 | day>=19)) | month>9)
gen yaD = (((month==10&day>=21)|month>10) | (month==9&day==28))

*yahoo - started scraping 3 top 10 lists on sept 26
gen yaD2 = ((month==9&day>=26)|month>=10)

*gen uSd = *usaD
*gen uD = usaD*usat
gen yD = Yahoo*yaD
gen yD2 = Yahoo*yaD2

preserve

gen ySd = YahooSlant1*yaD
gen ySd2 = YahooSlant1*yaD2

****** date polynomial instead of day FE
egen start = min(mindate)
replace date = mindate - start

gen d2 = date^2
gen d3 = date^3
gen d4= date^4

ren FoxSlant1  FoxmSlant2
ren WSJSlant1  WSJmSlant2
ren YahooSlant1 YahoomSlant2
ren GoogleSlant1   GooglemSlant2   
ren NYTSlant1 NYTmSlant2 
ren WashPostSlant1 WashPostmSlant2 


qui xi: reg on2016top10 FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2 Google Fox NYT WSJ hpmg Yahoo WashPost  ySd  yD yD2 ySd2 yD2 on2016homepage on2016politics date d2-d4 , cluster(mindate)
est store a

drop FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2  ySd ySd2

gen ySd = YahooSlant2*yaD
gen ySd2 = YahooSlant2*yaD2

ren FoxSlant2  FoxmSlant2
ren WSJSlant2  WSJmSlant2
ren YahooSlant2 YahoomSlant2
ren GoogleSlant2   GooglemSlant2   
ren NYTSlant2 NYTmSlant2
ren WashPostSlant2 WashPostmSlant2 



qui xi: reg on2016top10 FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2  Google Fox NYT WSJ hpmg Yahoo WashPost  ySd  yD yD2 ySd2 yD2 on2016homepage on2016politics date d2-d4 , cluster(mindate)
est store b

drop FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2 ySd ySd2

gen ySd = YahooSlant3*yaD
gen ySd2 = YahooSlant3*yaD2

ren FoxSlant3  FoxmSlant2
ren WSJSlant3  WSJmSlant2
ren YahooSlant3 YahoomSlant2
ren GoogleSlant3   GooglemSlant2   
ren NYTSlant3 NYTmSlant2 
ren WashPostSlant3 WashPostmSlant2 



qui xi: reg on2016top10 FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2  Google Fox NYT WSJ hpmg Yahoo WashPost  ySd  yD yD2 ySd2 yD2 on2016homepage on2016politics date d2-d4 , cluster(mindate)
est store c


restore


preserve

gen d2 = date^2
gen d3 = date^3
gen d4= date^4

gen ySd = YahooSlant1*yaD
gen ySd2 = YahooSlant1*yaD2

ren FoxSlant1  FoxmSlant2
ren WSJSlant1  WSJmSlant2
ren YahooSlant1 YahoomSlant2
ren GoogleSlant1   GooglemSlant2   
ren NYTSlant1 NYTmSlant2 
ren WashPostSlant1 WashPostmSlant2 



qui xi: reg on2016top10 FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2 Google Fox NYT WSJ hpmg Yahoo WashPost  ySd  yD yD2 ySd2 yD2 on2016homepage on2016politics  i.numHR date d2-d4 , cluster(mindate)
est store aa

drop FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2  ySd ySd2

gen ySd = YahooSlant2*yaD
gen ySd2 = YahooSlant2*yaD2

ren FoxSlant2  FoxmSlant2
ren WSJSlant2  WSJmSlant2
ren YahooSlant2 YahoomSlant2
ren GoogleSlant2   GooglemSlant2   
ren NYTSlant2 NYTmSlant2
ren WashPostSlant2 WashPostmSlant2 



qui xi: reg on2016top10 FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2  Google Fox NYT WSJ hpmg Yahoo WashPost  ySd  yD yD2 ySd2 yD2 on2016homepage on2016politics  i.numHR date d2-d4 , cluster(mindate)
est store ab

drop FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2 ySd ySd2

gen ySd = YahooSlant3*yaD
gen ySd2 = YahooSlant3*yaD2

ren FoxSlant3  FoxmSlant2
ren WSJSlant3  WSJmSlant2
ren YahooSlant3 YahoomSlant2
ren GoogleSlant3   GooglemSlant2   
ren NYTSlant3 NYTmSlant2 
ren WashPostSlant3 WashPostmSlant2 


qui xi: reg on2016top10 FoxmSlant2   WSJmSlant2 YahoomSlant2 GooglemSlant2   NYTmSlant2 WashPostmSlant2  Google Fox NYT WSJ hpmg Yahoo WashPost  ySd  yD yD2 ySd2 yD2 on2016homepage on2016politics  i.numHR date d2-d4 , cluster(mindate)
est store ac



restore


estout a b c aa ab ac  , keep (  FoxmSlant2 WSJmSlant2 NYTmSlant2  WashPostmSlant2  YahoomSlant2 GooglemSlant2) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N, fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)





















