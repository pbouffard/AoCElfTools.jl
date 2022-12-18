
datadir = joinpath(@__DIR__, "data")

iobuffer_from_comma_sep_string(s) = IOBuffer(join(strip.(split(s, ",")), "\n") * "\n")

_YEAR = 2018
@testset "2018" begin

@testset "Day 1 - samples" begin
  # Samples as provided in problem

  # Part 1
  cases = ("+1, -2, +3, +1" => 3, "+1, +1, +1" => 3, "+1, +1, -2" => 0, "-1, -2, -3" => -6)

  for (input_str, correct_result) in cases
    @info "input_str = $(input_str)"
    @test solveday(Val(1), Val(_YEAR))(iobuffer_from_comma_sep_string(input_str); part=1) |>
          first == correct_result
  end

  # Part 2
  cases = (
    "+1, -2, +3, +1" => 2,
    "+1, -1" => 0,
    "+3, +3, +4, -2, -4" => 10,
    "-6, +3, +8, +5, -6" => 5,
    "+7, +7, -2, -7, -4" => 14,
  )

  for (input_str, correct_result) in cases
    @show input_str
    @test solveday(Val(1), Val(_YEAR))(iobuffer_from_comma_sep_string(input_str)) |> last ==
          correct_result
  end


end


@testset verbose = true "Day 2 - samples" begin
  # Samples as provided in problem

  # Part 1
  cases = ("abcdef, bababc, abbcde, abcccd, aabcdd, abcdee, ababab" => 12,)

  for (input_str, correct_result) in cases
    @info "input_str = $(input_str)"
    @test solveday(Val(2), Val(_YEAR))(iobuffer_from_comma_sep_string(input_str)) |>
          first == correct_result
  end

  # Part 2
  cases = ("abcde, fghij, klmno, pqrst, fguij, axcye, wvxyz" => "fgij",)

  for (input_str, correct_result) in cases
    @show input_str
    @test solveday(Val(2), Val(_YEAR))(iobuffer_from_comma_sep_string(input_str)) |> last ==
          correct_result
  end


end


@testset verbose = true "Day 3 - samples" begin
  import AoCElfTools.Year2018.Day3: parseline, covmap
  # Samples as provided in problem
  @test parseline("#123 @ 3,2: 5x4") == (123, (4, 3), (8, 6))
  @test parseline("#1 @ 1,3: 4x4") == (1, (2, 4), (5, 7))

  io = IOBuffer("""
                #1 @ 1,3: 4x4
                #2 @ 3,1: 4x4
                #3 @ 5,5: 2x2
                """)
  @test covmap(io) == [
    0 0 0 0 0 0 0 0
    0 0 0 1 1 1 1 0
    0 0 0 1 1 1 1 0
    0 1 1 2 2 1 1 0
    0 1 1 2 2 1 1 0
    0 1 1 1 1 1 1 0
    0 1 1 1 1 1 1 0
    0 0 0 0 0 0 0 0
  ]

end


answers = Dict(
  1 => Dict("pbouffard" => (425, 57538)),
  2 => Dict("pbouffard" => (6225, "revtaubfniyhsgxdoajwkqilp")),
  3 => Dict("sample" => (4, 3), "pbouffard" => (112378, 603)),
  4 => Dict("sample" => (240, 4455), "pbouffard" => (94040, 39940)),
  5 => Dict("sample" => (10, 4), "pbouffard" => (10180, 5668)),
)

@testset verbose = true "Day $day" for (day, answers) in answers
  @testset verbose = true "$name" for (name, day_answers) in answers
    input_path = userpath(name, day, _YEAR)
    results = solveday(Val(day), Val(_YEAR))(open(input_path))
    @testset "Part $part" for (part, answer, result) in zip((1, 2), day_answers, results)
      @info "Day $day, $name, part $part"
      @test result == answer
    end
  end
end


end # 2018