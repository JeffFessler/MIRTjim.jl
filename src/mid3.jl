# mid3.jl

export mid3

_average(x::AbstractArray{T}) where {T <: Integer} = round(T, sum(x) / length(x))
_average(x::AbstractArray{<:Number}) = sum(x) / length(x)

"""
    mid3(a::AbstractArray{T,3})
Extract the "middle" slices (transaxial, coronal, sagittal)
and arrange in a 2D mosaic for quick display of 3D array.
"""
function mid3(a::AbstractArray{T,3}) where {T}
    (nx,ny,nz) = size(a)
    xy = a[:,:,ceil(Int, nz÷2)]
    xz = a[:,ceil(Int,end/2),:]
    zy = a[ceil(Int, nx÷2),:,:]
    return [xy xz; transpose(zy) fill(_average(a), nz, nz)]
end

