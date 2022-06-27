# mid3.jl

using MIRTjim: mid3
using Test: @test, @testset, @inferred

@testset "mid3" begin
    f = reshape(1:24, (2,3,4))
    g = @inferred mid3(f)
    @test g isa Matrix{Int64}

    f = rand(2,3,4)
    g = @inferred mid3(f)
    @test g isa Matrix{Float64}
end
