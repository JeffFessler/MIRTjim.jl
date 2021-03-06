# prompt.jl

using MIRTjim: prompt
using Test: @test, @testset, @test_throws

@testset "prompt" begin
    prompt() # test "else c == 'd'"
    @test prompt(:state) === :draw

    _tmp = prompt(:state) # save current state
    prompt(:draw)
    @test prompt(:state) === :draw
    prompt()
    @test prompt(_tmp) isa Symbol # return to original state

    io_out = IOBuffer()

    io_in = IOBuffer("d")
    prompt( ; io_in, io_out)
    @test prompt(:state) == :draw
    prompt(:prompt)

    io_in = IOBuffer("n")
    prompt( ; io_in, io_out)
    @test prompt(:state) == :nodraw
    prompt(:prompt)

    io_in = IOBuffer("q")
    @test_throws String prompt( ; io_in, io_out)
end
