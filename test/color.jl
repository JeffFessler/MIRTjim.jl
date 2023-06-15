# color.jl

using ColorTypes: RGB
using MIRTjim: jim

include("isplot.jl")

M,N = 6,4
z = map(RGB{Float32}, rand(M,N), rand(M,N), rand(M,N))
@isplot jim(z)

zz = [z, z]
z2 = stack(zz)
@isplot jim(z2)
@isplot jim(zz)
