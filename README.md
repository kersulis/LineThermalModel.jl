# LineThermalModel.jl
Thermal modeling for transmission lines. Written in Julia. Compliant with IEEE Standard 738-2012.

## IEEE 738 functions
The following functions are exported. Use `help()` on any of them to see input and output descriptions.

* `eq2c_N_Re`
* `eq3a_q_c1`
* `eq3b_q_c2`
* `eq4a_K_angle`
* `eq6_T_film`
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

The equations are named according to their numbers in [IEEE Standard 738][1]. After the equation number there is an underscore, followed by the name of the parameter the function returns.

## ACSR interpolation
Due to work by [Mads Almassalkhi][2], this package contains functionality for working with ACSR data. Return a table of ACSR data in English or SI units as follows:

```julia
table, labels = acsr_table_english()
table, labels = acsr_table_si()
```

More importantly, there is a simple lookup algorithm for guessing an ACSR conductor type based on a line's current rating (in Amps) and base voltage (in Volts):

```julia
D, Al_m, St_m, R = acsr_interpolation(I_lim, V_base)
```

Suppose one has the current limit and base voltage for a particular line. To compute `eta_c` and `eta_r` (the coefficients of conductive and radiative heat loss, respectively), one can do the following:

[1]: http://dx.doi.org/10.1109/IEEESTD.2013.6692858 
[2]: http://www.uvm.edu/~cems/?Page=employee/profile.php&SM=employee/_employeemenu.html&EmID=1108
