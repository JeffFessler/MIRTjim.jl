# array.jl - arrays of images

export jim

using UnitfulRecipes
using Plots: plot!
import Plots # gui
using MosaicViews: mosaic
#using MIRTjim: prompt


"""
    jim(z::AbstractArray{<:AbstractArray{<:Number}} ; kwargs...)

Display an array of images.
Same arguments and options as display of a 3D stack of images.
The argument `ratio` defaults to `/(Plots.default(:size)...)`
and affects the default `ncol` value.
"""
function jim(
    z::AbstractArray{<:AbstractArray{<:Number}} ;
    gui::Bool = jim_def[:gui],
    prompt::Bool = jim_def[:prompt],
    line3plot = jim_def[:line3plot],
    line3type = jim_def[:line3type],
    ncol::Int = jim_def[:ncol],
    nrow::Int = jim_def[:nrow],
    padval = nothing_else(jim_def[:padval], _mingood(z)),
    mosaic_npad::Int = jim_def[:mosaic_npad],
    fft0::Bool = jim_def[:fft0],
    x::AbstractVector{<:Number} = axes(z[1],1),
    y::AbstractVector{<:Number} = axes(z[1],2),
#   xy::Tuple = (),
    xticks = _ticks(x),
    yticks = _ticks(y),
    yflip::Bool = nothing_else(jim_def[:yflip], minimum(y) >= zero(y[1])),
    # typical plot window ratio is 600/400, but let caller over-ride it:
    ratio::Real = /(Plots.default(:size)...),
    kwargs...
)

    all(s -> (size(s) == size(z[1])), z) || throw("size mismatch")
    all(s -> (axes(s) == axes(z[1])), z) || throw("axes mismatch")

    # determine mosaic layout
    n3 = length(z) * prod(size(z[1])[3:end])
    n1,n2 = size(z[1])[1:2]
    if ncol == 0 && nrow == 0
        ncol = sqrt(ratio * n3 * n2 / n1) # wider images means fewer columns
        ncol = max(floor(Int, ncol), 1)

        # prefer ±1 if that will make it fit nicely
        if !(n3 / ncol ≈ round(Int, n3 / ncol))
            if ncol > 1 && n3 / (ncol-1) ≈ round(Int, n3 / (ncol-1)) # (n1,n2,64)
                ncol -= 1
            end
            if n3 / (ncol+1) ≈ round(Int, n3 / (ncol+1)) # (n1,n2,12)
                ncol += 1
            end
        end
    end
    if ncol == 0
        ncol = ceil(Int, n3 / nrow)
    end
    if nrow == 0
        nrow = ceil(Int, n3 / ncol)
    end

    if !yflip # handling yflip with array mosaic is tricky
        z = [reverse(x, dims=2) for x in z]
        yflip = !yflip
    end

    zz = mosaic(vec(z) ; fillvalue = padval, npad = mosaic_npad,
        ncol=nrow, nrow=ncol) # because mosaic uses opposite convention
    fft0 && @warn("fft0 option ignored for 3D")

    # adjusted x,y for mosaic
    x = range(x[1]; length=size(zz,1), step=x[2]-x[1])
    zyflip = false
    if y[[1,end]] == axes(z[1],2)[[1,end]] # typical 1:ny case
        y = range(y[1]; length=size(zz,2), step=y[2]-y[1])
    else # ig.y setting
        y = range(y[end]; length=size(zz,2), step=y[1]-y[2])
        yflip = false
        zz = reverse(zz, dims=2)
        zyflip = true
        y = reverse(y)
    end
#   xy = (x,y)

    p = jim(zz ; x, y, xticks, yticks, yflip,
            gui=false, prompt=false, kwargs...,
        )

    if n3 > 1 && line3plot # lines around each subimage
        n1 += mosaic_npad
        n2 += mosaic_npad
        m1 = (1+size(zz,1)) ÷ n1 # add one because of mosaicview non-edge
        m2 = (1+size(zz,2)) ÷ n2
        fx = o -> x[1] + o * (x[2] - x[1])
        fy = o -> y[1] + o * (y[2] - y[1])
        if zyflip
            fy = o -> y[end] - o * (y[2] - y[1])
        end
        function plot_box!(ox, oy)
            plot!(p,
                fx.(ox .+ [0,1,1,0,0] * n1 .- 1),
                fy.(oy .+ [0,0,1,1,0] * n2 .- 1),
                line = jim_def[:line3type], label="",
            )
        end
        for ii in 0:n3-1 # boxes around data only
            i1 = mod(ii, m1)
            i2 = ii ÷ m1
            plot_box!(i1*n1, i2*n2)
        end
    end

    plot!()
    gui && Plots.gui()
    prompt && MIRTjim.prompt()
    return p
end
