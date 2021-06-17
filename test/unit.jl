# unit.jl

using Unitful
#using UnitfulRecipes
using MIRTjim: jim
using Plots: Plot, plot, gui
using Test: @test, @testset, @inferred

@testset "unit" begin
    x = 2u"mm" * (1:7)
    y = 2u"s" * (1:5)
    f = x * y'

#   @test @inferred jim(x, y, f) # Plots.Plot{Plots.GRBackend} vs Plot

    r = f / oneunit(f[1]) / 100 # real
    p1 = jim(1:7, 1:5, r)
    p2 = jim(1:7, 1:5, f)
    p3 = jim(x, y, r)
    p4 = jim(x, y, f)
    p5 = jim(1:7, 1:5, f; xlabel="x", ylabel="y")
    p6 = jim(x, y, f; xlabel="x", ylabel="y")
    plot(p1, p2, p3, p4, p5, p6); gui()
    @test p4 isa Plot
end
