"ACSR data from spec table; english units."
struct ACSRSpecsEnglish
    "Catchy name"
    label::String
    "Number of conductors per phase"
    bundle::Int64
    "Conductor diameter [in]"
    D::Float64
    "Aluminum weight [lb/1000ft]"
    Al_m::Float64
    "Steel weight [lb/1000ft]"
    St_m::Float64
    "Resistance assuming AC current and 75 C temperature [ohm/1000ft]"
    R::Float64
end

"ACSR data from spec table; SI units."
struct ACSRSpecsMetric
    "Catchy name"
    label::String
    "Number of conductors per phase"
    bundle::Int64
    "Conductor diameter [m]"
    D::Float64
    "Aluminum weight [kg/m]"
    Al_m::Float64
    "Steel weight [kg/m]"
    St_m::Float64
    "Resistance assuming AC current and 75 C temperature [ohm/m]"
    R::Float64
end

"""
In: nothing

Out:

**ACSR table** with the following values for each conductor type:

* `D` [in],             Conductor diameter
* `Al_m` [lb/1000ft],   Aluminum weight
* `St_m` [lb/1000ft],   Steel weight
* `R` [ohm/1000ft],     Resistance assuming AC current and 75 C temperature
* `bundle` [-],         Number of conductors per phase

**`labels`** [string], Label for each conductor type

Credit to Mads Almassalkhi for compiling data.
"""
function acsr_table_english()
    acsr = [
    0.198   24  12  0.806  105 #'Turkey'   ,   '6/1'
    0.250   39  18  0.515  140 #'Swan'     ,   '6/1'
    0.316   62  29  0.332  184 #'Sparrow'  ,   '6/1'
    0.354   78  37  0.268  212 #'Robin'    ,   '6/1'
    0.398   99  47  0.217  242 #'Raven'    ,   '6/1'
    0.447  124  59  0.176  276 #'Quail'    ,   '6/1'
    0.502  156  74  0.144  315 #'Pigeon'   ,   '6/1'
    0.563  197  93  0.119  357 #'Penguin'  ,   '6/1'
    0.609  250  39 0.0787  449 #'Waxwing'  ,  '18/1'
    0.642  251 115 0.0779  475 #'Partridge',  '26/7'
    0.680  283 130 0.0693  492 #'Ostrich'  ,  '26/7'
    0.684  315  49 0.0625  519 #'Merlin'   ,  '18/1'
    0.720  317 146 0.0618  529 #'Linnet'   ,  '26/7'
    0.741  318 209 0.0613  535 #'Oriole'   ,  '30/7'
    0.743  373  58 0.0529  576 #'Chickadee',  '18/1'
    0.772  374 137 0.0526  584 #'Brant'    ,  '24/7'
    0.783  374 172 0.0523  587 #'Ibis'     ,  '26/7'
    0.806  375 247 0.0519  594 #'Lark'     ,  '30/7'
    0.814  447  70 0.0442  646 #'Pelican'  ,  '18/1'
    0.846  449 164 0.0439  655 #'Flicker'  ,  '24/7'
    0.883  450 296 0.0433  666 #'Hen'      ,  '30/7'
    0.879  522  82 0.0379  711 #'Osprey'   ,  '18/1'
    0.914  524 192 0.0376  721 #'Parakeet' ,  '24/7'
    0.953  525 345 0.0372  734 #'Eagle'    ,  '30/7'
    0.953  570 209 0.0346  760 #'Peacock'  ,  '24/7'
    0.994  571 375 0.0342  774 #'Wood Duck',  '30/7'
    0.977  599 219 0.0330  784 #'Rook'     ,  '24/7'
    1.019  600 395 0.0325  798 #'Scoter'   ,  '30/7'
    1.014  628 289 0.0313  812 #'Gannet'   ,  '26/7'
    1.051  674 310 0.0292  849 #'Starling' ,  '26/7'
    1.081  676 435 0.0290  859 #'Redwing'  , '30/19'
    1.040  745  58 0.0268  884 #'Coot'     ,  '36/1'
    1.107  749 344 0.0263  907 #'Drake'    ,  '26/7'
    1.140  751 483 0.0261  918 #'Mallard'  , '30/19'
    1.162  848 310 0.0241  961 #'Canary'   ,  '54/7'
    1.196  899 329 0.0228  996 #'Cardinal' ,  '54/7'
    1.245  973 356 0.0211 1047 #'Curlew'   ,  '54/7'
    1.292 1053 375 0.0197 1093 #'Finch'    , '54/19'
    1.302 1123 219 0.0182 1139 #'Bunting'  ,  '45/7'
    1.345 1198 234 0.0171 1184 #'Bittern'  ,  '45/7'
    1.386 1273 248 0.0162 1229 #'Dipper'   ,  '45/7'
    1.427 1348 263 0.0153 1272 #'Bobolink' ,  '45/7'
    1.504 1498 292 0.0139 1354 #'Lapwing'  ,  '45/7'
    1.602 1685 386 0.0125 1453 #'Chukar'   , '84/19'
    1.735 2051 249 0.0106 1607 #'Kiwi'     ,  '72/7'
    1.762 2040 468 0.0105 1623 #'Bluebird' , '84/19'
        ]
    labels = [
        "Turkey"; "Swan"; "Sparrow"; "Robin"; "Raven";
        "Quail"; "Pigeon"; "Penguin"; "Waxwing"; "Partridge";
        "Ostrich"; "Merlin"; "Linnet"; "Oriole"; "Chickadee";
        "Brant"; "Ibis"; "Lark"; "Pelican"; "Flicker"; "Hen";
        "Osprey"; "Parakeet"; "Eagle"; "Peacock"; "Wood Duck";
        "Rook"; "Scoter"; "Gannet"; "Starling"; "Redwing";
        "Coot"; "Drake"; "Mallard"; "Canary"; "Cardinal";
        "Curlew"; "Finch"; "Bunting"; "Bittern"; "Dipper";
        "Bobolink"; "Lapwing"; "Chukar"; "Kiwi"; "Bluebird"
    ]
    return acsr, labels
end

"""
In: nothing

Out:

**ACSR table** with the following values for each conductor type:

    * `D` [m],         Conductor diameter
    * `Al_m` [kg/m],   Aluminum weight
    * `St_m` [kg/m],   Steel weight
    * `R` [ohm/m],     Resistance assuming AC current and 75 C temperature
    * `bundle` [-],    Number of conductors per phase

**`labels`** [string],   Label for each conductor type

Credit to Mads Almassalkhi for compiling data.
"""
function acsr_table_si()
    acsr, labels = acsr_table_english()
    # Convert diameter: 1 in = 25.4e-3 m
    acsr[:, 1] = acsr[:, 1] * 25.4e-3

    # Convert weight: 1 lb = 0.453592 kg and 1000 ft = 304.8 m
    acsr[:, 2:3] = acsr[:, 2:3] * 0.453592 / 304.8

    # Convert resistance: 1000ft = 304.8 m
    acsr[:, 4] = acsr[:, 4] / 304.8
    # Scale resistances to better match RTS96 system data.
    # These values are tuned so that estimateLineLength.m will
    # give a result very close to the lengths provided for the RTS96 system.
    resistanceFactor = 2.0
    acsr[:, 4] = acsr[:, 4] / resistanceFactor
    return acsr, labels
end

"""
    acsr_specs = acsr_interpolation(I_lim, V_base)

Estimate bundling configuration and ACSR data based on I_lim and V_base.

In:

* `I_lim` [A],          Line current limit
* `V_base` [V],         Line base voltage
* `metric` (Bool),      Whether to use metric (SI) or English units

Out:

* `D` [m],              Conductor diameter
* `Al_m` [kg/m],        Aluminum weight
* `St_m` [kg/m],        Steel weight
* `R` [ohm/m],          Resistance assuming AC current and 75 C temperature
* `bundle` [-],         Number of conductors per phase
* `label` [string],     Label for each conductor type

Credit to Mads Almassalkhi for original MATLAB implementation. See:

*  Bergen and Vittal "Power Systems Analysis" 2nd ed 2000 p.85
*  Weedy and Cory "Electric Power Systems" 4th ed 1998 p.129
"""
function acsr_interpolation(I_lim::Float64, V_base::Float64; metric::Bool=true)
    acsr, labels = metric ? acsr_table_si() : acsr_table_english()

    maxcurrent = maximum(acsr[:, 5])
    largebundle = 1000

    if V_base <= 138e3
        bundle = (I_lim <= 1000) ? 1 :
            (I_lim <= maxcurrent * 2) ? 2 : largebundle
    elseif V_base <= 220e3
        bundle = (I_lim <= 1000) ? 1 :
            (I_lim <= maxcurrent * 2) ? 2 :
                (I_lim <= maxcurrent * 3) ? 3 : largebundle
    elseif V_base <= 345e3
        bundle = (I_lim <= maxcurrent) ? 1 :
            (I_lim <= maxcurrent * 2) ? 2 :
                (I_lim <= maxcurrent * 3) ? 3 : largebundle
    elseif V_base <= 500e3
        bundle = (I_lim <= maxcurrent * 2) ? 2 :
            (I_lim <= maxcurrent * 4) ? 4 :
                (I_lim <= maxcurrent * 6) ? 6 : largebundle
    else
        bundle = (I_lim <= maxcurrent * 3) ? 3 :
            (I_lim <= maxcurrent * 4) ? 4 :
                (I_lim <= maxcurrent * 6) ? 6 : largebundle
    end

    # Search for ACSR match
    row = 1
    found = false
    while !found && row <= size(acsr, 1)
        if I_lim <= acsr[row, 5] * bundle
            found = true
            row -= 1
            row == 0 && (row = 1)
        else
            row += 1
        end
    end

    # Assign output variables
    if !found
        @warn "No ACSR match for line with I_lim = $I_lim A and V_base = $V_base kV"
        D, Al_m, St_m, R = NaN, NaN, NaN, NaN
        label=""
    else
        D, Al_m, St_m, R = acsr[row, :]
        label = labels[row]
    end
    return metric ? ACSRSpecsMetric(label, bundle, D, Al_m, St_m, R) :
                    ACSRSpecsEnglish(label, bundle, D, Al_m, St_m, R)
end

"""
Estimate ACSR specs for all branches, given a `network_data` dict. The input
dict is the output of `PowerModels.parse_file`.
"""
function acsr_interpolation(network_data::Dict{String, Any}; metric::Bool=true)
    !network_data["per_unit"] && @error "Network data is not in per unit!"


    # even with network_data["per_unit"] == true, basekv values are still in kv
    basekv = branch_basekv(network_data)

    baseMVA = network_data["baseMVA"]
    branch_data = Vector{Tuple}()
    for (k, v) in network_data["branch"]
        # note: if network_data["per_unit"] == true, then rate_a has been
        # divided by baseMVA.
        push!(branch_data, (k, v["rate_a"] * baseMVA))
    end

    T = metric ? ACSRSpecsMetric : ACSRSpecsEnglish
    acsr_specs = Dict{String, T}()

    for i in 1:length(branch_data)
        id, rate_a = branch_data[i]
        V_base = basekv[string(id)] * 1e3 # convert kV to V

        # convert long-term VA rating to current rating
        I_lim = rate_a * 1e6 / V_base

        acsr_specs[id] = acsr_interpolation(I_lim, V_base; metric=metric)
    end
    return acsr_specs
end

"""
Return current limits for all branches, given a `network_data`
dict. The input is the output of `PowerModels.parse_file`.
"""
function return_current_limits(network_data::Dict{String, Any})
    !network_data["per_unit"] && @error "Network data is not in per unit!"

    # even with network_data["per_unit"] == true, basekv values are still in kv
    basekv = branch_basekv(network_data)
    baseMVA = network_data["baseMVA"]

    branch_data = Vector{Tuple}()
    for (k, v) in network_data["branch"]
        # note: if network_data["per_unit"] == true, then rate_a has been
        # divided by baseMVA.
        push!(branch_data, (k, v["rate_a"] * baseMVA))
    end

    current_limits = Dict{String, Float64}()

    for i in 1:length(branch_data)
        id, rate_a = branch_data[i]
        V_base = basekv[string(id)] * 1e3 # convert kV to V

        # convert long-term VA rating to current rating
        I_lim = rate_a * 1e6 / V_base

        current_limits[id] = I_lim
    end
    return current_limits
end
