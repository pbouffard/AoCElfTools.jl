module RockPaperScissors

export rock, paper, scissors

@enum RPS begin
  rock
  paper
  scissors
end

RPS(c::Char) = Dict(
  'A' => rock, 'B' => paper, 'C' => scissors,
  'X' => rock, 'Y' => paper, 'Z' => scissors)[c]

Base.isless(a::RPS, b::RPS) = (a === scissors && b === rock) ? true : (a === rock && b === scissors ? false : isless(Int(a), Int(b)))

end