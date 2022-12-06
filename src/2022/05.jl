module Day5

import ..parseday
import ..solveday

function parse_crates(input)
    lines = split(input, '\n')
    stacks = [Char[] for _ in 1:(length(first(lines))+1)÷4]
    for line in reverse(lines), j in findall(in('A':'Z'), line)
        push!(stacks[1+div(j-2, 4)], line[j])
    end
    return stacks
end

function parse_instructions(input)
    parse_line(line) = parse.(Int, match(r"move (\d+) from (\d+) to (\d+)", line).captures)
    return [parse_line(line) for line in split(input, '\n')]
end

"""
    parseday(::Val{5}) -> (IO -> Tuple{Vector{Vector{Char}}, Vector{Vector{Int64}}})

Parse Day 5's puzzle input.

# Examples
```jldoctest
julia> stacks, instructions = open(parseday(Val(5)), samplepath(5));

julia> stacks
3-element Vector{Vector{Char}}:
 ['Z', 'N']
 ['M', 'C', 'D']
 ['P']

julia> instructions
4-element Vector{Vector{Int64}}:
 [1, 2, 1]
 [3, 1, 3]
 [2, 2, 1]
 [1, 1, 2]
```
"""
function parseday(::Val{5})
    function f(io)
        crate_raw, instr_raw = split(read(io, String), "\n\n")
        stacks = parse_crates(crate_raw)
        instructions = parse_instructions(instr_raw)
        return stacks, instructions
    end
end

function operate1!(stacks, instructions)
    for (N, src, dest) in instructions
        for _ in 1:N push!(stacks[dest], pop!(stacks[src])) end
    end
    return stacks
end

function operate2!(stacks, instructions)
    crane = Char[]
    for (N, src, dest) in instructions
        for _ in 1:N push!(crane, pop!(stacks[src])) end
        for _ in 1:N push!(stacks[dest], pop!(crane)) end
    end
    return stacks
end

"""
    solveday(::Val{5}) -> (Tuple{Vector{Vector{Char}}, Vector{Vector{Int64}}} -> Tuple{String, String}})

Solve Day 5's puzzle:
- ans₁: message from top crates after operating CrateMover9000
- ans₂: message from top crates after operating CrateMover9001
```
"""
function solveday(::Val{5})
    function f(input)
        stacks, instructions = input
        ans₁ = operate1!(deepcopy(stacks), instructions) .|> last |> String
        ans₂ = operate2!(deepcopy(stacks), instructions) .|> last |> String
        return ans₁, ans₂
    end
end

end # module

using .Day5
