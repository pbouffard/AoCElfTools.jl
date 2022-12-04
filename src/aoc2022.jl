module AoC2022

  # Day 1

  "Which elf is carrying the most calories?"
  function mostcalories(input)
    max = 0
    current = 0
    for line in input
      if isempty(line)
        current = 0
      else
        current += parse(Int, line)
        current > max && (max = current)
      end
    end

    return max
  end

  "Calories carried by each elf"
  function caloriescarried(input)
    calories = Vector{Int}()

    current = 0
    for line in input
      if isempty(line)
        push!(calories, current)
        # @show calories
        current = 0
      else
        current += parse(Int, line)
      end
    end

    push!(calories, current)  # final elf

    return calories

  end

end