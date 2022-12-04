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

end