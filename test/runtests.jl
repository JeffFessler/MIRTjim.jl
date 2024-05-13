# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

ENV["GKSwstype"] = "100"

@testset "MIRTjim" begin
    include("jim.jl")

    @test isempty(detect_ambiguities(MIRTjim))
end

list = [
"axis.jl"
"caller_name.jl"
"color.jl"
"offset.jl"
"prompt.jl"
"unit.jl"
"mid3.jl"
]

for file in list
    include(file)
end

@testset "array" begin
    include("array.jl")
end
