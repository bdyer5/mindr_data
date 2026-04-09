program define fixdatetime
    syntax varlist

    foreach vv of varlist `varlist' {
        quietly summarize `vv', meanonly
        if r(mean) > 1000000 {
            gen str19 `vv'_2 = subinstr(string(`vv', "%tcCCYY-NN-DD_HH:MM:SS"), "_", " ", .)
            order `vv'_2, after(`vv')
            drop `vv'
            rename `vv'_2 `vv'
        }
    }
end