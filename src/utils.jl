"""
    samplepath(i) -> String

Return the path to the sample input file for Day `i`.

# Examples
```jldoctest
julia> samplepath(1)
"test/data/sample/01.txt"

julia> samplepath(14)
"test/data/sample/14.txt"
```
"""
function samplepath(i)
    istr = @sprintf("%02d", i)
    return joinpath("test", "data", "sample", "$istr.txt")
end
