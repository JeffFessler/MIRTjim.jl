var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = MIRTjim","category":"page"},{"location":"#MIRTjim.jl-Documentation","page":"Home","title":"MIRTjim.jl Documentation","text":"","category":"section"},{"location":"#Contents","page":"Home","title":"Contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Most results from the Michigan Image Reconstruction Toolbox (MIRT) are images that one will want to display.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This module exports a function jim (jiffy image display) for convenient display of a grayscale image.","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Modules = [MIRTjim]","category":"page"},{"location":"#MIRTjim.MIRTjim","page":"Home","title":"MIRTjim.MIRTjim","text":"`MIRTjim` exports the \"jiffy image display\" `jim`\n\nfor the Michigan Image Reconstruction Toolbox (MIRT)\n\n\n\n\n\n","category":"module"},{"location":"#MIRTjim.jim-Tuple{AbstractArray{var\"#s17\",N} where N where var\"#s17\"<:Real}","page":"Home","title":"MIRTjim.jim","text":"jim(z, ...)\n\nA jiffy image display of z using heatmap\n\nin\n\nz image, can be 2D or higher, if higher then it uses mosaicviews\n\noption\n\naspect_ratio; default :equal\nclim; default (minimum(z),maximum(z))\ncolor (colormap, e.g. :hsv); default :grays\ncolorbar (e.g. :none); default :legend\nncol for mosaicview for 3D and higher arrays; default 0 does auto select\npadval padding value for mosaic view; default minimum(z)\nline3plot lines around sub image for 3d mosaic; default false\nline3type line type around sub image for 3d mosaic; default (:yellow)\nmosaic_npad # of pixel padding for mosaic view; default 1\nfft0 if true use FFTView to display; default false\ntitle; default \"\"\nxlabel; default \"\"\nylabel; default \"\"\nyflip; default true if minimum(y) >= 0\nyreverse; default true if y[1] > y[end]\nx values for x axis; default collect(axes(z)[1])\ny values for y axis; default collect(axes(z)[2])\nxtick; default [minimum(x),maximum(x)]\nytick; default [minimum(y),maximum(y)]\n\nout\n\nreturns plot handle, type Plots.Plot\n\n2019-02-23 Jeff Fessler, University of Michigan\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{AbstractArray{var\"#s58\",N} where N where var\"#s58\"<:Number,AbstractString}","page":"Home","title":"MIRTjim.jim","text":"jim(z, title::String ; kwargs...)\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Any,Any,Any,AbstractString}","page":"Home","title":"MIRTjim.jim","text":"jim(x, y, z, title::String ; kwargs...)\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Any,Any,Any}","page":"Home","title":"MIRTjim.jim","text":"jim(x, y, z ; kwargs...)\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Symbol,Any}","page":"Home","title":"MIRTjim.jim","text":"jim(key::Symbol, value::Any)\n\nset default value for one of the keys\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Symbol}","page":"Home","title":"MIRTjim.jim","text":"jim(:test::Symbol)\n\njim(:keys) return default keys\n\njim(:defs) return Dict of default keys / vals\n\njim(:key) return Dict[key] if possible\n\njim(:blank) return blank plot\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{}","page":"Home","title":"MIRTjim.jim","text":"jim()\n\nreturn docstring if user calls jim() with no arguments\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.nothing_else-Tuple{Any,Any}","page":"Home","title":"MIRTjim.nothing_else","text":"nothing_else(x, y)\n\nreturn y if x is nothing, else return x\n\n\n\n\n\n","category":"method"}]
}
