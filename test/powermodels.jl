using PowerModels: parse_file

@testset "PowerModels integration" begin
    matpower_path = joinpath(@__DIR__, "data", "nesta_case118_ieee.m")
    network_data = parse_file(matpower_path)

    line_lengths = estimate_length(network_data)

    @test maximum(collect(values(line_lengths))) ≈ 348276.672 atol=atol
    @test line_lengths["106"] ≈ 220329.17271676302 atol=atol

    acsr_specs = acsr_interpolation(network_data)
    labels = [a.label for a in values(acsr_specs)]
    @test length(unique(labels)) == 19
    @test acsr_specs["41"].label == "Oriole"
end
