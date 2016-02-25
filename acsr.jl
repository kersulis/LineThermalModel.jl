"""
In:
* `Al_m` [kg/m],        Aluminum mass
* `St_m` [kg/m],        Steel mass

Out: `mCp` [J/m-C], Conductor heat capacity
"""
function eq_mCp(Al_m, St_m)
    Al_Cp = 955.0 # Aluminum heat capacity
    St_Cp = 476.0 # Steel heat capacity
    Al_m*Al_Cp + St_m*St_Cp
end

