# 3d.jl 3D arrays

export jim
using ColorTypes: Colorant


# 3D (or higher), built on array version
function jim!(pp::Plot, z::AbstractArray{<:Union{Number,Colorant}} ; kwargs...)
    zz = reshape(z, size(z,1), size(z,2), :)
    out = [@view zz[:,:,i] for i in 1:size(zz,3)]
    return jim!(pp, out ; kwargs...)
end


"""
    jim(x, y, z, array3d, [title] ; kwargs...) or jim!(pp::Plot, ...)
Allow user to provide
the "z axis" of a 3D array,
but ignore it without warning.
"""
function jim!(
    pp::Plot,
    x::AbstractVector{<:RealU},
    y::AbstractVector{<:RealU},
    z::AbstractVector{<:RealU}, # ignored!
    f::AbstractArray ; # could be 3D array or Vector of 2D arrays
    kwargs...,
)
    return jim!(pp, f ; x, y, kwargs...)
end

jim!(pp::Plot, x::AbstractVector{<:RealU}, y, z, f, title::String; kwargs...) =
    jim!(pp, x, y, z, f; title, kwargs...)


# axes tuples

"""
    jim(axes::Tuple, array, [title] ; kwargs...) or jim!(pp::Plot, ...)
Allow user to provide the `axes` of `array`.
(Only `x = axes[1]` and `y = axes[2]` are used.)
"""
function jim!(pp::Plot, ax::Tuple, f; kwargs...)
   2 ≤ length(ax) || throw("need at least 2 axes")
   if f isa Vector{<:Array}
        ndim = ndims(f[1])
        (length(ax) ≤ ndim) ||
            # the final axes could correspond to the # of arrays
            ((length(ax) == ndim+1) && length(ax[end]) == length(f)) ||
            throw("axes dimension mismatch for Vector{<:Array}")
   else
        length(ax) ≤ ndims(f) || throw("axes dimension mismatch for Array")
   end
   jim!(pp, f; x = ax[1], y = ax[2], kwargs...)
end

jim!(pp::Plot, ax::Tuple, f, title::String; kwargs...) =
    jim!(pp, ax, f; title, kwargs...)
