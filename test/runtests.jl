# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

include("prompt.jl")

macro isplot(ex) # @isplot macro to streamline tests
    :(@test $(esc(ex)) isa Plots.Plot)
end


@testset "MIRTjim" begin
    include("jim.jl")

    @test isempty(detect_ambiguities(MIRTjim))
end

include("unit.jl")
include("offset.jl")
