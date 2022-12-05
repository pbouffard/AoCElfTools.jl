using AoCElfTools
using Test

import AoCElfTools.RockPaperScissors: RPS

testdatadir() = joinpath(@__DIR__, "testdata")
testfile(name) = joinpath(testdatadir(), name)

@testset "Test tests" begin
  @test 42 == 42
end

# 2022
@testset "Day1 Part 1, $inputfile, $expectedanswer" for (inputfile, expectedanswer) in (
  "day01.txt" => 24000,
  "day01aoc.txt" => 66487)

  @test AoCElfTools.AoC2022.mostcalories(readlines(testfile(inputfile))) == expectedanswer

end

@testset "Day1 Part 2" begin
  test_caloriescarried = [6000, 4000, 11000, 24000, 10000]
  test_result = AoCElfTools.AoC2022.caloriescarried(readlines(testfile("day01.txt")))
  @test test_result == test_caloriescarried
  @test sum(sort(test_result, rev=true)[1:3]) == 45000

  aoc_result = AoCElfTools.AoC2022.caloriescarried(readlines(testfile("day01aoc.txt")))
  @test sum(sort(aoc_result, rev=true)[1:3]) == 197301
end

using AoCElfTools.RockPaperScissors

@testset "Rock Paper Scissors: $a vs. $b" for ((a, b), result) in (
  (rock, paper) => false,
  (paper, scissors) => false,
  (paper, rock) => true,
)

  @test (a > b) == result
  @test (a < b) == !result

end

@testset "RPS: conversions" begin
  @test RPS('A') == RPS('X') == rock
  @test RPS('B') == RPS('Y') == paper
  @test RPS('C') == RPS('Z') == scissors
end