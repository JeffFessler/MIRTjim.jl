#---------------------------------------------------------
# # [Option `yflip`](@id 2-yflip)
#---------------------------------------------------------

#=
Examples illustrating the `yflip` option in the Julia package
[`MIRTjim`](https://github.com/JeffFessler/MIRTjim.jl).

This page was generated from a single Julia file:
[2-yflip.jl](@__REPO_ROOT_URL__/2-yflip.jl).
=#

#md # In any such Julia documentation,
#md # you can access the source code
#md # using the "Edit on GitHub" link in the top right.

#md # The corresponding notebook can be viewed in
#md # [nbviewer](http://nbviewer.jupyter.org/) here:
#md # [`2-yflip.ipynb`](@__NBVIEWER_ROOT_URL__/2-yflip.ipynb),
#md # and opened in [binder](https://mybinder.org/) here:
#md # [`2-yflip.ipynb`](@__BINDER_ROOT_URL__/2-yflip.ipynb).


# ### Setup

# Packages needed here.

using MIRTjim: jim, prompt
using ImageGeoms: ImageGeom
using ImagePhantoms: shepp_logan, SheppLoganEmis, phantom
using InteractiveUtils: versioninfo

# The following line is helpful when running this file as a script;
# this way it will prompt user to hit a key after each figure is displayed.

isinteractive() ? jim(:prompt, true) : prompt(:draw);


# ### Simple 2D image and 3D stack of images

i1 = shepp_logan(128, SheppLoganEmis()) # 2D image
i1 = i1[12:117,:] # non-square for illustration
i2 = cat(dims=3, i1, 2i1, 3i1)/3 # 3D stack of images
size(i2)

#=
This figure illustrates how the `yflip` option affects
the image orientation in the "usual" case where y=1:N.
This is a typical convention in "image processing" of digital images
that lack any physical coordinates for their axes.
=#

ji = (args...; kwargs...) -> jim(args...; kwargs..., prompt=false)
jim(
    ji( i1, "2D default"),
    ji( i1, yflip=false, "2D yflip=false"),
    ji( i1, yflip=true, "2D yflip=true"),
    ji( i2, ncol=2, "3D default"),
    ji( i2, ncol=2, yflip=false, "3D yflip=false"),
    ji( i2, ncol=2, yflip=true, "3D yflip=true"),
)


# ### 2D image and 3D stack of images with specified x,y coordinates

#=
Now consider the case where we think of the image as a function `f(x,y)`
in the typical case where 0,0 is in the "center" of the image.
This convention is more common in physics-based imaging and inverse problems
where the image axes have meaningful values (and often have units).
=#

objects = shepp_logan(SheppLoganEmis(); fovs=(120,120))
ig = ImageGeom(dims=(50,64), deltas=(2,2), offsets=(0.5,0.5))
ax = axes(ig)
i3 = phantom(ax..., objects)
i4 = cat(dims=3, i3, 2i3, 3i3) # 3D stack of images

jim(
    ji(ax, i3, "2D default", xlabel="x", ylabel="y"),
    ji(ax, i3, yflip=false, "2D yflip=false"),
    ji(ax, i3, yflip=true, "2D yflip=true"),
    ji(ax..., i4, ncol=2, "3D default"),
    ji(ax..., i4, ncol=2, yflip=false, "3D yflip=false"),
    ji(ax..., i4, ncol=2, yflip=true, "3D yflip=true"),
    prompt = false,
)

#=
In both cases the "default" option for `yflip`
has the typical desired behavior,
but one can modify the default to achieve other behaviors.
=#


# ### Reproducibility

# This page was generated with the following version of Julia:

io = IOBuffer(); versioninfo(io); split(String(take!(io)), '\n')


# And with the following package versions

import Pkg; Pkg.status()
