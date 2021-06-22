# caller_name.jl

using MIRTjim: caller_name

using Test: @test, @testset


@testset "caller_name" begin

	function f2()
		caller_name()
	end

	line = 2 + @__LINE__
	function f1()
		f2() # this is two lines below @__LINE__ above
	end

	@test isa(f1(), String)
	@test f1()[end-12:end] == ".jl $line f1(): "
end
