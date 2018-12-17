"""
Use line resistance to estimate line length.

In:

* `S_base` [VA], System base VA
* `V_base` [V], Base voltage
* `R_pu` [pu], Line resistance
* `R_cond` [ohms/m], Conductor resistance
* `bundle` [-], Number of conductors per phase

Out: `length` [m], Line length

2015-08-11.
Ported from .m file provided by Jonathon Martin.
Original code by Mads Almassalkhi.
"""
function estimate_length(
    S_base::Float64,
    V_base::Float64,
    R_pu::Float64,
    R_cond::Float64,
    bundle::Int64
    )
    R_base = V_base^2 / S_base
    R_ohms = R_pu * R_base
    line_length = R_ohms / (R_cond / bundle)
    # Ensure length estimate is positive
    default = 1e-4 * 1609.3
    line_length <= 0 && (line_length = default)
    return line_length
end
