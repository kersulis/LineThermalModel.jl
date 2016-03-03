"""
In:

* `D`  [m],           Conductor diameter
* `p_f`  [kg/m^3],      Air density
* `V_w`  [m/s],         Wind speed
* `mu_f` [kg/m-s],      Dynamic viscosity of air

Out: `N_Re` [-], Reynolds number
"""
function eq2c_N_Re(D, p_f, V_w, mu_f)
    (D*p_f*V_w)/mu_f
end

"""
In:

* `K_angle` [deg],      Wind direction factor
* `N_Re` [-],           Reynolds number
* `k_f` [W/m-C],        Thermal conductivity of air
* `T_s` [C],            Conductor surface temperature 
* `T_a` [C],            Ambient temperature

Out: `q_c1` [W/m], Forced convection at low wind speeds
"""
function eq3a_q_c1(K_angle, N_Re, k_f, T_s, T_a)
    K_angle*(1.01 + 1.35*N_Re^0.52)*k_f*(T_s - T_a)
end

"""
In:

* `K_angle` [deg],      Wind direction factor
* `N_Re` [-],           Reynolds number
* `k_f` [W/m-C],        Thermal conductivity of air
* `T_s` [C],            Conductor surface temperature 
* `T_a` [C],            Ambient temperature

Out: `q_c2` [W/m], Forced convection at high wind speeds
"""
function eq3b_q_c2(K_angle, N_Re, k_f, T_s, T_a)
    K_angle*0.754*(N_Re^0.6)*k_f*(T_s - T_a)
end

"""
In: `phi` [deg], Angle between wind and conductor axis

Out: K_angle [-], Wind direction factor
"""
function eq4a_K_angle(phi)
    1.194 - cos(phi) + 0.194*cos(2*phi) + 0.368*sin(2*phi)
end

"""
In:

* `T_s` [C],            Conductor surface temperature 
* `T_a` [C],            Ambient temperature

Out: `T_film` [C], Film temperature
"""
function eq6_T_film(T_s, T_a)
    (T_s + T_a)/2
end

"""
In:

* `alpha` [-],          Solar absorptivity
* `Q_se` [W/m^2],       Elevation-corrected heat flux density
* `theta` [deg],        Sun ray incidence angle
* `A_prime` [m^2],      Conductor area

Out: `q_s`/`eta_s` [W/m], Solar heat gain rate/coefficient
"""
function eq8_q_s(alpha, Q_se, theta, A_prime)
    alpha*Q_se*sind(theta)*A_prime
end

"""
In:

* `H_c` [deg], Solar altitude
* `Z_c` [deg], Solar azimuth
* `Z_l` [deg], Line azimuth; East-West => pi/2, North-South => 0

Out: `theta` [deg], Sun ray incidence angle
"""
function eq9_theta(H_c, Z_c, Z_l)
    acosd(cosd(H_c)*cosd(Z_c - Z_l))
end

"""
In: `T_film` [C], Film temperature

Out: `mu_f` [kg/m-s], Dynamic viscosity of air
"""
function eq13a_mu_f(T_film)
    (1.458e-6*(T_film + 273)^1.5)/(T_film + 383.4)
end

"""
In:

* `H_e` [m],            Conductor elevation
* `T_film` [C],         Film temperature

Out: `p_f` [kg/m^3], Air density
"""
function eq14a_p_f(H_e, T_film)
    (1.293 - 1.525e-4*H_e + 6.379e-9*H_e^2)/(1 + 0.00367*T_film)
end

"""
In: `T_film` [C], Film temperature

Out: `k_f` [W/m-C], Thermal conductivity of air
"""
function eq15a_k_f(T_film)
    @evalpoly(T_film,2.424e-2,7.477e-5,-4.407e-9)
end

"""
In: `hours_from_noon`

Out: `omega` [deg], Hour angle
"""
function eq_omega(hours_from_noon)
    hours_from_noon*15.0
end

"""
In:

* `lat` [deg],          Latitude
* `delta` [deg],        Solar declination
* `omega` [deg],        Hour angle

Out: `H_c` [deg], Solar altitude
"""
function eq16a_H_c(lat, delta, omega)
    asind(cosd(lat)*cosd(delta)*cosd(omega) + sind(lat)*sind(delta))
end

"""
In: `N` [-], Day of year

Out: `delta` [deg], Solar declination
"""
function eq16b_delta(N)
    23.46*sind((284 + N)*360/365)
end

"""
In:

* `C` [deg],            Solar azimuth constant
* `chi` [deg],          Solar azimuth variable

Out: `Z_c` [deg], Solar azimuth
"""
function eq17a_Z_c(C, chi)
    C + atand(chi)
end

"""
In:

* `omega` [deg],        Hour angle
* `lat` [deg],          Latitude
* `delta` [deg],        Solar declination

Out: `chi` [deg], Solar azimuth variable
"""
function eq17b_chi(omega, lat, delta)
    sind(omega)/(sind(lat)*cosd(omega) - cosd(lat)*tand(delta))
end

"""
In:

* `omega` [deg],        Hour angle
* `chi` [deg],          Solar azimuth variable

Out: `C` [deg], Solar azimuth constant
"""
function eqtable2_C(omega, chi)
    if -180 <= omega < 0
        C = chi >= 0 ? 0.0 : 180.0
    elseif 0 <= omega < 180
        C = chi >= 0 ? 180.0 : 360.0
    end
end

"""
In: `H_c` [deg], Solar altitude

Out: `Q_s` [W/m^2], Heat flux density

Note: Assumes clear atmosphere and SI units in Table 3
"""
function eq18_Q_s(H_c)
    @evalpoly(H_c,-42.2391,63.8044,-1.9220,3.46921e-2,-3.61118e-4,1.94318e-6,-4.07608e-9)
end

"""
In:

* `K_solar` [-],        Solar altitude correction factor
* `Q_s` [W/m^2],        Heat flux density

Out: `Q_se` [W/m^2], Elevation-corrected heat flux density
"""
function eq19_Q_se(K_solar, Q_s)
    K_solar*Q_s
end

"""
In: `H_e` [m], Height above sea level

Out: `K_solar` [-], Solar altitude correction factor
"""
function eq20_K_solar(H_e)
    @evalpoly(H_e,1.0,1.148e-4,-1.108e-8)
end

"""
In:

* `k_f` [W/m-C],        Thermal conductivity of air
* `K_angle` [deg],      Wind direction factor
* `N_Re` [-],           Reynolds number

Out: `eta_c` [W/m-C], Conductive heat rate coefficient
"""
function eq_eta_c(k_f, K_angle, N_Re)
    K_angle*k_f*max(1.01 + 1.35*N_Re^0.52, 0.754*N_Re^0.6)
end

"""
In:

* `D` [m],      Conductor diameter
* `emm` [-],    Emissivity

Out: `eta_r` [W/m-C^4], Radiative heat loss rate coefficient
"""
function eq_eta_r(D, emm)
    17.8*D*emm
end
