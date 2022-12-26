
datadir = joinpath(@__DIR__, "data")
year = splitpath(@__DIR__) |> last

foreach(readdir(@__DIR__; join=true)) do s
  if !isdir(s) && !endswith(s, "2022.jl")
    @info "Running tests from $(s) ..."
    include(s)
  end
end
