# MIRTjim

https://github.com/JeffFessler/MIRTjim.jl

[![docs-stable][docs-stable-img]][docs-stable-url]
[![docs-dev][docs-dev-img]][docs-dev-url]
[![action status][action-img]][action-url]
[![pkgeval status][pkgeval-img]][pkgeval-url]
[![codecov][codecov-img]][codecov-url]
[![license][license-img]][license-url]
[![Aqua QA][aqua-img]][aqua-url]
[![code-style][code-blue-img]][code-blue-url]
[![deps](https://juliahub.com/docs/MIRTjim/deps.svg)](https://juliahub.com/ui/Packages/MIRTjim)
[![version](https://juliahub.com/docs/MIRTjim/version.svg)](https://juliahub.com/ui/Packages/MIRTjim)
[![pkgeval](https://juliahub.com/docs/MIRTjim/pkgeval.svg)](https://juliahub.com/ui/Packages/MIRTjim)

This Julia package
exports the `jim` method that provides a "jiffy image display"
for showing 2D grayscale and color images
(and 3D images as a mosaic).
It is basically a wrapper around `Plots.heatmap`
with natural defaults.
As of v0.9 it supports
axes, colorbar limit (`clim`) and images
with physical units.


## Getting started

```julia
using Pkg
Pkg.add("MIRTjim")
```


## Example

```julia
using MIRTjim: jim
z = (1:7) .+ (1:4)' # 7 × 4 matrix
jim(z ; title="example") # figure
```

For more examples,
see the
[documentation](https://jefffessler.github.io/MIRTjim.jl/stable).


### Helper functions

This repo also exports some small helper functions.

* `prompt()` first calls `Plots.gui()`
to display the current plot,
then waits for a user key press.

  Some keys have special effects:
  + `[q]uit` throws an error
  + `[d]raw` disables further prompting and the plots are just drawn
  + `[n]odraw` avoids the `gui()` call (useful for non-interactive testing)

  Calling `prompt(:prompt)` reverts the default key-press behavior.

* `caller_name()` uses `stacktrace` (in `Base`)
to return the file name and line number that called the current function.
It can be helpful for debugging and for giving warnings some context.

* `mid3()` extracts the middle three slices
(transaxial, coronal, sagittal) of a 3D array
and arranges them in a 2D mosaic for quick display.


### Notes

This method is used in many of the image reconstruction examples in
https://github.com/JuliaImageRecon.

Isolating these functions in this repo,
separate from other repos like
the
[Michigan Image Reconstruction Toolbox (MIRT)](https://github.com/JeffFessler/MIRT.jl)
keeps
those repos lighter
by avoiding a dependence on `Plots.jl` there.


### Compatibility

Tested with Julia ≥ 1.10.


### Related packages

* https://github.com/JuliaImages/ImageView.jl


<!-- URLs -->
[action-img]: https://github.com/JeffFessler/MIRTjim.jl/workflows/CI/badge.svg
[action-url]: https://github.com/JeffFessler/MIRTjim.jl/actions
[aqua-img]: https://img.shields.io/badge/Aqua.jl-%F0%9F%8C%A2-aqua.svg
[aqua-url]: https://github.com/JuliaTesting/Aqua.jl
[build-img]: https://github.com/JeffFessler/MIRTjim.jl/workflows/CI/badge.svg?branch=main
[build-url]: https://github.com/JeffFessler/MIRTjim.jl/actions?query=workflow%3ACI+branch%3Amain
[code-blue-img]: https://img.shields.io/badge/code%20style-blue-4495d1.svg
[code-blue-url]: https://github.com/invenia/BlueStyle
[codecov-img]: https://codecov.io/github/JeffFessler/MIRTjim.jl/coverage.svg?branch=main
[codecov-url]: https://codecov.io/github/JeffFessler/MIRTjim.jl?branch=main
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://JeffFessler.github.io/MIRTjim.jl/stable
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://JeffFessler.github.io/MIRTjim.jl/dev
[license-img]: https://img.shields.io/badge/license-MIT-brightgreen.svg
[license-url]: LICENSE
[pkgeval-img]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/I/ImageGeoms.svg
[pkgeval-url]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/I/ImageGeoms.html
