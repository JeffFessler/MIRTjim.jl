#=
jim.jl
jiffy image display
2019-02-23 Jeff Fessler, University of Michigan
=#

export jim

using UnitfulRecipes
using Plots: heatmap, plot, plot!, Plot
using MosaicViews: mosaicview
using FFTViews: FFTView


# global default key/values
jim_def = Dict([
 :aspect_ratio => :equal,
 :clim => nothing,
 :color => :grays,
 :colorbar => :legend,
 :line3plot => true, # lines around sub image for 3d mosaic?
 :line3type => (:yellow),
 :ncol => 0,
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


# exclude Inf, NaN:
maxgood = z -> maximum(z[isfinite.(z)] / oneunit(z[1]) ; init=-Inf)
mingood = z -> minimum(z[isfinite.(z)] / oneunit(z[1]) ; init=Inf)


"""
    nothing_else(x, y)
return `y` if `x` is nothing, else return `x`
"""
function nothing_else(x, y)
    return x == nothing ? y : x
end


# parsimonious axis ticks by default
function _ticks(x::AbstractVector{<:Number})
    minfloor = minimum
    maxceil = maximum
    if x[1] isa Real
        minfloor = x -> floor(minimum(x), digits = jim_def[:tickdigit])
        maxceil = x -> ceil(maximum(x), digits = jim_def[:tickdigit])
    end
    z0 = zero(x[1]) # units
    ticks = (minimum(x) < z0 && maximum(x) > x0) ?
        [minfloor(x), z0, maxceil(x)] :
        [minfloor(x), maxceil(x)]
    return ticks / oneunit(z0) # UnitfulRecipes needs unitless ticks!?
    # https://github.com/jw3126/UnitfulRecipes.jl/issues/55
end


# subtle issues with default labels depending on Unitful or not
_label(s::Symbol, x::AbstractVector{<:Real}) =
	isnothing(jim_def[s]) ? "" : jim_def[s]
_label(s::Symbol, x::AbstractVector{<:Number}) = jim_def[s]


"""
    jim(z, ...)

A jiffy image display of `z` using `heatmap`

in
- `z` image, can be 2D or higher, if higher then it uses `mosaicviews`

option
- `aspect_ratio`; default `:equal`
- `clim`; default `(minimum(z),maximum(z))`
- `color` (colormap, e.g. `:hsv`); default `:grays`
- `colorbar` (e.g. `:none`); default `:legend`
- `ncol` for mosaicview for 3D and higher arrays; default `0` does auto select
- `padval` padding value for mosaic view; default `minimum(z)`
- `line3plot` lines around sub image for 3d mosaic; default `true`
- `line3type` line type around sub image for 3d mosaic; default `(:yellow)`
- `mosaic_npad` # of pixel padding for mosaic view; default `1`
- `fft0` if true use FFTView to display; default `false`
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

2019-02-23 Jeff Fessler, University of Michigan
"""
function jim(z::AbstractArray{<:Number} ;
    aspect_ratio = jim_def[:aspect_ratio],
    clim = nothing_else(jim_def[:clim], (mingood(z), maxgood(z))),
    color = jim_def[:color],
    colorbar = jim_def[:colorbar],
    line3plot = jim_def[:line3plot],
    line3type = jim_def[:line3type],
    ncol::Int = jim_def[:ncol],
    padval = nothing_else(jim_def[:padval], mingood(z)),
    mosaic_npad::Int = jim_def[:mosaic_npad],
    title::AbstractString = jim_def[:title],
    fft0::Bool = jim_def[:fft0],
    x::AbstractVector{<:Number} =
        fft0 ? ((-size(z,1)÷2):(size(z,1)÷2-1)) : collect(axes(z)[1]),
    y::AbstractVector{<:Number} =
        fft0 ? ((-size(z,2)÷2):(size(z,2)÷2-1)) : collect(axes(z)[2]),
    xticks = _ticks(x),
    yticks = _ticks(y),
    xlabel::Union{Nothing,AbstractString} = _label(:xlabel, x),
    ylabel::Union{Nothing,AbstractString} = _label(:ylabel, y),
    yflip::Bool = nothing_else(jim_def[:yflip], minimum(y) >= zero(y[1])),
    yreverse::Bool = nothing_else(jim_def[:yreverse], y[1] > y[end]),
    abswarn::Bool = jim_def[:abswarn], # ignored here
    infwarn::Bool = jim_def[:infwarn],
    nanwarn::Bool = jim_def[:nanwarn],
    kwargs...
)

    !any(isfinite, z) && throw("no finite values")

    # because some backends require y to be in ascending order
    if yreverse
        y = reverse(y)
        z = reverse(z, dims=2)
    end

    n1,n2,n3 = size(z,1), size(z,2), size(z,3)
    if n3 == 1
        z = z[:,:,1] # revert to 2D
    end
    xy = (x, y)
    if ndims(z) > 2
        n1 += mosaic_npad
        n2 += mosaic_npad
        n3 = size(z,3)
        if ncol == 0
            ncol = floor(Int, sqrt(prod(size(z)[3:end])))
        end
        z = mosaicview(z ; fillvalue = padval, ncol, npad = mosaic_npad)
        xy = () # no x,y for mosaic
    elseif fft0
        z = FFTView(z)[x,y]
    end

    # warnings for non-number values
    infwarn && any(isinf, z) && @warn("$(sum(isinf, z)) ±Inf")
    nanwarn && any(isnan, z) && @warn("$(sum(isnan, z)) NaN")

    if mingood(z) ≈ maxgood(z) # uniform or nearly uniform image
        tmp = (mingood(z) == maxgood(z)) ? "Uniform $(z[1])" :
            "Nearly uniform $((mingood(z),maxgood(z)))"
        plot( ; aspect_ratio,
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
        heatmap(xy..., z' ;
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

    if n3 > 1 && line3plot # lines around each subimage
        m1 = (1+size(z,1)) / n1 # add one because of mosaicview non-edge
        m2 = (1+size(z,2)) / n2
        plot_box! = (ox, oy) -> plot!(
            ox .+ [0,1,1,0,0] * n1 .+ 0.0,
            oy .+ [0,0,1,1,0] * n2 .+ 0.0,
            line = jim_def[:line3type], label="")
        for ii=0:n3-1
            i1 = mod(ii, m1)
            i2 = ii ÷ m1
            plot_box!(i1*n1, i2*n2)
        end
    end
    plot!()

end # jim


# complex image data
function jim(
    z::AbstractArray{<:Complex} ;
    abswarn::Bool = jim_def[:abswarn],
    kwargs...
)

    abswarn && (@warn "magnitude at $(caller_name())")
    jim(abs.(z) ; kwargs...)
end


#=
# other Numbers types (e.g., with units from Unitful)
function jim(z::AbstractArray{<:Number} ; kwargs...)
    jim(z / oneunit(z[1]) ; kwargs...)
end
=#


"""
    jim(z, title::String ; kwargs...)
"""
jim(z::AbstractArray{<:Number}, title::AbstractString ; kwargs...) =
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
set default value for one of the keys
"""
function jim(key::Symbol, value)
    global jim_def
    !haskey(jim_def, key) && throw(ArgumentError("no key $key"))
    jim_def[key] = value
end


"""
    jim(plot1, plot2, ... ; kwargs...)
Subplot-type layout
"""
function jim(p::Plot, args... ; kwargs...)
    plot(p, args... ; kwargs...)
end


"""
    jim(:test::Symbol)

`jim(:keys)` return default keys

`jim(:defs)` return `Dict` of default keys / vals

`jim(:key)` return `Dict[key]` if possible

`jim(:blank)` return blank plot
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
    if haskey(jim_def, test)
        return jim_def[test]
    end

    throw("symbol $test")
end
