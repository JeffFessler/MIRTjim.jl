# tuple.jl
# Arrays of Tuples or Vectors

export jim!


"""
    jim(..., z::AbstractArray{<:NTuple{N,Number} where N}, ... ; kwargs...)
    jim(..., z::AbstractArray{<:AbstractVector{<:Number}}, ... ; kwargs...)
    jim!(pp::Plot, ...)

Stack Tuple or Vector along the last dimension.
"""
function jim!(
    pp::Plot,
    z::AbstractArray{<:Union{NTuple{N,Number} where N, AbstractVector{<:Number}}},
    ;
    catdims::Int = ndims(z) + 1,
    kwargs...
)
    ntup = length(z[begin])
    zz = cat([[t[i] for t in z] for i in 1:ntup]..., dims = catdims)
    return jim!(pp, zz ; kwargs...)
end
