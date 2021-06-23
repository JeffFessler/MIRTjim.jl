# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

macro isplot(ex) # @isplot macro to streamline tests
    :(@test $(esc(ex)) isa Plots.Plot)
end

@testset "MIRTjim" begin
    include("jim.jl")

    @test isempty(detect_ambiguities(MIRTjim))
end

include("caller_name.jl")
include("offset.jl")
include("prompt.jl")
include("unit.jl")
