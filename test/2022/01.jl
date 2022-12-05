i, istr = check_day(@__FILE__)

@testset "Day $istr" begin

    # Puzzle answers
    answers = Dict(
        "sample" => (24000, 45000),
        "pbouffard" => (66487, 197301),
        "jbshannon" => (70613, 205805),
    )

    # Test parsing the sample input
    target = [
        "1000",
        "2000",
        "3000",
        "",
        "4000",
        "",
        "5000",
        "6000",
        "",
        "7000",
        "8000",
        "9000",
        "",
        "10000",
    ]
    sample = open(parse_input(Val(i)), joinpath(datadir, "sample", "$istr.txt"))
    @test sample == target

    # Test solutions
    for (dir, answer) in answers
        input = open(parse_input(Val(i)), joinpath(datadir, dir, "$istr.txt"))
        @test solve(Val(i))(input) == answer
    end

    # Other miscellaneous tests
end
