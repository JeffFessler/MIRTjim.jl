#---------------------------------------------------------
# # [Examples](@id 1-examples)
#---------------------------------------------------------

#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__/notebooks/1-examples.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__/notebooks/1-examples.ipynb)

#md # !!! note
#md #     These examples are available as Jupyter notebooks.
#md #     You can execute them online with [binder](https://mybinder.org/) or just view them with [nbviewer](https://nbviewer.jupyter.org/) by clicking on the badges above!

# These examples illustrate how to use `MIRTjim`.

# First we tell Julia we are using this package,

using MIRTjim: jim, prompt

# The following is helpful when running this example.jl file as a script;
# this way it will prompt user to hit a key after each image is displayed.

isinteractive() && jim(:prompt, true)

# ### Simple 2D image


# The simplest example is a 2D array.
# Note that `jim` is designed to show a function `f(x,y)`
# sampled as an array `z[x,y]` so the 1st index is horizontal direction.

x, y = 1:9, 1:7
f(x,y) = x * (y-4)^2
z = f.(x, y') # 9 × 7 array
jim(z ; xlabel="x", ylabel="y", title="f(x,y) = x * (y-4)^2")


# Compare with `Plots.heatmap` to see the differences
# (transpose, color, wrong aspect ratio, distractingly many ticks):

import Plots
Plots.heatmap(z, title="heatmap")
isinteractive() && prompt()


# Images often should include a title, so `title =` is optional.
jim(z, "hello")


# ### OffsetArrays

# `jim` displays the axes naturally.

using OffsetArrays
zo = OffsetArray(z, (-3,-1))
jim(zo, "OffsetArray example")


# ### 3D arrays

# `jim` automatically makes 3D arrays into a mosaic.

z3 = reshape(1:(9*7*6), (9, 7, 6))
jim(z3, "3D")


# ### Units

# `jim` supports units, with axis and colorbar units appended naturally,
# thanks to UnitfulRecipes.jl.
# (The ylabel may be not visible in the web Documentation
# but does appear properly when run locally.)

using Unitful

x = (1:9)u"m/s"
y = (1:7)u"s"
zu = x * y'
jim(x, y, zu, "units" ;
    clim=(0,40).*u"m", xlabel="rate", ylabel="time", colorbar_title="distance")

# See `UnitfulRecipes.jl` to customize the units


# ## Options

# See the docstring for `jim` for the many options.  Here are some defaults.

jim(:defs)

# One can set "global" defaults using appropriate keywords from above list.
# Use `:push` and `pop:` for such changes to be temporary

jim(:push!) # save current defaults
jim(:colorbar, :none) # disable colorbar for subsequent figures
jim(:yflip, false) # have "y" axis increase upward
jim(rand(9,7), "rand")
jim(:pop!) # restore
