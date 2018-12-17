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

"""
Estimate line lengths for all branches, given a `network_data` dict. The input
dict is the output of `PowerModels.parse_file`.
"""
function estimate_length(network_data::Dict{String, Any})
    !network_data["per_unit"] && @error "Network data is not in per unit!"

    baseMVA = network_data["baseMVA"]
    S_base = baseMVA * 1e6
    basekv = branch_basekv(network_data)

    branch_data = Vector{Tuple}()
    for (k, v) in network_data["branch"]
        # note: if network_data["per_unit"] == true, then rate_a has been
        # divided by baseMVA.
        push!(branch_data, (k, v["br_r"], v["rate_a"] * baseMVA))
    end

    line_lengths = Dict{String, Float64}()
    for i in 1:length(branch_data)
        id, R_pu, rate_a = branch_data[i]

        V_base = basekv[string(id)] * 1e3 # convert kV to V

        # convert long-term VA rating to current rating
        I_lim = rate_a * 1e6 / V_base

        a = acsr_interpolation(I_lim, V_base)
        line_lengths[string(id)] = estimate_length(S_base, V_base, R_pu, a.R, a.bundle)
    end
    return line_lengths
end
