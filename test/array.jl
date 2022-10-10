# array.jl array of images

using MIRTjim: jim
import MIRTjim
using LaTeXStrings
using Test: @test_throws

include("isplot.jl")

v = [rand(6,4), ones(6,4), rand(6,4), zeros(6,4), rand(6,4)]

@isplot jim(v, yflip=false, title=L"test3 x^2_i")
@isplot jim(v, ncol=2)
@isplot jim(v, nrow=3)
@isplot jim(-3:2, -2:1, v) # zyflip

@isplot jim(zeros(5,5,16)) # ncol-1
@isplot jim(zeros(5,5,10)) # ncol+1
@isplot jim(zeros(5,5,64)) # ncol-2

v = [reshape(1:12,3,4), ones(4,5)]
@test MIRTjim._maxgood(v) == 12
@test MIRTjim._mingood(v) == 1


# axes
v = [rand(6,3), ones(6,3), rand(6,3), zeros(6,3)]
@isplot jim((0:5,0:2), v) # x,y
@isplot jim((0:5,0:2,0:3), v) # x,y,z
@test_throws String jim((0:5,0:2,0:0), v) # mismatch ax[3]

z = ones(2,3,4)
@isplot jim(axes(z), z, "axes")
