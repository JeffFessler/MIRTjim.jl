# axis.jl

using MIRTjim: jim
using AxisArrays: AxisArray
using Unitful: μm
using Test: @testset

include("isplot.jl")

@testset "axis" begin
    x = (1:7)μm
    y = (1:4)μm
    z = AxisArray(ones(7) * (1:4)'; x=x, y=y)

    p = jim(z, "AxisArray")
    @isplot p
end
