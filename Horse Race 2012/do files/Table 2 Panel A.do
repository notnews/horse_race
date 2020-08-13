
cd ..
use "regs_2012.dta", clear

qui xi: reg Slant1  Fox  WSJ USAToday    NYT HuffPost   i.mindate   , cluster(mindate)
est store a

qui xi: reg Slant2  Fox NYT WSJ HuffPost  USAToday     i.mindate   , cluster(mindate)
est store b

qui xi: reg Slant3  Fox NYT WSJ HuffPost  USAToday     i.mindate  , cluster(mindate)
est store c

estout a b c , keep (  Fox  WSJ USAToday  NYT HuffPost) style(tex) cells(b(star fmt(3)) se(par)) stats(r2_a N , fmt(%9.3f %9.0g)) starlevels(* 0.10 ** 0.05 *** 0.01)

