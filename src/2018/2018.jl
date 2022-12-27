module Year2018

include("01.jl")
include("02.jl")
include("03.jl")
include("04.jl")
include("05.jl")
include("06.jl")
include("07.jl")

import ..daysavailable

daysavailable(::Val{2018}) = [1,2,3,4,5,6,7]

# export daysavailable

end
# include("08.jl")
