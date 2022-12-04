using AoCElfTools
using Documenter

DocMeta.setdocmeta!(AoCElfTools, :DocTestSetup, :(using AoCElfTools); recursive=true)

makedocs(;
    modules=[AoCElfTools],
    authors="Patrick Bouffard and contributors",
    repo="https://github.com/pbouffard/AoCElfTools.jl/blob/{commit}{path}#{line}",
    sitename="AoCElfTools.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://pbouffard.github.io/AoCElfTools.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/pbouffard.github.io/AoCElfTools.jl",
    devbranch="main",
)
