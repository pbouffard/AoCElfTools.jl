module RockPaperScissors

export rock, paper, scissors

@enum RPS begin
  rock
  paper
  scissors
end

Base.isless(a::RPS, b::RPS) = (a === scissors && b === rock) ? true : (a === rock && b === scissors ? false : isless(Int(a), Int(b)))

end