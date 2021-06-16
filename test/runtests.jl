# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

include("prompt.jl")

@testset "MIRTjim" begin
    include("jim.jl")

    @test length(detect_ambiguities(MIRTjim)) == 0
end

include("unit.jl")
