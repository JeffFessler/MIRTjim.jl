#---------------------------------------------------------
# # [Examples](@id 1-examples)
#---------------------------------------------------------

#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__/notebooks/1-examples.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__/notebooks/1-examples.ipynb)

#md # !!! note
#md #     These examples are available as Jupyter notebooks.
#md #     You can execute them online with [binder](https://mybinder.org/) or just view them with [nbviewer](https://nbviewer.jupyter.org/) by clicking on the badges above!

# These examples show what `MIRTjim` is all about.

# First we tell Julia we are using this package,

using MIRTjim: jim

# ## Simplest plot


# Simplest example

z = ones(7) * (1:5)'
jim(z)


# Compare with `Plots.heatmap` to see the difference:

import Plots
Plots.heatmap(z')

# Images often should include a titles
jim(z, "7 × 5 image")


# ## OffsetArrays are handled naturally

using OffsetArrays
zo = OffsetArray(z, (-3,-2))
jim(z)


# ## 3D arrays as a mosaic
z3 = reshape(1:(6*5*4), (6, 5, 4))
jim(z3)


# ## Units are supported, with axis units appended
using Unitful

x = (1:7)u"m/s"
y = (1:5)u"s"
zu = x * y'
jim(x, y, zu ;
    clim=(0,40).*u"m", xlabel="rate", ylabel="time", colorbar_title="distance")

# See `UnitfulRecipes.jl` to customize the units


# ## Options abound

jim(:defs)
