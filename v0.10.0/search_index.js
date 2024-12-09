var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = MIRTjim","category":"page"},{"location":"#MIRTjim.jl-Documentation","page":"Home","title":"MIRTjim.jl Documentation","text":"","category":"section"},{"location":"#Contents","page":"Home","title":"Contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Most results from the Michigan Image Reconstruction Toolbox (MIRT) are images that one will want to display.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This module exports a function jim (jiffy image display) for convenient display of a grayscale image.","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Functions","page":"Home","title":"Functions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Modules = [MIRTjim]","category":"page"},{"location":"#MIRTjim.MIRTjim","page":"Home","title":"MIRTjim.MIRTjim","text":"`MIRTjim` exports the \"jiffy image display\" `jim`\n\nfor the Michigan Image Reconstruction Toolbox (MIRT)\n\n\n\n\n\n","category":"module"},{"location":"#MIRTjim.caller_name-Tuple{}","page":"Home","title":"MIRTjim.caller_name","text":"caller_name() or caller_name(;level=4)\n\nReturn \"filename line fun():\" as a string to describe where this function was called.\n\nStack levels:\n\n1: #caller_name\n2: caller_name()\n3: function that invoked caller()\n4: the calling function we want to return\n\nHence the default level is 4, but we increment it by one in case user says @show caller_name() in which case stack[3] is a macro expansion.\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{AbstractArray{var\"#s81\", N} where {var\"#s81\"<:Number, N}, AbstractString}","page":"Home","title":"MIRTjim.jim","text":"jim(z, title::String ; kwargs...)\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{AbstractMatrix{var\"#s57\"} where var\"#s57\"<:Number}","page":"Home","title":"MIRTjim.jim","text":"jim(z, ...)\n\nA jiffy image display of z using heatmap\n\nin\n\nz image, can be 2D or higher, if higher then it uses mosaicviews\n\noption\n\naspect_ratio; default :equal\nclim; default (minimum(z),maximum(z))\ncolor (colormap, e.g. :hsv); default :grays\ncolorbar (e.g. :none); default :legend\ngui call Plots.gui() immediately?; default false\nprompt call prompt() immediately?; default false\nncol for mosaicview for 3D and higher arrays; default 0 does auto select\npadval padding value for mosaic view; default minimum(z)\nline3plot lines around sub image for 3d mosaic; default true\nline3type line type around sub image for 3d mosaic; default (:yellow)\nmosaic_npad # of pixel padding for mosaic view; default 1\nfft0 if true use FFTView to display (2D only); default false\ntitle; default \"\"\nxlabel; default nothing (or units if applicable)\nylabel; default nothing\nyflip; default true if minimum(y) >= 0\nyreverse; default true if y[1] > y[end]\nx values for x axis; default collect(axes(z)[1])\ny values for y axis; default collect(axes(z)[2])\nxticks; default [minimum(x),maximum(x)] (usually)\nyticks; default [minimum(y),maximum(y)]\n\nout\n\nreturns plot handle, type Plots.Plot\n\n2019-02-23 Jeff Fessler, University of Michigan\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{AbstractVector{T} where T, Any, Any, AbstractString}","page":"Home","title":"MIRTjim.jim","text":"jim(x, y, z, title::String ; kwargs...)\n\nAllow title as positional argument for convenience.\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{AbstractVector{var\"#s78\"} where var\"#s78\"<:Number, AbstractVector{var\"#s77\"} where var\"#s77\"<:Number, Any}","page":"Home","title":"MIRTjim.jim","text":"jim(x, y, z ; kwargs...)\n\nThe x and y axes can be Unitful thanks to UnitfulRecipes.\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Plots.Plot, Vararg{Any, N} where N}","page":"Home","title":"MIRTjim.jim","text":"jim(plot1, plot2, ... ; kwargs...)\n\nSubplot-type layout\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Symbol, Any}","page":"Home","title":"MIRTjim.jim","text":"jim(key::Symbol, value::Any)\n\nset default value for one of the keys\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.jim-Tuple{Symbol}","page":"Home","title":"MIRTjim.jim","text":"jim(:test::Symbol)\n\njim(:keys) return default keys\n\njim(:defs) return Dict of default keys / vals\n\njim(:key) return Dict[key] if possible\n\njim(:reset) reset to defaults\n\njim(:push!) push! current defaults to the stack\n\njim(:pop!) pop! defaults from the stack\n\njim(:blank) return blank plot\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.nothing_else-Tuple{Any, Any}","page":"Home","title":"MIRTjim.nothing_else","text":"nothing_else(x, y)\n\nreturn y if x is nothing, else return x\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.prompt-Tuple{Symbol}","page":"Home","title":"MIRTjim.prompt","text":"prompt(key::symbol)\n\nSet prompt state to one of:\n\n:prompt call gui() if possible, then prompt user.\n:draw call gui() if possible, then continue.\n:nodraw do not call gui(), just continue.\n\nUse prompt(:state) to query current state.\n\nActually it calls display(plot!()) instead of gui()\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.prompt-Tuple{}","page":"Home","title":"MIRTjim.prompt","text":"prompt( ; gui::Bool=true)\n\nPrompt user to hit any key to continue, after gui(). Some keys have special actions: [q]uit [d]raw [n]odraw. Call prompt(:prompt) to revert to default.\n\n\n\n\n\n","category":"method"},{"location":"#MIRTjim.wait_for_key-Tuple{}","page":"Home","title":"MIRTjim.wait_for_key","text":"function wait_for_key( ; io_in = stdin, io_out = stdout, prompt=?)\n\nFrom: https://discourse.julialang.org/t/wait-for-a-keypress/20218\n\n\n\n\n\n","category":"method"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"EditURL = \"https://github.com/JeffFessler/MIRTjim.jl/blob/master/docs/lit/examples/1-examples.jl\"","category":"page"},{"location":"examples/1-examples/#examples","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"(Image: ) (Image: )","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"note: Note\nThese examples are available as Jupyter notebooks. You can execute them online with binder or just view them with nbviewer by clicking on the badges above!","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"These examples illustrate how to use MIRTjim.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"First we tell Julia we are using this package,","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"using MIRTjim: jim, prompt","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"The following is helpful when running this example.jl file as a script; this way it will prompt user to hit a key after each image is displayed.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"isinteractive() && jim(:prompt, true)","category":"page"},{"location":"examples/1-examples/#Simple-2D-image","page":"Examples","title":"Simple 2D image","text":"","category":"section"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"The simplest example is a 2D array. Note that jim is designed to show a function f(x,y) sampled as an array z[x,y] so the 1st index is horizontal direction.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"x, y = 1:9, 1:7\nf(x,y) = x * (y-4)^2\nz = f.(x, y') # 9 × 7 array\njim(z ; xlabel=\"x\", ylabel=\"y\", title=\"f(x,y) = x * (y-4)^2\")","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"Compare with Plots.heatmap to see the differences (transpose, color, wrong aspect ratio, distractingly many ticks):","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"import Plots\nPlots.heatmap(z, title=\"heatmap\")\nisinteractive() && prompt()","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"Images often should include a title, so title = is optional.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"jim(z, \"hello\")","category":"page"},{"location":"examples/1-examples/#OffsetArrays","page":"Examples","title":"OffsetArrays","text":"","category":"section"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"jim displays the axes naturally.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"using OffsetArrays\nzo = OffsetArray(z, (-3,-1))\njim(zo, \"OffsetArray example\")","category":"page"},{"location":"examples/1-examples/#D-arrays","page":"Examples","title":"3D arrays","text":"","category":"section"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"jim automatically makes 3D arrays into a mosaic.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"z3 = reshape(1:(9*7*6), (9, 7, 6))\njim(z3, \"3D\")","category":"page"},{"location":"examples/1-examples/#Units","page":"Examples","title":"Units","text":"","category":"section"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"jim supports units, with axis and colorbar units appended naturally, thanks to UnitfulRecipes.jl. (The ylabel may be not visible in the web Documentation but does appear properly when run locally.)","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"using Unitful\n\nx = (1:9)u\"m/s\"\ny = (1:7)u\"s\"\nzu = x * y'\njim(x, y, zu, \"units\" ;\n    clim=(0,40).*u\"m\", xlabel=\"rate\", ylabel=\"time\", colorbar_title=\"distance\")","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"See UnitfulRecipes.jl to customize the units","category":"page"},{"location":"examples/1-examples/#Options","page":"Examples","title":"Options","text":"","category":"section"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"See the docstring for jim for the many options.  Here are some defaults.","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"jim(:defs)","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"One can set \"global\" defaults using appropriate keywords from above list. Use :push and pop: for such changes to be temporary","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"jim(:push!) # save current defaults\njim(:colorbar, :none) # disable colorbar for subsequent figures\njim(:yflip, false) # have \"y\" axis increase upward\njim(rand(9,7), \"rand\")\njim(:pop!) # restore","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"","category":"page"},{"location":"examples/1-examples/","page":"Examples","title":"Examples","text":"This page was generated using Literate.jl.","category":"page"}]
}
