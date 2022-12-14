module Day7

import ..parseday
import ..solveday

_cd(dir, dirstack) = dir == ".." ? pop!(dirstack) : push!(dirstack, dir)

function _ls(line, dirstack, subdirs, contents)
    cwd = joinpath(dirstack...)
    subdirs[cwd] = String[]
    contents[cwd] = String[]
    for l in split(line, '\n')
        if startswith(l, "dir ")
            push!(subdirs[cwd], joinpath(cwd, l[5:end]))
        elseif startswith(l, r"\d")
            push!(contents[cwd], l)
        end
    end
end

fsize(f) = parse(Int, first(split(f)))
function dirsize(dir, subdirs, contents)
    filetotal = sum(fsize, contents[dir]; init=0)
    # dirsize(dir) = dirsize(dir, subdirs, contents)
    dirtotal = sum(dir -> dirsize(dir, subdirs, contents), subdirs[dir]; init=0)
    return filetotal + dirtotal
end

"""
    parseday(::Val{7}) -> (IO -> Tuple{Vector{Vector{Char}}, Vector{Vector{Int64}}})

Parse Day 7's puzzle input.

# Examples
"""
function parseday(::Val{7})
    function f(io)
        cmds = split(read(io, String), "\$ "; keepempty=false)
        dirstack = String[]
        subdirs = Dict{String, Vector{String}}()
        contents = Dict{String, Vector{String}}()
        for cmd in cmds
            if startswith(cmd, "cd")
                _cd(strip(cmd[4:end]), dirstack)
            elseif startswith(cmd, "ls")
                _ls(cmd[3:end], dirstack, subdirs, contents)
            end
        end
        return subdirs, contents
    end
end

"""
    solveday(::Val{7}) -> ()

Solve Day 7's puzzle:
- ans₁: total size of all directories under 100000
- ans₂: message from top crates after operating CrateMover9001
"""
function solveday(::Val{7})
    function f(input)
        subdirs, contents = input
        dirsizes = [dirsize(k, subdirs, contents) for k in keys(subdirs)]
        needed = 30000000 - (70000000 - dirsize("/", subdirs, contents))

        ans₁ = filter(<=(100000), dirsizes) |> sum
        ans₂ = filter(>=(needed), dirsizes) |> minimum
        return ans₁, ans₂
    end
end

end # module

using .Day7
