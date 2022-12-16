#! julia --project=tools/ --startup-file=no 
using JuliaFormatter
path = abspath(joinpath(@__DIR__, ".."))
@info "Formatting files at $(path)..."
format(path; verbose=true)
