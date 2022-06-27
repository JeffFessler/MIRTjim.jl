# jim.jl test

using MIRTjim: jim
import MIRTjim # jim_stack
using LaTeXStrings
using Test: @test, @test_throws

include("isplot.jl")

@test jim(:keys) isa Vector{Symbol}
@test jim(:clim) isa Nothing
@test jim(:defs) isa AbstractDict
@test_throws String jim(:bad)

# settings stack
@test MIRTjim.jim_stack isa Vector{Any}
jim(:reset)
@test jim(:push!)[1] isa Dict{Symbol,Any}
@test jim(:pop!) == jim(:reset)
@test MIRTjim.jim_stack isa Vector{Any}

# basic plots
@isplot jim(ones(4,3), title="test2", xlabel=L"x")
@isplot jim(1:4, 5:9, zeros(4,5), title="test3", ylabel=L"y")
@isplot jim(1:4, 5:9, zeros(4,5), "test3")
@isplot jim(zeros(4,5), x=1:4, y=5:9, title="test3")
@isplot jim(rand(6,4), fft0=true)
@isplot jim(x=1:4, y=5:9, rand(4,5), title="test4")
@isplot jim(x=-9:9, y=9:-1:-9, (-9:9) * (abs.((9:-1:-9) .- 5) .< 3)', title="rev")
@isplot jim(ones(3,3)) # uniform

#3D
@isplot jim(rand(4,3,5), yflip=false, title=L"test3 x^2_i")
@isplot jim(rand(4,3,5), ncol=2)
@isplot jim(rand(4,3,5), nrow=3)
@isplot jim(-3:2, -2:1, rand(6,4,4)) # zyflip

jim(:abswarn, false)
@isplot jim(rand(ComplexF32, 4,3))
@isplot jim(rand(ComplexF32, 4,3), "complex 2d")
@isplot jim(rand(ComplexF32, 4,3,5), "complex 3d")
jim(:abswarn, true)
@isplot jim(rand(4,5), color=:hsv)
@isplot jim(jim(rand(2,3)), jim(rand(3,2)) ; layout=(2,1))
@isplot jim(:blank)
