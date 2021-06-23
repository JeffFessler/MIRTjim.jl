# push!(LOAD_PATH,"../src/")

using MIRTjim
using Documenter
using Literate

# based on:
# https://github.com/jw3126/UnitfulRecipes.jl/blob/master/docs/make.jl

# generate tutorials and how-to guides using Literate
lit = joinpath(@__DIR__, "lit")
src = joinpath(@__DIR__, "src")
notebooks = joinpath(src, "notebooks")

ENV["GKS_ENCODING"] = "utf-8"

DocMeta.setdocmeta!(MIRTjim, :DocTestSetup, :(using MIRTjim); recursive=true)

execute = true # Set to true for executing notebooks and documenter!
nb = false # Set to true to generate the notebooks
for (root, _, files) in walkdir(lit), file in files
    splitext(file)[2] == ".jl" || continue
    ipath = joinpath(root, file)
    opath = splitdir(replace(ipath, lit=>src))[1]
    Literate.markdown(ipath, opath, documenter = execute)
    nb && Literate.notebook(ipath, notebooks, execute = execute)
end

# Documentation structure
ismd(f) = splitext(f)[2] == ".md"
pages(folder) =
    [joinpath(folder, f) for f in readdir(joinpath(src, folder)) if ismd(f)]


makedocs(;
    modules = [MIRTjim],
    authors = "Jeff Fessler and contributors",
    repo = "https://github.com/JeffFessler/MIRTjim.jl/blob/{commit}{path}#{line}",
    sitename = "MIRTjim.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
#       canonical = "https://JeffFessler.github.io/MIRTjim.jl/stable",
#       assets = String[],
    ),
    pages = [
        "Home" => "index.md",
        "Examples" => pages("examples")
    ],
)

deploydocs(;
    repo = "github.com/JeffFessler/MIRTjim.jl.git",
    devbranch = "main",
    devurl = "dev",
    versions = ["stable" => "v^", "dev" => "dev"]
#   push_preview = true,
)
