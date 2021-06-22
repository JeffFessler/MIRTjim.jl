# offset.jl
# https://github.com/JuliaPlots/Plots.jl/issues/2410

using MIRTjim: jim
using OffsetArrays
using Test: @testset

include("isplot.jl")

@testset "unit" begin
    z = OffsetArrays.centered(ones(7) * (1:4)')

    p = jim(z, "offset")
    @isplot p
end
