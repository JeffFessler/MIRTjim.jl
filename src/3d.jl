# 3d.jl 3D arrays

export jim


# 3D (or higher), built on array version
function jim(z::AbstractArray{<:Number} ; kwargs...)
    zz = reshape(z, size(z,1), size(z,2), :)
    out = [@view zz[:,:,i] for i in 1:size(zz,3)]
    return jim(out ; kwargs...)
end


"""
    jim(x, y, z, array3d, [title] ; kwargs...)
Allow user to provide
the "z axis" of a 3D array,
but ignore it without warning.
"""
function jim(
    x::AbstractVector{<:RealU},
    y::AbstractVector{<:RealU},
    z::AbstractVector{<:RealU}, # ignored!
    f::AbstractArray ; # could be 3D array or Vector of 2D arrays
    kwargs...,
)
    return jim(f ; x, y, kwargs...)
end

jim(x::AbstractVector{<:RealU}, y, z, f, title::String; kwargs...) =
    jim(x, y, z, f; title, kwargs...)
