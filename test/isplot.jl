using Plots
using Test: @test

if !isdefined(Main, Symbol("@isplot"))
    macro isplot(ex) # @isplot macro to streamline tests
        :(@test $(esc(ex)) isa Plots.Plot)
    end
end
