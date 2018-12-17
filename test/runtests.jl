using LineThermalModel, Test
const atol=1e-6

@testset "Heat balance for single line" begin
    I_lim   = 732.147 # A
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
    a = acsr_interpolation(I_lim, V_base)
    D, Al_m, St_m, R, bundle, label = a.D, a.Al_m, a.St_m, a.R, a.bundle, a.label

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

    @test D ≈ 0.0232156 atol=atol
    @test Al_m ≈ 0.779797 atol=atol
    @test St_m ≈ 0.285727 atol=atol
    @test R ≈ 6.167979e-5 atol=atol
    @test bundle == 1
    @test label == "Parakeet"

    @test eta_r ≈ 0.289266376 atol=atol
    @test T_film == 52.5
    @test k_f ≈ 0.02815328 atol=atol
    @test K_angle ≈ 1.2311481927818961 atol=atol
    @test p_f ≈ 1.0763378424625318 atol=atol
    @test mu_f ≈ 1.9642517300084803e-5 atol=atol
    @test N_Re ≈ 775.999091387987 atol=atol
    @test eta_c ≈ 1.5240287413704434 atol=atol

    @test omega == 0.0
    @test delta ≈ 23.021449792571953 atol=atol
    @test H_c ≈ 73.02144979257197 atol=atol
    @test chi == 0.0
    @test C == 180.0
    @test Z_c == 180.0
    @test theta == 90.0
    @test Q_s ≈ 1025.3693031729497 atol=atol
    @test K_solar ≈ 1.00696157132 atol=atol
    @test Q_se ≈ 1032.5074847063267 atol=atol
    @test eta_s ≈ 21.57325268575338 atol=atol
end

@testset "ACSR interpolation" begin
    acsr = acsr_interpolation(400.0, 138e3)
    @test acsr isa ACSRSpecsMetric
    @test acsr.label == "Penguin"
    @test acsr.R ≈ 1.9520997e-4 atol=atol

    acsr = acsr_interpolation(400.0, 138e3; metric=false)
    @test acsr isa ACSRSpecsEnglish
    @test acsr.label == "Penguin"
    @test acsr.R ≈ 0.119 atol=atol

    acsr = acsr_interpolation(1200.0, 138e3)
    @test acsr.label == "Lark"
    @test acsr.bundle == 2

    acsr = acsr_interpolation(10.0, 138e3)
    @test acsr.label == "Turkey"

    acsr = acsr_interpolation(3e3, 338e3)
    @test acsr.label == "Chukar"
    @test acsr.bundle == 2

    acsr = acsr_interpolation(200.0, 20e3)
    @test acsr.label == "Sparrow"
    @test acsr.bundle == 1

    @test_logs (:warn, "No ACSR match for line with I_lim = 6.0e6 A and V_base = 20000.0 kV") acsr_interpolation(6e6, 20e3)
    acsr = acsr_interpolation(6e6, 20e3)
    @test acsr.label == ""
    @test acsr.bundle == 1000
    @test isnan(acsr.D)
end
