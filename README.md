# LineThermalModel.jl
Thermal modeling for transmission lines, in Julia. Compliant with IEEE Standard 738-2012.

## Installation
From Julia prompt:

```julia
]dev https://github.com/kersulis/LineThermalModel.jl
```

## IEEE 738 functions
The following functions are exported. Use `?` to see input and output descriptions for any function; all are well-documented.

* `eq2c_N_Re`
* `eq3a_q_c1`
* `eq3b_q_c2`
* `eq4a_K_angle`
* `eq6_T_film`
* `eq8_q_s`
* `eq9_theta`
* `eq13a_mu_f`
* `eq14a_p_f`
* `eq15a_k_f`
* `eq_omega`
* `eq16a_H_c`
* `eq16b_delta`
* `eq17a_Z_c`
* `eq17b_chi`
* `eqtable2_C`
* `eq18_Q_s`
* `eq19_Q_se`
* `eq20_K_solar`
* `eq_eta_c`
* `eq_eta_r`

Equations are named according to their numbers in [IEEE Standard 738][1]. The equation number is followed by an underscore, then by the name of the parameter returned.

## ACSR data and interpolation
Return a table of ACSR data in English or SI units as follows:

```julia
table, labels = acsr_table_english()
table, labels = acsr_table_si()
```

More importantly, there is a simple lookup algorithm for estimating ACSR conductor type based on a line's current rating (in Amps) and base voltage (in Volts):

```julia
a = acsr_interpolation(I_lim, V_base; metric=true)
```
In the line above, `a` is an instance of ACSRSpecsMetric; with `metric=false`, it would be an instance of ACSRSpecsEnglish. Either way, `a` contains a best-estimate ACSR assignment for the given current limit and base voltage.

Credit to [Mads Almassalkhi][2] for ACSR functionality.

## Line length estimation
The length of a line may be estimated as follows. Use `?` or check the source for detailed descriptions of each argument.

```julia
length = estimate_length(S_base, V_base, R_pu, R_cond, bundle)
```

## PowerModels.jl integration
While PowerModels is not a dependency of LineThermalModel.jl, two of its functions are overloaded to work with the `network_data` dictionary structure described [here][3]: `acsr_interpolation` and `estimate_length`. When either of these functions is given a `network_data` dictionary, it will return a dictionary with the same keys as `network_data["branch"]`.

[1]: http://dx.doi.org/10.1109/IEEESTD.2013.6692858
[2]: http://www.uvm.edu/~cems/?Page=employee/profile.php&SM=employee/_employeemenu.html&EmID=1108
[3]: https://lanl-ansi.github.io/PowerModels.jl/stable/network-data/#The-Network-Data-Dictionary-1
