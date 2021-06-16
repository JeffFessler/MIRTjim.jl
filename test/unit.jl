# unit.jl

using Unitful
using MIRTjim: jim
using Plots: Plot
using Test: @test, @testset, @inferred

@testset "unit" begin
    x = 1u"mm" * (1:7)
    y = 1u"s" * (1:5)
    f = x * y'

#   @test @inferred jim(x, y, f) # Plots.Plot{Plots.GRBackend} vs Plot
    @test jim(x, y, f) isa Plot
end
