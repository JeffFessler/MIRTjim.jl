#---------------------------------------------------------
# # [Examples](@id 1-examples)
#---------------------------------------------------------

#=
This page illustrates the Julia package
[`MIRTjim`](https://github.com/JeffFessler/MIRTjim.jl).

This page was generated from a single Julia file:
[1-examples.jl](@__REPO_ROOT_URL__/1-examples.jl).
=#

#md # In any such Julia documentation,
#md # you can access the source code
#md # using the "Edit on GitHub" link in the top right.

#md # The corresponding notebook can be viewed in
#md # [nbviewer](http://nbviewer.jupyter.org/) here:
#md # [`1-examples.ipynb`](@__NBVIEWER_ROOT_URL__/1-examples.ipynb),
#md # and opened in [binder](https://mybinder.org/) here:
#md # [`1-examples.ipynb`](@__BINDER_ROOT_URL__/1-examples.ipynb).


# ### Setup

# Packages needed here.

using MIRTjim: jim, prompt
using AxisArrays: AxisArray
using OffsetArrays: OffsetArray
using Unitful
using Unitful: μm, s
import Plots
using InteractiveUtils: versioninfo


# The following line is helpful when running this file as a script;
# this way it will prompt user to hit a key after each figure is displayed.

isinteractive() ? jim(:prompt, true) : prompt(:draw);

# ## Simple 2D image


#=
The simplest example is a 2D array.
Note that `jim` is designed to show a function `f(x,y)`
sampled as an array `z[x,y]` so the 1st index is horizontal direction.
=#

x, y = 1:9, 1:7
f(x,y) = x * (y-4)^2
z = f.(x, y') # 9 × 7 array
jim(z ; xlabel="x", ylabel="y", title="f(x,y) = x * (y-4)^2")


# Compare with `Plots.heatmap` to see the differences
# (transpose, color, wrong aspect ratio, distractingly many ticks):

Plots.heatmap(z, title="heatmap")

#-
isinteractive() && prompt();


# Images often should include a title, so `title =` is optional.
jim(z, "hello")


# ## OffsetArrays

# `jim` displays the axes naturally.

zo = OffsetArray(z, (-3,-1))
jim(zo, "OffsetArray example")


# ## 3D arrays

# `jim` automatically makes 3D arrays into a mosaic.

f3 = reshape(1:(9*7*6), (9, 7, 6))
jim(f3, "3D")


# One can specify how many images per row or column for such a mosaic.

x11 = reshape(1:(5*6*11), (5, 6, 11))
jim(x11, "nrow=3"; nrow=3)

#
jim(x11, "ncol=6"; ncol=6)


# ## Arrays of images

# `jim` automatically makes arrays of images into a mosaic.

z3 = reshape(1:(9*7*6), (7, 9, 6))
z4 = [z3[:,:,(j-1)*3+i] for i=1:3, j=1:2]
jim(z4, "Arrays of images")


# ## Units

# `jim` supports units, with axis and colorbar units appended naturally,
# thanks to UnitfulRecipes.jl.

x = 0.1*(1:9)u"m/s"
y = (1:7)u"s"
zu = x * y'
jim(x, y, zu, "units" ;
    clim=(0,7).*u"m", xlabel="rate", ylabel="time", colorbar_title="distance")

# Note that `aspect_ratio` reverts to `:auto` when axis units differ.
# See `UnitfulRecipes.jl` to customize the units.


#=
Units are also supported for 3D arrays,
but the z-axis is ignored for plotting.
=#

x = (2:9) * 1μm
y = (3:8) * 1/s
z = (4:7) * 1μm * 1s
f3d = rand(8, 6, 4) # * s^2
jim(x, y, z, f3d, "3D with axis units")


# ## AxisArrays

# `jim` displays the axes (names and units) naturally by default:

x = (1:9)μm
y = (1:7)μm/s
za = AxisArray(x * y'; x, y)
jim(za, "AxisArray")


# ## Options

# See the docstring for `jim` for its many options.
# Here are some defaults.

jim(:defs)

# One can set "global" defaults using appropriate keywords from above list.
# Use `:push!` and `:pop!` for such changes to be temporary.

jim(:push!) # save current defaults
jim(:colorbar, :none) # disable colorbar for subsequent figures
jim(:yflip, false) # have "y" axis increase upward
jim(rand(9,7), "rand", color=:viridis) # kwargs... passed to heatmap()

#-
jim(:pop!); # restore


# ## Layout

# One can use `jim` just like `plot` with a layout of subplots.
# The `gui=true` option is useful when you want a figure to appear
# even when other code follows.
# Often it is used with the `prompt=true` option (not shown here).

p1 = jim(rand(5,7))
p2 = jim(rand(6,8), color=:viridis)
p3 = jim(rand(9,7), title="plot 3")
jim(p1, p2, p3; layout=(1,3), gui=true)


# ### Reproducibility

# This page was generated with the following version of Julia:

io = IOBuffer(); versioninfo(io); split(String(take!(io)), '\n')


# And with the following package versions

import Pkg; Pkg.status()
