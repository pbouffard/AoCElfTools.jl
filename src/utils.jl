"""
    samplepath(i::Int) -> String

Return the path to the sample input file for Day `i`.

# Examples
```jldoctest
julia> samplepath(1)
"test/data/sample/01.txt"

julia> samplepath(14)
"test/data/sample/14.txt"
```
"""
function samplepath(i::Int)
    istr = @sprintf("%02d", i)
    return joinpath("test", "data", "sample", "$istr.txt")
end


"""
    userpath(user, i::Int) -> String

Return the path to `user`'s input file for Day `i`.

# Examples
```jldoctest
julia> userpath("jbshannon", 1)
"test/data/jbshannon/01.txt"

julia> userpath("jbshannon", 13)
"test/data/jbshannon/13.txt"
```
"""
function userpath(user, i::Int)
    istr = @sprintf("%02d", i)
    return joinpath("test", "data", user, "$istr.txt")
end
