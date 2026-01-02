program define fixdate
    syntax varlist

    foreach vv of varlist `varlist' {
        quietly sum `vv', detail
        if r(mean) > 1000000 {
            replace `vv' = dofc(`vv')
            format `vv' %tdmon_DD_CCYY
        }
    }
end


