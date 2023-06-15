# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

ENV["GKSwstype"] = "100"

macro isplot(ex) # @isplot macro to streamline tests
    :(@test $(esc(ex)) isa Plots.Plot)
end

@testset "MIRTjim" begin
@show 88 # todo
    include("jim.jl")

    @test isempty(detect_ambiguities(MIRTjim))
end
throw() # todo

list = [
"axis.jl"
"caller_name.jl"
"color.jl"
"offset.jl"
"prompt.jl"
"unit.jl"
"mid3.jl"
]

for file in list[1:1]
@show file # todo
    include(file)
end

#= todo
include("axis.jl")
include("caller_name.jl")
include("color.jl")
include("offset.jl")
include("prompt.jl")
include("unit.jl")
include("mid3.jl")
=#

@testset "array" begin
    include("array.jl")
end
