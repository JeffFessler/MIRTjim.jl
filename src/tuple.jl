# tuple.jl
# Arrays of Tuples or Vectors

export jim


"""
    jim(z::AbstractArray{<:NTuple{N,Number} where N} ; kwargs...)
    jim(z::AbstractArray{<:AbstractVector{<:Number}} ; kwargs...)

Stack Tuple along the last dimension.
"""
function jim(
    z::AbstractArray{<:Union{NTuple{N,Number} where N, AbstractVector{<:Number}}},
    args...,
    ;
    catdims::Int = ndims(z) + 1,
    kwargs...
)
    ntup = length(z[begin])
    zz = cat([[t[i] for t in z] for i in 1:ntup]..., dims = catdims)
    return jim(zz, args... ; kwargs...)
end
