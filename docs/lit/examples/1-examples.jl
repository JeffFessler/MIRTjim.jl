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

using MIRTjim: jim

# ### Simple 2D image


# The simplest example is a 2D array.
# Note that `jim` is designed to show a function `f(x,y)`
# sampled as an array `z[x,y]` so the 1st index is horizontal direction.

x, y = 1:9, 1:7
f(x,y) = x * y^2
z = f.(x, y') # 9 × 7 array
jim(z ; xlabel="x", ylabel="y")


# Compare with `Plots.heatmap` to see the differences
# (transpose, color, wrong aspect ratio, distractingly many ticks):

import Plots
Plots.heatmap(z)

# Images often should include a title.
jim(z, "hello")


# ### OffsetArrays

# `jim` displays the axes naturally.

using OffsetArrays
zo = OffsetArray(z, (-3,-1))
jim(zo)


# ### 3D arrays

# `jim` automatically makes 3D arrays into a mosaic.

z3 = reshape(1:(9*7*6), (9, 7, 6))
jim(z3)


# ### Units

# `jim` supports units, with axis and colorbar units appended naturally,
# thanks to UnitfulRecipes.jl.
# (The ylabel may be not visible in the web Documentation
# but does appear properly when run locally.)

using Unitful

x = (1:9)u"m/s"
y = (1:7)u"s"
zu = x * y'
jim(x, y, zu ;
    clim=(0,40).*u"m", xlabel="rate", ylabel="time", colorbar_title="distance")

# See `UnitfulRecipes.jl` to customize the units


# ## Options

# See the docstring for `jim` for the many options.  Here are some defaults.

jim(:defs)

# One can set "global" defaults using appropriate keywords from above list.

jim(:colorbar, :none) # disable colorbar for subsequent figures
jim(:yflip, false) # have "y" axis increase upward
jim(rand(9,7))
