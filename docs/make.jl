using AoCElfTools
using Documenter

DocMeta.setdocmeta!(AoCElfTools, :DocTestSetup, :(using AoCElfTools); recursive=true)

makedocs(;
    modules=[AoCElfTools],
    authors="Patrick Bouffard and contributors",
    repo="https://github.com/bouffard@eecs.berkeley.edu/AoCElfTools.jl/blob/{commit}{path}#{line}",
    sitename="AoCElfTools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://bouffard@eecs.berkeley.edu.github.io/AoCElfTools.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/bouffard@eecs.berkeley.edu/AoCElfTools.jl",
    devbranch="main",
)
