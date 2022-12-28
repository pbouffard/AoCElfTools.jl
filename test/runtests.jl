using AoCElfTools
using AoCElfTools: samplepath, userpath
using Test
using Printf

include("io.jl")



"""
Helper function, expects a string input of the form "/path/to/YYYY/DD.jl" and returns a tuple of the day (DD) as an integer, the day as a string, and the year as an integer.
"""
function check_day(filepath)
  istr = filepath |> basename |> splitext |> first
  year = filepath |> splitdir |> first |> splitdir |> last
  return parse(Int, istr), istr, parse(Int, year)
end

@testset verbose = true begin
  for year in yearsavailable()
    include(joinpath(@__DIR__, string(year), string(year)) * ".jl")
  end
end
