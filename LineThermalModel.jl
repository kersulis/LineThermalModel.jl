module LineThermalModel
export
    # ieee 738 functions
    eq2c_N_Re, eq3a_q_c1, eq3b_q_c2, eq4a_K_angle,
    eq6_T_film, eq13a_mu_f, eq14a_p_f, eq15a_k_f, omega,
    eq16a_H_c, eq16b_delta, eq17a_Z_c, eq17b_chi, table2_C,
    eq18_Q_s, eq19_Q_se, eq20_K_solar, eta_c,

    # acsr lookup/interpolation functions
    eq_mCp, ACSR_table_english, ACSR_table_si, ACSR_interpolation

include("ieee738.jl")
include("acsr.jl")
end

@doc """
This module implements two related pieces of functionality:

* Interpolating ACSR conductor type and looking up appropriate data using current limit and base voltage information, and
* Implementing equations in IEEE Standard 738-2012 to compute transmission line thermal parameters.
""" -> LineThermalModel
