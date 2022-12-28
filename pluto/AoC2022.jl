### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 3541a616-862a-11ed-0845-3b89fa14b57a
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.status()
	Pkg.add(["PlutoUI"])
	Pkg.develop("AoCElfTools")
	
	using AoCElfTools
	using PlutoUI
	md"## Pkg Stuff"
end

# ╔═╡ 161fb7b7-d4b7-4e05-8f55-6c27b0eea64c
md"""# Advent Of Code 2022"""

# ╔═╡ 4ee65f84-4e9f-4fd2-9a30-78fe00a2b024
md"""
## Options

* Username for puzzle inputs $(@bind _USER TextField(; default="jbshannon"))
* Verbose timing $(@bind verbosetiming CheckBox())

"""

# ╔═╡ a4df370c-5c9d-43b7-84a2-02b9334649e8
md"""
## Day 1 - Calorie Counting
* Part 1: Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
* Part 2: Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?

Solve Day 1 $(@bind solve1 CheckBox(;default=false))
"""

# ╔═╡ b7e2b79c-b6b4-4ebe-bf9a-93b5aa2cb2a1
md"""
## Day 2 - Rock Paper Scissors
* Part 1: What would your total score be if everything goes exactly according to your strategy guide?
* Part 2: Following the Elf's instructions for the second column, what would your total score be if everything goes exactly according to your strategy guide?

Solve Day 2 $(@bind solve2 CheckBox(;default=false))
"""

# ╔═╡ 369fb184-ebe2-4f5f-8f1c-a79e61568a35
md"""
## Day 3 - Rucksack Reorganization
* Part 1: Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?
* Part 2: Find the item type that corresponds to the badges of each three-Elf group. What is the sum of the priorities of those item types?

Solve Day 3 $(@bind solve3 CheckBox(;default=false))
"""

# ╔═╡ 081d1521-1e6f-4ab4-acfa-d2b25b0855ae
md"""
## Day 4 - Camp Cleanup
* Part 1: In how many assignment pairs does one range fully contain the other?
* Part 2: In how many assignment pairs do the ranges overlap?

Solve Day 4 $(@bind solve4 CheckBox(;default=false))
"""

# ╔═╡ aab9ec47-5a00-4bbf-9a88-f32c5972b8d0
md"""
## Day 5 - Supply Stacks
* Part 1: After the rearrangement procedure completes, what crate ends up on top of each stack?
* Part 2: Before the rearrangement process finishes, update your simulation so that the Elves know where they should stand to be ready to unload the final supplies. After the rearrangement procedure completes, what crate ends up on top of each stack?

Solve Day 5 $(@bind solve5 CheckBox(;default=false))
"""

# ╔═╡ bc7b1030-a810-4f7b-a249-4ac0b748e509
md"""
## Day 6 - Tuning Trouble
* Part 1: How many characters need to be processed before the first start-of-packet marker is detected?
* Part 2: How many characters need to be processed before the first start-of-message marker is detected?

Solve Day 6 $(@bind solve6 CheckBox(;default=false))
"""

# ╔═╡ 5d01cd0c-bb33-4a28-9acd-c9a8e7637cd7
md"""
## Day 7 - No Space Left On Device
* Part 1: Find all of the directories with a total size of at most 100000. **What is the sum of the total sizes of those directories?**
* Part 2: Find the smallest directory that, if deleted, would free up enough space on the filesystem to run the update. **What is the total size of that directory?**


Solve Day 7 $(@bind solve7 CheckBox(;default=false))
"""

# ╔═╡ 943caffc-ff18-4357-a928-9d5cee1bc462
md"""
## Day 8 - [Treetop Tree House](https://adventofcode.com/2022/day/8)
* Part 1: Consider your map; **how many trees are visible from outside the grid?**
* Part 2: Consider each tree on your map. **What is the highest scenic score possible for any tree?**


Solve Day 8 $(@bind solve8 CheckBox(;default=false))
"""

# ╔═╡ f10e7903-5899-4e80-82b1-2679954f0970
md"""
## Day 9 - [Rope Bridge](https://adventofcode.com/2022/day/9)
* Part 1: Simulate your complete hypothetical series of motions. **How many positions does the tail of the rope visit at least once?**
* Part 2: 


Solve Day 9 $(@bind solve9 CheckBox(;default=false))
"""

# ╔═╡ ed72c0fc-e27c-4d5b-b2df-495161e55dc7
md"##  Helpers"

# ╔═╡ f6d2b70f-7d47-4c3c-a682-2bf65ee18894
_YEAR = 2022

# ╔═╡ 4c501a8e-76cc-4445-9cee-2e70963f0c21
function solve_problem(day)
	if verbosetiming
		@timev (p1, p2) = solve_specific(_YEAR, day, userpath(_USER, day, _YEAR))
	else
		@time (p1, p2) = solve_specific(_YEAR, day, userpath(_USER, day, _YEAR))
	end
	return (; part1=p1, part2=p2)
end

# ╔═╡ 29006f02-a034-4b26-a6a8-42f2f956fc54
function show_solution(day, noskip)
	sol = noskip ? solve_problem(day) : nothing
	if !noskip
		md"""
		Day $(day) skipped.
		"""
	else
		md"""
		Day $day solved for input file $(userpath(_USER, day, 2022))
		
		
		* Part 1: $(sol.part1)
		* Part 2: $(sol.part2)
		"""
	end
end

# ╔═╡ 7fef55ec-f1e4-48e5-b7f6-9703f9d5c429
show_solution(1, solve1)

# ╔═╡ b7ae5ae1-b9b1-43d3-b16e-168c028f21cf
show_solution(2, solve2)

# ╔═╡ 4727dc15-68ce-4ece-8877-853c79f64b96
show_solution(3, solve3)

# ╔═╡ 48aaacdc-f9fb-4c1f-8d89-44eb8ba50793
show_solution(4, solve4)

# ╔═╡ 0b117f25-5198-4a22-be82-1010ddfe5428
show_solution(5, solve5)

# ╔═╡ 46014e03-8989-4215-be7b-531beaa81141
show_solution(6, solve6)

# ╔═╡ 7221ef35-1dec-4af9-b959-9527b3e3ca8a
show_solution(7, solve7)

# ╔═╡ b3173648-3e54-4852-9be5-9ef4eb203e7a
show_solution(8, solve8)

# ╔═╡ 7d17abb0-eef3-484f-93ef-2f87cf46d2ea
show_solution(9, solve9)

# ╔═╡ Cell order:
# ╟─161fb7b7-d4b7-4e05-8f55-6c27b0eea64c
# ╟─4ee65f84-4e9f-4fd2-9a30-78fe00a2b024
# ╟─a4df370c-5c9d-43b7-84a2-02b9334649e8
# ╟─7fef55ec-f1e4-48e5-b7f6-9703f9d5c429
# ╟─b7e2b79c-b6b4-4ebe-bf9a-93b5aa2cb2a1
# ╠═b7ae5ae1-b9b1-43d3-b16e-168c028f21cf
# ╟─369fb184-ebe2-4f5f-8f1c-a79e61568a35
# ╟─4727dc15-68ce-4ece-8877-853c79f64b96
# ╟─081d1521-1e6f-4ab4-acfa-d2b25b0855ae
# ╠═48aaacdc-f9fb-4c1f-8d89-44eb8ba50793
# ╟─aab9ec47-5a00-4bbf-9a88-f32c5972b8d0
# ╠═0b117f25-5198-4a22-be82-1010ddfe5428
# ╟─bc7b1030-a810-4f7b-a249-4ac0b748e509
# ╠═46014e03-8989-4215-be7b-531beaa81141
# ╟─5d01cd0c-bb33-4a28-9acd-c9a8e7637cd7
# ╠═7221ef35-1dec-4af9-b959-9527b3e3ca8a
# ╟─943caffc-ff18-4357-a928-9d5cee1bc462
# ╠═b3173648-3e54-4852-9be5-9ef4eb203e7a
# ╠═f10e7903-5899-4e80-82b1-2679954f0970
# ╠═7d17abb0-eef3-484f-93ef-2f87cf46d2ea
# ╟─ed72c0fc-e27c-4d5b-b2df-495161e55dc7
# ╠═29006f02-a034-4b26-a6a8-42f2f956fc54
# ╠═4c501a8e-76cc-4445-9cee-2e70963f0c21
# ╠═f6d2b70f-7d47-4c3c-a682-2bf65ee18894
# ╟─3541a616-862a-11ed-0845-3b89fa14b57a
