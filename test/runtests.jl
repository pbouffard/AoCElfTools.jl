using AoCElfTools
using Test

testdatadir() = joinpath(@__DIR__, "testdata")
testfile(name) = joinpath(testdatadir(), name)

@testset "Test tests" begin
  @test 42 == 42
end

# 2022
@testset "Day1, $inputfile, $expectedanswer" for (inputfile, expectedanswer) in (
  "day01.txt" => 24000,
  "day01aoc.txt" => 66487)

  @test AoCElfTools.AoC2022.mostcalories(readlines(testfile(inputfile))) == expectedanswer

end
