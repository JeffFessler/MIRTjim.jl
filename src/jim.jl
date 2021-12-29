#=
jim.jl
jiffy image display
2019-02-23 Jeff Fessler, University of Michigan
=#

export jim

using UnitfulRecipes
using Plots: heatmap, plot, plot!, Plot
import Plots # gui
using MosaicViews: mosaicview
using FFTViews: FFTView
using OffsetArrays: OffsetMatrix
import OffsetArrays # no_offset_view
using AxisArrays: AxisArray, axisnames, axisvalues
#using MIRTjim: prompt



# global default key/values
const jim_table = Dict([
 :aspect_ratio => :equal,
 :clim => nothing,
 :color => :grays,
 :colorbar => :legend,
 :gui => false,
 :prompt => false,
 :line3plot => true, # lines around sub image for 3d mosaic?
 :line3type => (:yellow),
 :ncol => 0,
 :nrow => 0,
 :padval => nothing,
 :mosaic_npad => 1,
 :tickdigit => 1,
 :title => "",
 :xlabel => nothing,
 :ylabel => nothing,
 :fft0 => false,
 :yflip => nothing, # defer to minimum value of y - see default below
 :yreverse => nothing, # defer to whether y is non-ascending
 :abswarn => isinteractive(), # warn when taking abs of complex images?
 :infwarn => isinteractive(), # warn when image has Inf?
 :nanwarn => isinteractive(), # warn when image has NaN?
])

jim_def = deepcopy(jim_table)

jim_stack = Any[] # for push! and pop!

# min,max of an iterable, excluding Inf, NaN
# caution: complex Unitful arrays are <:Number not <:Complex
function _maxgood(z::AbstractArray{T}) where {T <: Number}
   maximum(Iterators.filter(isfinite, z); init=-Inf*oneunit(T))
end
function _mingood(z)
   minimum(Iterators.filter(isfinite, z); init=Inf*oneunit(eltype(first(z))))
end
_mingood(z::AbstractArray{<:Complex}) = _mingood(Iterators.map(abs, z))
_mingood(z::AbstractArray{<:AbstractArray}) = minimum(_mingood, z)


"""
    nothing_else(x, y)
Return `y` if `x` is nothing, else return `x`.
"""
function nothing_else(x, y)
    return x == nothing ? y : x
end


# parsimonious axis ticks by default
function _ticks(x::AbstractVector{<:Number})
    if x[1] isa Real
        minfloor = x -> floor(minimum(x), digits = jim_def[:tickdigit])
        maxceil = x -> ceil(maximum(x), digits = jim_def[:tickdigit])
    else # Unitful
        minfloor = x -> floor(eltype(x), minimum(x), digits = jim_def[:tickdigit])
        maxceil = x -> ceil(eltype(x), maximum(x), digits = jim_def[:tickdigit])
    end
    z0 = zero(x[1]) # units
    ticks = (minimum(x) < z0 < maximum(x)) ?
        [minfloor(x), z0, maxceil(x)] :
        [minfloor(x), maxceil(x)]
    return ticks
end


# subtle issues with default labels depending on Unitful or not
_label(s::Symbol, x::AbstractVector{<:Real}) =
    isnothing(jim_def[s]) ? "" : jim_def[s]
_label(s::Symbol, x::AbstractVector{<:Number}) = jim_def[s]

_fft0_axis(n::Int) = (-n÷2):(n÷2 - iseven(n))


"""
    jim(z, ...)

A jiffy image display of `z` using `heatmap`.

in
- `z` image, can be 2D or higher, if higher then it uses `mosaicviews`

option
- `aspect_ratio`; default `:equal`
- `clim`; default `(minimum(z),maximum(z))`
- `color` (colormap, e.g. `:hsv`); default `:grays`
- `colorbar` (e.g. `:none`); default `:legend`
- `gui` call `Plots.gui()` immediately?; default `false`
- `prompt` call `prompt()` immediately?; default `false`
- `ncol` for mosaicview for 3D and higher arrays; default `0` does auto select
   "Number of tiles in column direction."
- `nrow` for mosaicview for 3D and higher arrays; default `0` does auto select
- `padval` padding value for mosaic view; default `minimum(z)`
- `line3plot` lines around sub image for 3d mosaic; default `true`
- `line3type` line type around sub image for 3d mosaic; default `(:yellow)`
- `mosaic_npad` # of pixel padding for mosaic view; default `1`
- `fft0` if true use FFTView to display (2D only); default `false`
- `title`; default `""`
- `xlabel`; default `nothing` (or units if applicable)
- `ylabel`; default `nothing`
- `yflip`; default `true` if `minimum(y) >= 0`
- `yreverse`; default `true` if `y[1] > y[end]`
- `x` values for x axis; default `collect(axes(z)[1])`
- `y` values for y axis; default `collect(axes(z)[2])`
- `xticks`; default `[minimum(x),maximum(x)]` (usually)
- `yticks`; default `[minimum(y),maximum(y)]`

out
- returns plot handle, type `Plots.Plot`
"""
function jim(
    z::AbstractMatrix{<:Number} ;
    abswarn::Bool = jim_def[:abswarn],
    kwargs...,
)

    !any(isfinite, z) && throw("no finite values")

    if all(z -> imag(z) == zero(real(z[1])), z)
        z = real(z) # remove any zero imaginary part
    else
        abswarn && (@warn "magnitude at $(caller_name())")
        z = abs.(z) # due to Unitful complex types not being <: Complex
    end
    return _jim(z ; kwargs...)
end


# 2D RealU matrix
function _jim(z::AbstractMatrix{<:RealU} ;
    aspect_ratio = jim_def[:aspect_ratio],
    clim = nothing_else(jim_def[:clim], (_mingood(z), _maxgood(z))),
    color = jim_def[:color],
    colorbar = jim_def[:colorbar],
    title::AbstractString = jim_def[:title],
    fft0::Bool = jim_def[:fft0],
    gui::Bool = jim_def[:gui],
    prompt::Bool = jim_def[:prompt],
    x::AbstractVector{<:Number} = fft0 ? _fft0_axis(size(z,1)) : axes(z,1),
    y::AbstractVector{<:Number} = fft0 ? _fft0_axis(size(z,2)) : axes(z,2),
    xy::Tuple = (x,y),
    xticks = _ticks(x),
    yticks = _ticks(y),
    xlabel::Union{Nothing,AbstractString} = _label(:xlabel, x),
    ylabel::Union{Nothing,AbstractString} = _label(:ylabel, y),
    yflip::Bool = nothing_else(jim_def[:yflip], minimum(y) >= zero(y[1])),
    yreverse::Bool = nothing_else(jim_def[:yreverse], y[1] > y[end]),
#   abswarn::Bool = jim_def[:abswarn], # not used here
    infwarn::Bool = jim_def[:infwarn],
    nanwarn::Bool = jim_def[:nanwarn],
    kwargs...
)

    # because some backends require y to be in ascending order
    if yreverse
        y = reverse(y)
        z = reverse(z, dims=2)
    end

    if fft0
        z = FFTView(z)[x,y]
    end

    # warnings for non-number values
    infwarn && any(isinf, z) && @warn("$(sum(isinf, z)) ±Inf")
    nanwarn && any(isnan, z) && @warn("$(sum(isnan, z)) NaN")

    if _mingood(z) ≈ _maxgood(z) # uniform or nearly uniform image
        tmp = (_mingood(z) == _maxgood(z)) ? "Uniform $(z[1])" :
            "Nearly uniform $((_mingood(z),_maxgood(z)))"

        p = plot( ; aspect_ratio,
            xlim = (x[1], x[end]),
            ylim = (y[1], y[end]),
            title,
            yflip,
            xlabel,
            ylabel,
            xticks,
            yticks,
            annotate = (x[(end+1)÷2], y[(end+1)÷2], tmp, :red),
            kwargs...
        )

    else

        p = heatmap(xy..., z' ;
            transpose = false,
            aspect_ratio,
            clim,
            color,
            colorbar,
            title,
            yflip,
            xlabel,
            ylabel,
            xticks,
            yticks,
            kwargs...
        )
    end

    gui && Plots.gui()
    prompt && MIRTjim.prompt()
    return p
end # jim



# 3D
function jim(z::AbstractArray{<:Number} ;
    gui::Bool = jim_def[:gui],
    prompt::Bool = jim_def[:prompt],
    line3plot = jim_def[:line3plot],
    line3type = jim_def[:line3type],
    ncol::Int = jim_def[:ncol],
    nrow::Int = jim_def[:nrow],
    padval = nothing_else(jim_def[:padval], _mingood(z)),
    mosaic_npad::Int = jim_def[:mosaic_npad],
    fft0::Bool = jim_def[:fft0],
    x::AbstractVector{<:Number} = axes(z,1),
    y::AbstractVector{<:Number} = axes(z,2),
    xy::Tuple = (),
    xticks = _ticks(x),
    yticks = _ticks(y),
    yflip::Bool = nothing_else(jim_def[:yflip], minimum(y) >= zero(y[1])),
    kwargs...
)

    # determine mosaic layout
    n1,n2,n3 = size(z,1), size(z,2), prod(size(z)[3:end])
    if ncol == 0 && nrow == 0
        nrow = n3 * size(z,1)/size(z,2) # wider images means fewer columns
        nrow *= 600/400 # typical plot aspect ratio
        nrow = max(floor(Int, sqrt(nrow)), 1)
        ncol = ceil(Int, n3 / nrow)
    end
    if ncol == 0
        ncol = ceil(Int, n3 / nrow)
    end
    if nrow == 0
        nrow = ceil(Int, n3 / ncol)
    end

    if !yflip # handling yflip with 3D mosaic is tricky
        z = reverse(z, dims=2)
        yflip = !yflip
    end

    zz = mosaicview(z ; fillvalue = padval, ncol, nrow, npad = mosaic_npad)
    fft0 && @warn("fft0 option ignored for 3D")

    # adjusted x,y for mosaic
    x = range(x[1]; length=size(zz,1), step=x[2]-x[1])
    zyflip = false
    if y[[1,end]] == axes(z,2)[[1,end]] # typical 1:ny case
        y = range(y[1]; length=size(zz,2), step=y[2]-y[1])
    else # ig.y setting
        y = range(y[end]; length=size(zz,2), step=y[1]-y[2])
        yflip = false
        zz = reverse(zz, dims=2)
        zyflip = true
        y = reverse(y)
    end
    xy = (x,y)

    p = jim(zz ; transpose = false, xy, xticks, yticks, yflip,
        gui=false, prompt=false, kwargs...)

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
        for ii=0:n3-1 # boxes around data only
            i1 = mod(ii, m1)
            i2 = ii ÷ m1
            plot_box!(i1*n1, i2*n2)
        end
    end

    plot!()
    gui && Plots.gui()
    prompt && MIRTjim.prompt()
    return p

end # jim 3D



# OffsetArray / OffsetMatrix
# https://github.com/JuliaPlots/Plots.jl/issues/2410
_axes(z,j) = axes(z,j).parent .+ axes(z,j).offset
function jim(z::OffsetMatrix{<:Number} ;
    x = _axes(z,1),
    y = _axes(z,2),
    kwargs...
)
    jim(OffsetArrays.no_offset_view(z) ; x, y, kwargs...)
end
#=
This approach fails because z' is no longer an OffsetMatrix
function Plots.heatmap(z::OffsetMatrix{<:Number}; kwargs...)
    x = axes(z,1); x = x.parent .+ x.offset
    y = axes(z,2); y = y.parent .+ y.offset
    heatmap(x, y, z; kwargs...)
end
function Plots.heatmap(x, y, z::OffsetMatrix{<:Number}; kwargs...)
    heatmap(x, y, OffsetArrays.no_offset_view(z); kwargs...)
end
=#


# AxisArray / AxisMatrix
const AxisMatrix{T} = AxisArray{T,2,D,Ax} where {T,D,Ax}
function jim(z::AxisMatrix{<:Number} ;
    x = axisvalues(z)[1],
    y = axisvalues(z)[2],
    xlabel = String(axisnames(z)[1]),
    ylabel = String(axisnames(z)[2]),
    kwargs...
)
    jim(parent(z) ; x, y, xlabel, ylabel, kwargs...)
end


"""
    jim(z, title::String ; kwargs...)
"""
jim(z::AbstractArray, title::AbstractString ; kwargs...) =
    jim(z ; title, kwargs...)


"""
    jim(x, y, z ; kwargs...)

The `x` and `y` axes can be Unitful thanks to UnitfulRecipes.
"""
jim(x::AbstractVector{<:Number}, y::AbstractVector{<:Number}, z ; kwargs...) =
    jim(z ; x, y, kwargs...)


"""
    jim(x, y, z, title::String ; kwargs...)

Allow `title` as positional argument for convenience.
"""
jim(x::AbstractVector, y, z, title::AbstractString ; kwargs...) =
    jim(x, y, z ; title, kwargs...)


"""
    jim(key::Symbol, value::Any)
Set default value for one of the keys.
"""
function jim(key::Symbol, value)
    global jim_def
    !haskey(jim_def, key) && throw(ArgumentError("no key $key"))
    jim_def[key] = value
end


"""
    jim(plot1, plot2, ... ; gui=?, prompt=?, kwargs...)
Subplot-type layout, where `kwargs` are passed to `plot`.
- `gui` call `Plots.gui()` immediately?; default `false`
- `prompt` call `prompt()` immediately?; default `false`
"""
function jim(p::Plot, args... ;
    gui::Bool = jim_def[:gui],
    prompt::Bool = jim_def[:prompt],
    kwargs...,
)
    out = plot(p, args... ; kwargs...)
    gui && Plots.gui()
    prompt && MIRTjim.prompt()
    return out
end


"""
    jim(:test::Symbol)

`jim(:keys)` return default keys.

`jim(:defs)` return `Dict` of default keys / vals.

`jim(:key)` return `Dict[key]` if possible.

`jim(:reset)` reset to defaults.

`jim(:push!)` `push!` current defaults to the stack.

`jim(:pop!)` `pop!` defaults from the stack.

`jim(:blank)` return blank plot.
"""
function jim(test::Symbol)
    global jim_def
    if test === :keys
        return sort(collect(keys(jim_def)))
    end
    if test === :blank
        return plot(legend=false, grid=false, foreground_color_subplot=:white)
    end
    if test === :defs
        return jim_def
    end
    if test === :push!
        return push!(jim_stack, deepcopy(jim_def))
    end
    if test === :pop!
        return jim_def = deepcopy(pop!(jim_stack))
    end
    if test === :reset
        return jim_def = deepcopy(jim_table)
    end
    if haskey(jim_def, test)
        return jim_def[test]
    end

    throw("symbol $test")
end
