# jim.jl test

using MIRTjim: jim
using LaTeXStrings
using OffsetArrays: OffsetArray
using Test: @test, @test_throws

include("isplot.jl")

jim(:keys)
jim(:clim)
@test typeof(jim(:defs)) <: Dict

@test_throws String jim(:bad)

@isplot jim(ones(4,3), title="test2", xlabel=L"x")
@isplot jim(rand(4,3,5), title=L"test3 x^2_i")
@isplot jim(1:4, 5:9, zeros(4,5), title="test3", ylabel=L"y")
@isplot jim(1:4, 5:9, zeros(4,5), "test3")
@isplot jim(zeros(4,5), x=1:4, y=5:9, title="test3")
@isplot jim(rand(6,4), fft0=true)
@isplot jim(x=1:4, y=5:9, rand(4,5), title="test4")
@isplot jim(x=-9:9, y=9:-1:-9, (-9:9) * (abs.((9:-1:-9) .- 5) .< 3)', title="rev")
@isplot jim(OffsetArray(rand(5,3), (-3,-2)), "offset")
@isplot jim(ones(3,3)) # uniform
jim(:abswarn, false)
@isplot jim(complex(rand(4,3)))
@isplot jim(complex(rand(4,3)), "complex")
jim(:abswarn, true)
@isplot jim(rand(4,5), color=:hsv)
@isplot jim(jim(rand(2,3)), jim(rand(3,2)) ; layout=(2,1))
jim(:blank)
