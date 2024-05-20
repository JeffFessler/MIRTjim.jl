using MIRTjim: MIRTjim
import Aqua
using Test: @testset

@testset "aqua" begin
    Aqua.test_ambiguities(MIRTjim) # got StatsBase errors without isolating!?
    Aqua.test_all(MIRTjim; ambiguities = false)
end
