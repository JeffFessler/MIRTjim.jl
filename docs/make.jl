# push!(LOAD_PATH,"../src/")

using MIRTjim
using Documenter

DocMeta.setdocmeta!(MIRTjim, :DocTestSetup, :(using MIRTjim); recursive=true)

makedocs(;
    modules = [MIRTjim],
    authors = "Jeff Fessler <fessler@umich.edu> and contributors",
    repo = "https://github.com/JeffFessler/MIRTjim.jl/blob/{commit}{path}#{line}",
    sitename = "MIRTjim.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", "false") == "true",
#       canonical = "https://JeffFessler.github.io/MIRTjim.jl/stable",
#       assets = String[],
    ),
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo = "github.com/JeffFessler/MIRTjim.jl.git",
    devbranch = "main",
    devurl = "dev",
    versions = ["stable" => "v#.#.#", "dev" => "dev"]
#   push_preview = true,
)
