# unit.jl

using Unitful
using Unitful: mm, s
using MIRTjim: jim
using Test: @test, @testset, @inferred

include("isplot.jl")

@testset "unit" begin
    x = 2u"mm" * (1:7)
    y = 2u"s" * (1:5)
    f = x * y'

    jim(x, y, ones(size(f))) # uniform

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

    z = 2 .+ rand(5,5) + 4im * ones(5,5)
    @test z isa AbstractMatrix{<:Complex}
    zu = z * Unitful.m # complex array with units
    @test !(zu isa AbstractMatrix{<:Complex}) # beware!
    @test zu isa AbstractMatrix{<:Number}
    @isplot jim(real(zu), "units") # colorbar roughly 2-3
    @isplot jim(zu, "units") # colorbar roughly 4-5

    z3u = (randn(3,4,5) + ones(3,4,5)) * Unitful.m # 3D, complex, units
    @isplot jim(z3u)
end


@testset "3d units" begin
    x = (2:8) * 1mm
    y = (3:7) * 1s
    z = (4:9)
    dims = tuple([size(a)[1] for a in (x,y,z)]...)
    f = rand(dims...) * 1mm / 1s
    @isplot jim(f)
    @isplot jim(x, y, f)
    @isplot jim(x, y, z, f)
    array3 = [f[:,:,iz] for iz in 1:length(z)]
    @isplot jim(x, y, array3)
    @isplot jim(x, y, z, array3)
end
