# runtests.jl

using Test: @test, @testset, detect_ambiguities
using MIRTjim

@testset "MIRTjim" begin
    include("jim.jl")

	@test length(detect_ambiguities(MIRTjim)) == 0
end
