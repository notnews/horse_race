
use "googletrends.dta", clear

twoway (lpolyci nyt2012 day , title(NYT 2012)  graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(s1))
twoway (lpolyci fox2012 day , title(Fox 2012) graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(s2))
twoway (lpolyci nyt2016 day , title(NYT 2016) graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(s3))
twoway (lpolyci fox2016 day , title(Fox 2016) graphregion(color(white))    ylabel(#3) legend(off) xtitle("day") name(p))

graph combine s1 s2 s3 p, cols(2) graphregion(color(white)) 
