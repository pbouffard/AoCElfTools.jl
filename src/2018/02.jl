module Day2

import ...parseday
import ...solveday

function boxids_checksum(io)
	global accum2 = 0 # ARGH, the infamous GSD!
	global accum3 = 0
	iter = 1
	for L ∈ readlines(io)
		cs = collect(L)
		us = unique(cs)
		@debug "$(iter) ----------"
		@debug cs
		@debug us
		global found2 = false
		global found3 = false
		for u ∈ us
			N = count(p -> p == u, cs)
			@debug "$(u) -> $(N), $(found2), $(found3)"
			if !found2 && N == 2
				global accum2 += 1
				global found2 = true  
				@debug "found 2"
			elseif !found3 && N == 3
				global accum3 += 1
				global found3 = true
				@debug "found 2"
			end
		end
		@debug "$(cs) accum2 = $(accum2) accum3 = $(accum3)"
		iter += 1
	end
	return accum2 * accum3
end

function commonletters(io)
	global ids = Set()
	iter = 1
	for L ∈ eachline(io)
		@debug iter
		for id ∈ ids
			same = collect(L) .== collect(id)
			sameidxs = findall(same)
			samechars = id[sameidxs]
			@debug L
			@debug id
			onezero(x) = x ? "1" : "0"
			@debug "$(prod(onezero.(same))), $(length(sameidxs)), $(samechars)"
			if length(sameidxs) == length(L) - 1
				return samechars
			end
		end
		push!(ids, L)
		iter += 1
	end
	@error "not found!"
	return ""
end

function solveday(::Val{2}, ::Val{2018})
  function f(io)
    part1 = boxids_checksum(io)
    seekstart(io)
    part2 = commonletters(io)
    return (part1, part2)
  end
end

end # module