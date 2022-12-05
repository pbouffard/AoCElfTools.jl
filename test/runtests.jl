using AoCElfTools
using Test
using Printf

datadir = joinpath(@__DIR__, "data")

function check_day(filepath)
    istr = filepath |> basename |> splitext |> first
    return parse(Int, istr), istr
end

foreach(include, readdir("2022"; join=true))
