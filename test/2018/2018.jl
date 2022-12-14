
datadir = joinpath(@__DIR__, "data")

@testset "2018 Day 1 - samples" begin
  # Samples as provided in problem

  # Part 1
  cases = (
    "+1, -2, +3, +1" => 3,
    "+1, +1, +1" => 3,
    "+1, +1, -2" => 0,
    "-1, -2, -3" => -6,
  )

  for (input_str, correct_result) in cases
    @info "input_str = $(input_str)"
    @test solveday(Val(1), Val(2018))(IOBuffer(join(split(input_str, ","), "\n") * "\n"); part=1) |> first == correct_result
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
    @test solveday(Val(1), Val(2018))(IOBuffer(join(split(input_str, ","), "\n"))) |> last == correct_result
  end


end


@testset verbose=true "2018 Day 1 - puzzle" begin
  answers = Dict(
    "pbouffard" => (
      425, # part 1
      57538, # part 2
    ),
  )

  for (contributor, answer) in answers
    input_path = joinpath(datadir, contributor, "01.txt")
    @test solveday(Val(1), Val(2018))(open(input_path)) == answer
  end


end