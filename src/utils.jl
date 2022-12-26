const DATA_DIR = joinpath(dirname(@__DIR__), "..", "test", "data")

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
  return relpath(
    joinpath(@__DIR__, "..", "test", iyear, "data", "sample", "$istr.txt"),
    pwd(),
  )
end


"""
  userpath(user, i::Int, year::Int) -> String
  
Return the path to `user`'s input file for Day `i` of Year `year`.

# Examples
```
julia> userpath("jbshannon", 1, 2022)
"test/2022/data/jbshannon/01.txt"

julia> userpath("pbouffard", 2, 2018)
"test/2018/data/pbouffard/2.txt"
```
"""
function userpath(user, i::Int, year::Int)
  istr = @sprintf("%02d", i)
  iyear = @sprintf("%04d", year)
  return relpath(joinpath(@__DIR__, "..", "test", iyear, "data", user, "$istr.txt"), pwd())
end
