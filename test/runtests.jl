using AoCElfTools
using AoCElfTools: samplepath, userpath
using Test
using Printf

datadir = joinpath(@__DIR__, "data")

function check_day(filepath)
    istr = filepath |> basename |> splitext |> first
    return parse(Int, istr), istr
end

@testset verbose=true "2022" begin
    foreach(include, readdir("2022"; join=true))
end
