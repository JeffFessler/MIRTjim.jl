"""
Module `MIRTjim` exports the "jiffy image display" method `jim`,
and the helper methods:
- `caller_name`
- `mid3`
- `prompt`
"""
module MIRTjim

    const RealU = Number # Union{Real, Unitful.Length}

    include("jim.jl")
    include("3d.jl")
    include("array.jl")
    include("tuple.jl")
    include("mid3.jl")
    include("caller_name.jl")
    include("prompt.jl")

end # module
