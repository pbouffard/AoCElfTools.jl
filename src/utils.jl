const DATA_DIR = joinpath(dirname(@__DIR__), "..","test", "data")

"""
    samplepath(i::Int, year::Int) -> String

Return the path to the sample input file for Day `i` of Year `year`

# Examples
```
julia> samplepath(1, 2022)
"test/2022/data/sample/01.txt"

julia> samplepath(14, 2022)
"test/2022/data/sample/14.txt"
```
"""
function samplepath(i::Int, year::Int)
    istr = @sprintf("%02d", i)
    iyear = @sprintf("%04d", year)
    return relpath(joinpath(@__DIR__, "..", "test", iyear, "data", "sample", "$istr.txt"), pwd())
end


"""
    userpath(user, i::Int) -> String

Return the path to `user`'s input file for Day `i`.

# Examples
```
julia> userpath("jbshannon", 1)
"test/data/jbshannon/01.txt"

julia> userpath("jbshannon", 13)
"test/data/jbshannon/13.txt"
```
"""
function userpath(user, i::Int)
  istr = @sprintf("%02d", i)
  return relpath(joinpath(DATA_DIR, user, "$istr.txt"), pwd())
end
