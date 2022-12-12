module AoCElfTools

# Project dependencies (from Base)
using Printf

# Abstract function to be extended for each day
function parseday end
function solveday end

# Include utility functions
include("utils.jl")

export samplepath
export userpath

const years = [2022]

# Include solution code
# for year in years
#   include(joinpath(@__DIR__, string(year), string(year)) * ".jl")
# end
include("2022/2022.jl")

"""
    parse_input(i::Int; year::Int) -> (IO -> puzzle input)

Returns a function that parses Day `i`'s of Year `year`'s puzzle input into a data structure that can then
be used to find a solution.

Designed to be passed as a first argument to `open`.

# Examples
```jldoctest
julia> input = "test/data/sample/01.txt";

julia> println(read(input, String))
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

julia> open(parse_input(1, 2022), input)
5-element Vector{Int64}:
  6000
  4000
 11000
 24000
 10000
```
"""
parse_input(i::Int, year::Int) = parseday(Val(i), Val(year))


"""
    solve(i::Int, year::Int) -> (puzzle input -> solution)

Returns a function that receive's Day `i` of Year `year`'s puzzle input and returns a solution as a `Tuple`
containing the two answers.

# Examples
```jldoctest
julia> input = open(parse_input(1, 2022), "test/data/sample/01.txt")
5-element Vector{Int64}:
  6000
  4000
 11000
 24000
 10000

julia> solve(1, 2022)(input)
(24000, 45000)
```
"""
solve(i::Int; year::Int) = solveday(Val(i), Val(year))


"""
    parse_solve(i::Int, year::Int) -> (IO -> solution)

Returns a function that combines the parsing and solution steps for Day `i` of Year `year`.

Designed to be passed as a first argument to `open`.

# Examples
```jldoctest
julia> input = "test/2022/data/sample/01.txt";

julia> println(read(input, String))
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

julia> open(parse_solve(1, 2022), input)
(24000, 45000)
```
"""
parse_solve(i::Int, year::Int) = solveday(Val(i), Val(year)) ∘ parseday(Val(i), Val(year))

export parse_input
export solve
export parse_solve

export parseday
export solveday

end
