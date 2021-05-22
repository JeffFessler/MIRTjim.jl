# prompt.jl

using MIRTjim: prompt
using Test: @test, @testset

@testset "prompt" begin
    _tmp = prompt(:state) # save current state
    prompt(:draw)
    @test prompt(:state) === :draw
    prompt()
    @test prompt(_tmp) isa Symbol # return to original state
end
