using MIRTjim: MIRTjim
import Aqua
using Test: @testset

@testset "aqua" begin
    Aqua.test_all(MIRTjim; ambiguities=false) # todo: so many
end
