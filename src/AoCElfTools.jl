module AoCElfTools

foreach(include, readdir(joinpath(@__DIR__, "2022"); join=true))

parse_solve(i) = solve(Val(i)) ∘ parse_input(Val(i))

export parse_input
export solve
export parse_solve

end
