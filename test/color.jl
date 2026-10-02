# color.jl

using ColorTypes: RGB
using MIRTjim: jim
import MIRTjim # _uniform _clim _units_same
using Test: @testset

include("isplot.jl")

M,N = 6,4
z = map(RGB{Float32}, rand(M,N), rand(M,N), rand(M,N))
@isplot jim(z)

zz = [z, z]
z2 = stack(zz)
@isplot jim(z2)
@isplot jim(zz)

@test isnothing(MIRTjim._uniform(z))
@test isnothing(MIRTjim._clim(z))
@test !MIRTjim._units_same(0, 1)

# https://github.com/JuliaPlots/Plots.jl/issues/4158
#jim(0:(M-1), 0:(N-1), z) # todo: test after above issue is fixed
