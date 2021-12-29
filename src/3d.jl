# 3d.jl 3D arrays

export jim


# 3D (or higher), built on array version
function jim(z::AbstractArray{T} ; kwargs...) where {T <: Number}
	zz = reshape(z, size(z,1), size(z,2), :)
	out = [@view zz[:,:,i] for i in 1:size(zz,3)]
	jim(out ; kwargs...)
end
