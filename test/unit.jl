# unit.jl

using Unitful
using MIRTjim: jim
using Test: @test, @testset, @inferred

include("isplot.jl")

@testset "unit" begin
    x = 2u"mm" * (1:7)
    y = 2u"s" * (1:5)
    f = x * y'

#   @test @inferred jim(x, y, f) # Plots.Plot{Plots.GRBackend} vs Plot

    r = f / oneunit(f[1]) / 100 # real
    p1 = jim(1:7, 1:5, r)
    @isplot p1
    p2 = jim(1:7, 1:5, f)
    @isplot p2
    p3 = jim(x, y, r)
    @isplot p3
    p4 = jim(x, y, f)
    @isplot p4
    p5 = jim(1:7, 1:5, f; xlabel="x", ylabel="y")
    @isplot p5
    p6 = jim(x, y, f; xlabel="x", ylabel="y", clim=(50,100).*u"mm*s")
    @isplot p6
    jim(p1, p2, p3, p4, p5, p6)
end
