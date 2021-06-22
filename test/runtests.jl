# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

include("prompt.jl")

macro isplot(ex) # @isplot macro to streamline tests
    :(@test $(esc(ex)) isa Plots.Plot)
end


@testset "MIRTjim" begin
    include("jim.jl")

    @test length(detect_ambiguities(MIRTjim)) == 0
end

include("unit.jl")
