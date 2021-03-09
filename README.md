# MIRTjim

https://github.com/JeffFessler/MIRTjim.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://JeffFessler.github.io/MIRTjim.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://JeffFessler.github.io/MIRTjim.jl/dev)
[![Build Status](https://github.com/JeffFessler/MIRTjim.jl/workflows/CI/badge.svg)](https://github.com/JeffFessler/MIRTjim.jl/actions)
[![Coverage](https://codecov.io/gh/JeffFessler/MIRTjim.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/JeffFessler/MIRTjim.jl)
[![Coverage](https://coveralls.io/repos/github/JeffFessler/MIRTjim.jl/badge.svg?branch=master)](https://coveralls.io/github/JeffFessler/MIRTjim.jl?branch=master)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

This repo exports the function `jim` that is a "jiffy image display" function
for showing 2D grayscale images
(and 3D grayscale images as a mosaic).
It is basically a wrapper around `Plots.heatmap`
with natural defaults.

Isolating this function in this repo,
separate from the primary repo
for the
[Michigan Image Reconstruction Toolbox (MIRT)](https://github.com/JeffFessler/MIRT.jl)
will eventually keep
`MIRT.jl` lighter
by avoiding dependence on `Plots.jl` there.
