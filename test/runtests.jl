# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

ENV["GKSwstype"] = "100"

macro isplot(ex) # @isplot macro to streamline tests
    :(@test $(esc(ex)) isa Plots.Plot)
end

@testset "MIRTjim" begin
    include("jim.jl")

    @test isempty(detect_ambiguities(MIRTjim))
end

include("axis.jl")
include("caller_name.jl")
include("offset.jl")
include("prompt.jl")
include("unit.jl")
include("mid3.jl")

@testset "array" begin
    include("array.jl")
end
