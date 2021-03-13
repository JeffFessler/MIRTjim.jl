# MIRTjim

https://github.com/JeffFessler/MIRTjim.jl

[![action status][action-img]][action-url]
[![pkgeval status][pkgeval-img]][pkgeval-url]
[![codecov][codecov-img]][codecov-url]
[![license][license-img]][license-url]
<!--
[![coveralls][coveralls-img]][coveralls-url]
[![Coverage](https://coveralls.io/repos/github/JeffFessler/MIRTjim.jl/badge.svg?branch=main)]
(https://coveralls.io/github/JeffFessler/MIRTjim.jl?branch=main)
-->
[![docs stable][docs-stable-img]][docs-stable-url]
[![docs dev][docs-dev-img]][docs-dev-url]
[![code-style][code-blue-img]][code-blue-url]

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

<!-- URLs -->

[action-img]: https://github.com/JeffFessler/MIRTjim.jl/workflows/CI/badge.svg
[action-url]: https://github.com/JeffFessler/MIRTjim.jl/actions
[build-img]: https://github.com/JeffFessler/MIRTjim.jl/workflows/CI/badge.svg?branch=main
[build-url]: https://github.com/JeffFessler/MIRTjim.jl/actions?query=workflow%3ACI+branch%3Amain
[pkgeval-img]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/M/MIRTjim.svg
[pkgeval-url]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/M/MIRTjim.html
[code-blue-img]: https://img.shields.io/badge/code%20style-blue-4495d1.svg
[code-blue-url]: https://github.com/invenia/BlueStyle
[codecov-img]: https://codecov.io/github/JeffFessler/MIRTjim.jl/coverage.svg?branch=main
[codecov-url]: https://codecov.io/github/JeffFessler/MIRTjim.jl?branch=main
[coveralls-img]: https://coveralls.io/repos/JeffFessler/MIRTjim.jl/badge.svg?branch=main
[coveralls-url]: https://coveralls.io/github/JeffFessler/MIRTjim.jl?branch=main
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://JeffFessler.github.io/MIRTjim.jl/stable
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://JeffFessler.github.io/MIRTjim.jl/dev
[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat
[license-url]: LICENSE
<!--
[travis-img]: https://travis-ci.org/JeffFessler/MIRTjim.jl.svg?branch=main
[travis-url]: https://travis-ci.org/JeffFessler/MIRTjim.jl
-->
