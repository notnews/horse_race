
cd ..
use "regs_2016.dta", clear

*yahoo no top 10 from 10/21 on or 9/28
*usa no top 01 8/26-8/31 and from 9/22 on.  fewer obs 8/25 and 9/1, 9/19, 9/20
gen usaD = ((month==8 & day>=26) | (month==9 & (day==1 | day>=19)) | month>9)
gen yaD = (((month==10&day>=21)|month>10) | (month==9&day==28))

*yahoo - started scraping 3 top 10 lists on sept 26
gen yaD2 = ((month==9&day>=26)|month>=10)

*gen uSd = *usaD
*gen uD = usaD*usat
gen yD = Yahoo*yaD
gen yD2 = Yahoo*yaD2

qui xi: reg Slant1  Fox  WSJ hpmg Yahoo NYT  WashPost   yD yD2  i.mindate   , cluster(mindate)
est store a

qui xi: reg Slant2 Fox NYT WSJ hpmg Yahoo WashPost   yD yD2  i.mindate   , cluster(mindate)
est store b

qui xi: reg Slant3  Fox NYT WSJ hpmg Yahoo WashPost   yD yD2  i.mindate   , cluster(mindate)
est store c

estout a b c , keep (  Fox WSJ Yahoo NYT  WashPost) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N , fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)
