I_lim   = 732.147   # A
V_base  = 138.0e3 # V
emm     = 0.7  # emissivity, [0.23, 0.91]
T_s     = 70.0 # conductor surface temperature, C
T_a     = 35.0 # ambient temperature, C
phi     = 90.0 # wind/line angle in degrees: wind perpendicular to line.
H_e     = 61.0 # height above sea level in m. Avg PJM elevation.
V_w     = 0.61 # wind speed in m/s
alpha   = 0.9  # solar absorptivity, [0.23, 0.91]
lat     = 40.0 # latitude in deg
N       = 161  # day of year: June 10
Z_l     = 90.0 # line azimuth: West-to-East
hours_from_noon = 0.0 # time: noon

# R and bundle are not necessary here
D,Al_m,St_m,R,bundle = acsr_interpolation(I_lim, V_base)

A_prime = D # conductor area, m^2 per linear m
eta_r   = eq_eta_r(D, emm)

T_film  = eq6_T_film(T_s, T_a)
k_f     = eq15a_k_f(T_film)
K_angle = eq4a_K_angle(phi)
p_f     = eq14a_p_f(H_e, T_film)
mu_f    = eq13a_mu_f(T_film)
N_Re    = eq2c_N_Re(D, p_f, V_w, mu_f)
eta_c   = eq_eta_c(k_f, K_angle, N_Re)

omega   = eq_omega(hours_from_noon)
delta   = eq16b_delta(N)
H_c     = eq16a_H_c(lat, delta, omega)
chi     = eq17b_chi(omega, lat, delta)
C       = eqtable2_C(omega, chi)
Z_c     = eq17a_Z_c(C, chi)
theta   = eq9_theta(H_c, Z_c, Z_l)
Q_s     = eq18_Q_s(H_c)
K_solar = eq20_K_solar(H_e)
Q_se    = eq19_Q_se(K_solar, Q_s)
eta_s   = eq8_q_s(alpha, Q_se, theta, A_prime)
