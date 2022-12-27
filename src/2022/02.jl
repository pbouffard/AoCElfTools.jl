module Day2

import ...parseday
import ...solveday

decode(round) = (round[1] - 'A', round[3] - 'X')

"""
    parseday(::Val{2}) -> (IO -> Vector{Tuple{Int64, Int64}})

Return a function that parses an `IO` stream of input into a `Vector{Tuple{Int64, Int64}}` where each element represents the strategy for a round.
"""
function parseday(::Val{2}, ::Val{2022})
  function f(io)
    return map(decode, readlines(io))
  end
end

"""
    shoot(me, opponent) -> Int

Determine the outcome of a round given a strategy for `me` and my `opponent`.

- Strategies
    - 0 = rock
    - 1 = paper
    - 2 = scissors
- Outcomes
    - 0 = loss
    - 1 = draw
    - 2 = win

# Examples
```jldoctest; setup = :(using AoCElfTools.Year2022.Day2: shoot)
julia> rock, paper, scissors = (0, 1, 2);

julia> lose, draw, win = (0, 1, 2);

julia> shoot(rock, paper) == lose
true

julia> shoot(paper, rock) == win
true

julia> shoot(paper, paper) == draw
true
```
"""
shoot(me, opponent) = mod(1 + me - opponent, 3)


"""
    strategy(outcome, opponent)

Return the strategy you should play to induce the desired `outcome` given the strategy of your `opponent`.

- Strategies
    - 0 = rock
    - 1 = paper
    - 2 = scissors
- Outcomes
    - 0 = loss
    - 1 = draw
    - 2 = win

# Examples
```jldoctest; setup = :(using AoCElfTools.Year2022.Day2: strategy)
julia> rock, paper, scissors = (0, 1, 2);

julia> lose, draw, win = (0, 1, 2);

julia> strategy(win, paper) == scissors
true

julia> strategy(draw, paper) == paper
true

julia> strategy(lose, paper) == rock
true
```
"""
strategy(outcome, opponent) = mod(opponent + outcome - 1, 3)

"""
    score(me, outcome)

Calculate the score given a strategy for `me` and the `outcome`.

- Strategies
    - 0 = rock
    - 1 = paper
    - 2 = scissors
- Outcomes
    - 0 = loss
    - 1 = draw
    - 2 = win

# Examples
```jldoctest; setup = :(using AoCElfTools.Year2022.Day2: score)
julia> rock, paper, scissors = (0, 1, 2);

julia> lose, draw, win = (0, 1, 2);

julia> score(rock, win)
7

julia> score(paper, lose)
2

julia> score(paper, win)
8

julia> score(rock, lose)
1

julia> score(scissors, draw)
6
```
"""
score(me, outcome) = 1 + me + 3 * outcome

"""
# Examples
```jldoctest; setup = :(using AoCElfTools.Year2022.Day2: strategy)
julia> rock, paper, scissors = (0, 1, 2);

julia> lose, draw, win = (0, 1, 2);

julia> strategy(win, paper) == scissors
true

julia> strategy(draw, paper) == paper
true

julia> strategy(lose, paper) == rock
true
```
"""
# strategy(outcome, opponent) = mod(opponent + outcome - 1, 3)

"""
    score1(round)

Score a `round` assuming that the second element represents your own strategy.

You get 1 point for playing rock, 2 points for playings paper, and 3 points for playing scissors, plus 3 points if you tie and 6 points if you win.

# Examples
```jldoctest; setup = :(using AoCElfTools.Year2022.Day2: score1)
julia> decode(round) = (round[1] - 'A', round[3] - 'X');

julia> "A Y" |> decode |> score1
8

julia> "B X" |> decode |> score1
1

julia> "C Z" |> decode |> score1
6
```
"""
function score1(round)
  opponent, me = round
  outcome = shoot(me, opponent)
  return score(me, outcome)
end

"""
    score2(round)

Score a `round` assuming that the second element represents your desired outcome.

You get 1 point for playing rock, 2 points for playings paper, and 3 points for playing scissors, plus 3 points if you tie and 6 points if you win.

# Examples
```jldoctest; setup = :(using AoCElfTools.Year2022.Day2: score2)
julia> decode(round) = (round[1] - 'A', round[3] - 'X');

julia> "A Y" |> decode |> score2
4

julia> "B X" |> decode |> score2
1

julia> "C Z" |> decode |> score2
7
```
"""
function score2(round)
  opponent, outcome = round
  me = strategy(outcome, opponent)
  return score(me, outcome)
end


"""
    solveday(::Val{2}) -> (Vector{Int64} -> Tuple{Int64, Int64}})

Solve Day 2's puzzle:
- ans₁: score if second column represents your strategy
- ans₂: score if second column represents the outcome

# Examples
"""
function solveday(::Val{2}, ::Val{2022})
  input -> (sum(score1, input), sum(score2, input))
end

end # module

using .Day2
