parse_input(::Val{1}) = io -> collect(eachline(io))

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
    calories = Int[]
    current = 0

    for line in input
        if isempty(line)
            push!(calories, current)
            current = 0
        else
            current += parse(Int, line)
        end
    end

    push!(calories, current)
    return calories
end

function solve(::Val{1})
    function _solve(input)
        calories = caloriescarried(input)
        partialsort!(calories, 1:3; rev=true)
        return (first(calories), sum(calories[1:3]))
    end
    return _solve
end
