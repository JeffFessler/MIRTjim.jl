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


"""
    _aspect_ratio(x, y)
Use default `aspect_ratio` of `:equal` from `jim_def[:aspect_ratio]`
iff `Δx == Δy` (square pixels), otherwise revert to `:auto`.
"""
_aspect_ratio(x, y) = (x[2]-x[1]) == (y[2]-y[1]) ? jim_def[:aspect_ratio] : :auto


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
function _dogood(z, fun::Function, init::Real)
    T = eltype(first(z))
    z = Iterators.filter(isfinite, z)
    z = Iterators.map(x -> x / oneunit(T), z)
    if first(z) isa Complex
        z = Iterators.map(abs, z)
    end
    return fun(z; init) * oneunit(real(T))
end
_maxgood(z::AbstractArray{<:Number}) = _dogood(z, maximum, -Inf)
_maxgood(z::AbstractArray{<:AbstractArray}) = maximum(_maxgood, z)
_mingood(z::AbstractArray{<:Number}) = _dogood(z, minimum, Inf)
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
- `aspect_ratio`; default `:equal` for square pixels (see `_aspect_ratio`)
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
    clim = nothing_else(jim_def[:clim], (_mingood(z), _maxgood(z))),
    color = jim_def[:color],
    colorbar = jim_def[:colorbar],
    title::AbstractString = jim_def[:title],
    fft0::Bool = jim_def[:fft0],
    gui::Bool = jim_def[:gui],
    prompt::Bool = jim_def[:prompt],
    x::AbstractVector{<:Number} = fft0 ? _fft0_axis(size(z,1)) : axes(z,1),
    y::AbstractVector{<:Number} = fft0 ? _fft0_axis(size(z,2)) : axes(z,2),
    aspect_ratio = _aspect_ratio(x, y),
    xy::Tuple = (x,y),
    xticks = _ticks(x),
    yticks = _ticks(y),
    xlims = (min(x[1], xticks[1]), max(x[end], xticks[end])),
    ylims = (min(y[1], yticks[1]), max(y[end], yticks[end])),
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
            xlims,
            ylims,
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
            xlims,
            ylims,
            xticks,
            yticks,
            kwargs...
        )
    end

    gui && Plots.gui()
    prompt && MIRTjim.prompt()
    return p
end # jim



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
