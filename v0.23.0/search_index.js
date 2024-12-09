var documenterSearchIndex = {"docs":
[{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"EditURL = \"https://github.com/JeffFessler/MIRTjim.jl/blob/main/docs/lit/examples/2-yflip.jl\"","category":"page"},{"location":"generated/examples/2-yflip/#yflip","page":"Option yflip","title":"Option yflip","text":"","category":"section"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"Examples illustrating the yflip option in the Julia package MIRTjim.","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"This page comes from a single Julia file: 2-yflip.jl.","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"You can access the source code for such Julia documentation using the 'Edit on GitHub' link in the top right. You can view the corresponding notebook in nbviewer here: 2-yflip.ipynb, or open it in binder here: 2-yflip.ipynb.","category":"page"},{"location":"generated/examples/2-yflip/#Setup","page":"Option yflip","title":"Setup","text":"","category":"section"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"Packages needed here.","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"using MIRTjim: jim, prompt\nusing ImageGeoms: ImageGeom\nusing ImagePhantoms: shepp_logan, SheppLoganEmis, phantom\nusing InteractiveUtils: versioninfo","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"The following line is helpful when running this file as a script; this way it will prompt user to hit a key after each figure is displayed.","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"isinteractive() ? jim(:prompt, true) : prompt(:draw);\nnothing #hide","category":"page"},{"location":"generated/examples/2-yflip/#Simple-2D-image-and-3D-stack-of-images","page":"Option yflip","title":"Simple 2D image and 3D stack of images","text":"","category":"section"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"i1 = shepp_logan(128, SheppLoganEmis()) # 2D image\ni1 = i1[12:117,:] # non-square for illustration\ni2 = cat(dims=3, i1, 2i1, 3i1)/3 # 3D stack of images\nsize(i2)","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"This figure illustrates how the yflip option affects the image orientation in the \"usual\" case where y=1:N. This is a typical convention in \"image processing\" of digital images that lack any physical coordinates for their axes.","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"ji = (args...; kwargs...) -> jim(args...; kwargs..., prompt=false)\njim(\n    ji(i1, \"2D default\"),\n    ji(i1, yflip=false, \"2D yflip=false\"),\n    ji(i1, yflip=true, \"2D yflip=true\"),\n    ji(i2, ncol=2, \"3D default\"),\n    ji(i2, ncol=2, yflip=false, \"3D yflip=false\"),\n    ji(i2, ncol=2, yflip=true, \"3D yflip=true\"),\n)","category":"page"},{"location":"generated/examples/2-yflip/#D-image-and-3D-stack-of-images-with-specified-x,y-coordinates","page":"Option yflip","title":"2D image and 3D stack of images with specified x,y coordinates","text":"","category":"section"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"Now consider the case where we think of the image as a function f(x,y) in the typical case where 0,0 is in the \"center\" of the image. This convention is more common in physics-based imaging and inverse problems where the image axes have meaningful values (and often have units).","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"objects = shepp_logan(SheppLoganEmis(); fovs=(120,120))\nig = ImageGeom(dims=(50,64), deltas=(2,2), offsets=(0.5,0.5))\nax = axes(ig)\ni3 = phantom(ax..., objects)\ni4 = cat(dims=3, i3, 2i3, 3i3) # 3D stack of images\n\njim(\n    ji(ax, i3, \"2D default\", xlabel=\"x\", ylabel=\"y\"),\n    ji(ax, i3, yflip=false, \"2D yflip=false\"),\n    ji(ax, i3, yflip=true, \"2D yflip=true\"),\n    ji(ax, i4, ncol=2, \"3D default\"),\n    ji(ax, i4, ncol=2, yflip=false, \"3D yflip=false\"),\n    ji(ax, i4, ncol=2, yflip=true, \"3D yflip=true\"),\n    prompt = false, gui = true,\n)","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"In both cases the \"default\" option for yflip has the typical desired behavior, but one can modify the default to achieve other behaviors.","category":"page"},{"location":"generated/examples/2-yflip/#Reproducibility","page":"Option yflip","title":"Reproducibility","text":"","category":"section"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"This page was generated with the following version of Julia:","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"using InteractiveUtils: versioninfo\nio = IOBuffer(); versioninfo(io); split(String(take!(io)), '\\n')","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"And with the following package versions","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"import Pkg; Pkg.status()","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"","category":"page"},{"location":"generated/examples/2-yflip/","page":"Option yflip","title":"Option yflip","text":"This page was generated using Literate.jl.","category":"page"},{"location":"methods/#Methods-list","page":"Methods","title":"Methods list","text":"","category":"section"},{"location":"methods/","page":"Methods","title":"Methods","text":"","category":"page"},{"location":"methods/#Methods-usage","page":"Methods","title":"Methods usage","text":"","category":"section"},{"location":"methods/","page":"Methods","title":"Methods","text":"Modules = [MIRTjim]","category":"page"},{"location":"methods/#MIRTjim.MIRTjim","page":"Methods","title":"MIRTjim.MIRTjim","text":"Module MIRTjim exports the \"jiffy image display\" method jim, and the two helper methods caller_name and prompt.\n\n\n\n\n\n","category":"module"},{"location":"methods/#MIRTjim.jim_def","page":"Methods","title":"MIRTjim.jim_def","text":"jim_def\n\nGlobal Dict of default settings.\n\n\n\n\n\n","category":"constant"},{"location":"methods/#MIRTjim.jim_stack","page":"Methods","title":"MIRTjim.jim_stack","text":"jim_stack\n\nGlobal Vector{Any} used with :push! and :pop! to store and retrieve settings.\n\n\n\n\n\n","category":"constant"},{"location":"methods/#MIRTjim._aspect_ratio-Tuple{Any, Any}","page":"Methods","title":"MIRTjim._aspect_ratio","text":"_aspect_ratio(x, y)\n\nDetermine aspect_ratio argument for heatmap.\n\nThe user can set the default by invoking (e.g.) jim(:aspect_ratio, :equal).\n\nOtherwise, the default from jim_def[:aspect_ratio] is :infer, which will lead to :equal if x and y have the same units, or if Δx ≈ Δy (square pixels). Otherwise revert to :auto.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.caller_name-Tuple{}","page":"Methods","title":"MIRTjim.caller_name","text":"caller_name() or caller_name(;level=4)\n\nReturn \"filename line fun():\" as a string to describe where this function was called.\n\nStack levels:\n\n1: #caller_name\n2: caller_name()\n3: function that invoked caller()\n4: the calling function we want to return\n\nHence the default level is 4, but we increment it by one in case user says @show caller_name() in which case stack[3] is a macro expansion.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractArray, AbstractString}","page":"Methods","title":"MIRTjim.jim","text":"jim(z, title::String ; kwargs...)\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractArray{<:AbstractArray{<:Union{Number, ColorTypes.Colorant}}}}","page":"Methods","title":"MIRTjim.jim","text":"jim(z::AbstractArray{<:AbstractArray{<:Union{Number,Colorant}}} ; kwargs...)\n\nDisplay an array of images. Same arguments and options as display of a 3D stack of images. The argument ratio defaults to /(Plots.default(:size)...) and affects the default ncol value.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractArray{<:Union{Tuple{Vararg{Number, N}} where N, AbstractVector{<:Number}}}}","page":"Methods","title":"MIRTjim.jim","text":"jim(..., z::AbstractArray{<:NTuple{N,Number} where N}, ... ; kwargs...)\njim(..., z::AbstractArray{<:AbstractVector{<:Number}}, ... ; kwargs...)\n\nStack Tuple or Vector along the last dimension.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractMatrix{<:ColorTypes.Colorant}}","page":"Methods","title":"MIRTjim.jim","text":"jim(z::Matrix{<:Colorant}; kwargs...)\n\nFor RGB images, ignore clim, color, x, y.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractMatrix{<:Number}}","page":"Methods","title":"MIRTjim.jim","text":"jim(z, ...)\n\nA jiffy image display of z using heatmap.\n\nin\n\nz image, can be 2D or higher, if higher then it uses mosaicviews\n\noption\n\naspect_ratio; default :equal for square pixels (see _aspect_ratio)\nclim; default (minimum(z),maximum(z))\ncolor (colormap, e.g. :hsv); default :grays\ncolorbar (e.g. :none); default :legend\ngui call Plots.gui() immediately?; default false\nprompt call prompt() immediately?; default false\nncol for mosaicview for 3D and higher arrays; default 0 does auto select  \"Number of tiles in column direction.\"\nnrow for mosaicview for 3D and higher arrays; default 0 does auto select\npadval padding value for mosaic view; default minimum(z)\nline3plot lines around sub image for 3d mosaic; default true\nline3type line type around sub image for 3d mosaic; default (:yellow)\nmosaic_npad # of pixel padding for mosaic view; default 1\nfft0 if true use FFTView to display (2D only); default false\ntitle; default \"\"\nxlabel; default nothing (or units if applicable)\nylabel; default nothing\nyflip; default true if minimum(y) >= 0\nyreverse; default true if y[1] > y[end]\nx values for x axis; default collect(axes(z)[1])\ny values for y axis; default collect(axes(z)[2])\nxticks; default [minimum(x),maximum(x)] (usually)\nyticks; default [minimum(y),maximum(y)]\n\nout\n\nreturns plot handle, type Plots.Plot\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractVector{<:Number}, AbstractVector{<:Number}, AbstractVector{<:Number}, AbstractArray}","page":"Methods","title":"MIRTjim.jim","text":"jim(x, y, z, array3d, [title] ; kwargs...)\n\nAllow user to provide the \"z axis\" of a 3D array, but ignore it without warning.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractVector{<:Number}, AbstractVector{<:Number}, Any, AbstractString}","page":"Methods","title":"MIRTjim.jim","text":"jim(x, y, z, title::String ; kwargs...)\n\nAllow title as positional argument for convenience.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{AbstractVector{<:Number}, AbstractVector{<:Number}, Any}","page":"Methods","title":"MIRTjim.jim","text":"jim(x, y, z ; kwargs...)\n\nThe x and y axes can be Unitful.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{Plots.Plot, Vararg{Any}}","page":"Methods","title":"MIRTjim.jim","text":"jim(plot1, plot2, ... ; gui=?, prompt=?, kwargs...)\n\nSubplot-type layout, where kwargs are passed to plot.\n\ngui call Plots.gui() immediately?; default false\nprompt call prompt() immediately?; default false\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{Symbol, Any}","page":"Methods","title":"MIRTjim.jim","text":"jim(key::Symbol, value::Any)\n\nSet default value for one of the keys.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{Symbol}","page":"Methods","title":"MIRTjim.jim","text":"jim(:test::Symbol)\n\njim(:keys) return default keys.\n\njim(:defs) return Dict of default keys / vals.\n\njim(:key) return Dict[key] if possible.\n\njim(:reset) reset to defaults.\n\njim(:push!) push! current defaults to the stack.\n\njim(:pop!) pop! defaults from the stack.\n\njim(:blank) return blank plot.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.jim-Tuple{Tuple, Any}","page":"Methods","title":"MIRTjim.jim","text":"jim(axes::Tuple, array, [title] ; kwargs...)\n\nAllow user to provide the axes of array. (Only x = axes[1] and y = axes[2] are used.)\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.mid3-Union{Tuple{AbstractArray{T, 3}}, Tuple{T}} where T","page":"Methods","title":"MIRTjim.mid3","text":"mid3(a::AbstractArray{T,3})\n\nExtract the \"middle\" slices (transaxial, coronal, sagittal) and arrange in a 2D mosaic for quick display of 3D array.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.nothing_else-Tuple{Any, Any}","page":"Methods","title":"MIRTjim.nothing_else","text":"nothing_else(x, y)\n\nReturn y if x is nothing, else return x.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.prompt-Tuple{Symbol}","page":"Methods","title":"MIRTjim.prompt","text":"prompt(key::symbol)\n\nSet prompt state to one of:\n\n:prompt call gui() if possible, then prompt user.\n:draw call gui() if possible, then continue.\n:nodraw do not call gui(), just continue.\n\nUse prompt(:state) to query current state.\n\nActually it calls display(plot!()) instead of gui().\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.prompt-Tuple{}","page":"Methods","title":"MIRTjim.prompt","text":"prompt( ; gui::Bool=true)\n\nPrompt user to hit any key to continue, after gui(). Some keys have special actions: [q]uit [d]raw [n]odraw. Call prompt(:prompt) to revert to default.\n\n\n\n\n\n","category":"method"},{"location":"methods/#MIRTjim.wait_for_key-Tuple{}","page":"Methods","title":"MIRTjim.wait_for_key","text":"function wait_for_key( ; io_in = stdin, io_out = stdout, prompt=?)\n\nFrom discourse.\n\n\n\n\n\n","category":"method"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"EditURL = \"https://github.com/JeffFessler/MIRTjim.jl/blob/main/docs/lit/examples/1-examples.jl\"","category":"page"},{"location":"generated/examples/1-examples/#examples","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"This page illustrates the Julia package MIRTjim.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"This page comes from a single Julia file: 1-examples.jl.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"You can access the source code for such Julia documentation using the 'Edit on GitHub' link in the top right. You can view the corresponding notebook in nbviewer here: 1-examples.ipynb, or open it in binder here: 1-examples.ipynb.","category":"page"},{"location":"generated/examples/1-examples/#Setup","page":"Examples","title":"Setup","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Packages needed here.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"using MIRTjim: jim, prompt\nusing AxisArrays: AxisArray\nusing ColorTypes: RGB\nusing OffsetArrays: OffsetArray\nusing Unitful\nusing Unitful: μm, s\nimport Plots\nusing InteractiveUtils: versioninfo","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"The following line is helpful when running this file as a script; this way it will prompt user to hit a key after each figure is displayed.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"isinteractive() ? jim(:prompt, true) : prompt(:draw);\nnothing #hide","category":"page"},{"location":"generated/examples/1-examples/#Simple-2D-image","page":"Examples","title":"Simple 2D image","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"The simplest example is a 2D array. Note that jim is designed to show a function f(x,y) sampled as an array z[x,y] so the 1st index is horizontal direction.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"x, y = 1:9, 1:7\nf(x,y) = x * (y-4)^2\nz = f.(x, y') # 9 × 7 array\njim(z ; xlabel=\"x\", ylabel=\"y\", title=\"f(x,y) = x * (y-4)^2\")","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Compare with Plots.heatmap to see the differences (transpose, color, wrong aspect ratio, distractingly many ticks):","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Plots.heatmap(z, title=\"heatmap\")","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"isinteractive() && prompt();\nnothing #hide","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Images often should include a title, so title = is optional.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim(z, \"hello\")","category":"page"},{"location":"generated/examples/1-examples/#OffsetArrays","page":"Examples","title":"OffsetArrays","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim displays the axes naturally.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"zo = OffsetArray(z, (-3,-1))\njim(zo, \"OffsetArray example\")","category":"page"},{"location":"generated/examples/1-examples/#D-arrays","page":"Examples","title":"3D arrays","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim automatically makes 3D arrays into a mosaic.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"f3 = reshape(1:(9*7*6), (9, 7, 6))\njim(f3, \"3D\")","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"One can specify how many images per row or column for such a mosaic.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"x11 = reshape(1:(5*6*11), (5, 6, 11))\njim(x11, \"nrow=3\"; nrow=3)","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim(x11, \"ncol=6\"; ncol=6)","category":"page"},{"location":"generated/examples/1-examples/#Arrays-of-images","page":"Examples","title":"Arrays of images","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim automatically makes arrays of images into a mosaic.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"z3 = reshape(1:(9*7*6), (7, 9, 6))\nz4 = [z3[:,:,(j-1)*3+i] for i=1:3, j=1:2]\njim(z4, \"Arrays of images\")","category":"page"},{"location":"generated/examples/1-examples/#Units","page":"Examples","title":"Units","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim supports units, with axis and colorbar units appended naturally.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"x = 0.1*(1:9)u\"m/s\"\ny = (1:7)u\"s\"\nzu = x * y'\njim(x, y, zu, \"units\" ;\n    clim=(0,7).*u\"m\", xlabel=\"rate\", ylabel=\"time\", colorbar_title=\"distance\")","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Note that aspect_ratio reverts to :auto when axis units differ.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Image spacing is appropriate even for non-square pixels if Δx and Δy have matching units.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"x = range(-2,2,201) * 1u\"m\"\ny = range(-1.2,1.2,150) * 1u\"m\" # Δy ≢ Δx\nz = @. sqrt(x^2 + (y')^2) ≤ 1u\"m\"\njim(x, y, z, \"Axis units with unequal spacing\"; color=:cividis)","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"Units are also supported for 3D arrays, but the z-axis is ignored for plotting.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"x = (2:9) * 1μm\ny = (3:8) * 1/s\nz = (4:7) * 1μm * 1s\nf3d = rand(8, 6, 4) # * s^2\njim(x, y, z, f3d, \"3D with axis units\")","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"One can use a tuple for the axes instead; only the x and y axes are used.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim((x, y, z), f3d, \"axes tuple\")","category":"page"},{"location":"generated/examples/1-examples/#AxisArrays","page":"Examples","title":"AxisArrays","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim displays the axes (names and units) naturally by default:","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"x = (1:9)μm\ny = (1:7)μm/s\nza = AxisArray(x * y'; x, y)\njim(za, \"AxisArray\")","category":"page"},{"location":"generated/examples/1-examples/#Color-images","page":"Examples","title":"Color images","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim(rand(RGB{Float32}, 8, 6); title=\"RGB image\")","category":"page"},{"location":"generated/examples/1-examples/#Options","page":"Examples","title":"Options","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"See the docstring for jim for its many options. Here are some defaults.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim(:defs)","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"One can set \"global\" defaults using appropriate keywords from above list. Use :push! and :pop! for such changes to be temporary.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim(:push!) # save current defaults\njim(:colorbar, :none) # disable colorbar for subsequent figures\njim(:yflip, false) # have \"y\" axis increase upward\njim(rand(9,7), \"rand\", color=:viridis) # kwargs... passed to heatmap()","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"jim(:pop!); # restore\nnothing #hide","category":"page"},{"location":"generated/examples/1-examples/#Layout","page":"Examples","title":"Layout","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"One can use jim just like plot with a layout of subplots. The gui=true option is useful when you want a figure to appear even when other code follows. Often it is used with the prompt=true option (not shown here). The size option helps avoid excess borders.","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"p1 = jim(rand(5,7); prompt=false)\np2 = jim(rand(6,8); color=:viridis, prompt=false)\np3 = jim(rand(9,7); color=:cividis, title=\"plot 3\", prompt=false)\njim(p1, p2, p3; layout=(1,3), gui=true, size = (600,200))","category":"page"},{"location":"generated/examples/1-examples/#Reproducibility","page":"Examples","title":"Reproducibility","text":"","category":"section"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"This page was generated with the following version of Julia:","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"using InteractiveUtils: versioninfo\nio = IOBuffer(); versioninfo(io); split(String(take!(io)), '\\n')","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"And with the following package versions","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"import Pkg; Pkg.status()","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"","category":"page"},{"location":"generated/examples/1-examples/","page":"Examples","title":"Examples","text":"This page was generated using Literate.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = MIRTjim","category":"page"},{"location":"#MIRTjim.jl-Documentation","page":"Home","title":"MIRTjim.jl Documentation","text":"","category":"section"},{"location":"#Contents","page":"Home","title":"Contents","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"This Julia module MIRTjim.jl exports a function jim (jiffy image display) for convenient display of a grayscale image.","category":"page"},{"location":"","page":"Home","title":"Home","text":"This function was originally designed for the Michigan Image Reconstruction Toolbox (MIRT) and for JuliaImageRecon, where most results are images that one will want to display.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Also exported is the prompt function that (by default) pauses for a user to press a key before continuing, which is useful in scripts.","category":"page"},{"location":"","page":"Home","title":"Home","text":"See the \"Examples\" for details.","category":"page"}]
}
