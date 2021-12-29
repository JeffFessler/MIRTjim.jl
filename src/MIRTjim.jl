"""
Module `MIRTjim` exports the "jiffy image display" method `jim`,
and the two helper methods `caller_name` and `prompt`.
"""
module MIRTjim

    const RealU = Number # Union{Real, Unitful.Length}

    include("jim.jl")
    include("3d.jl")
    include("array.jl")
    include("caller_name.jl")
    include("prompt.jl")

end # module
