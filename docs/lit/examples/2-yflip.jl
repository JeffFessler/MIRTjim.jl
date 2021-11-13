#---------------------------------------------------------
# # [Option yflip](@id 2-yflip)
#---------------------------------------------------------

# Examples illustrating the `yflip` option in `MIRTjim`.

# Packages needed:

using MIRTjim: jim, prompt
using ImageGeoms: ImageGeom
using ImagePhantoms: shepp_logan, SheppLoganEmis, phantom

# The following line is helpful when running this example.jl file as a script;
# this way it will prompt user to hit a key after each image is displayed.

isinteractive() && jim(:prompt, true);


# ### Simple 2D image and 3D stack of images

i1 = shepp_logan(128, SheppLoganEmis()) # 2D image
i1 = i1[12:117,:] # non-square for illustration
i2 = cat(dims=3, i1, 2i1, 3i1)/3 # 3D stack of images
size(i2)

# This figure illustrates how the `yflip` option affects
# the image orientation in the "usual" case where y=1:N.
# This is a typical convention in "image processing" of digital images
# that lack any physical coordinates for their axes.

jim(
    jim( i1, "2D default"),
    jim( i1, yflip=false, "2D yflip=false"),
    jim( i1, yflip=true, "2D yflip=true"),
    jim( i2, ncol=2, "3D default"),
    jim( i2, ncol=2, yflip=false, "3D yflip=false"),
    jim( i2, ncol=2, yflip=true, "3D yflip=true"),
)


# ### 2D image and 3D stack of images with specified x,y coordinates

# Now consider the case where we think of the image as a function `f(x,y)`
# in the typical case where 0,0 is in the "center" of the image.
# This convention is more common in physics-based imaging and inverse problems
# where the image axes have meaningful values (and often have units).

objects = shepp_logan(SheppLoganEmis(); fovs=(100,100))
ig = ImageGeom(dims=(100,128), deltas=(1,1))
xy = axes(ig)
i3 = phantom(xy..., objects)
i4 = cat(dims=3, i3, 2i3, 3i3) # 3D stack of images

jim(
    jim(xy..., i3, "2D default", xlabel="x", ylabel="y"),
    jim(xy..., i3, yflip=false, "2D yflip=false"),
    jim(xy..., i3, yflip=true, "2D yflip=true"),
    jim(xy..., i4, ncol=2, "3D default"),
    jim(xy..., i4, ncol=2, yflip=false, "3D yflip=false"),
    jim(xy..., i4, ncol=2, yflip=true, "3D yflip=true"),
)

# In both cases the "default" option for `yflip`
# has the typical desired behavior,
# but one can modify the default to achieve other behaviors.
