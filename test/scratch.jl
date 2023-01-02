# using MetaGraphs
# pattern = r"Step ([A-Z]) must be finished before step ([A-Z]) can begin."
# m = match(pattern, "Step C must be finished before step A can begin.")
# c = match(pattern, "Step C must be finished before step A can begin.").captures
# g = MetaDiGraph(typeof(Symbol))
# add_edge!(g, (1,2))

using AoCElfTools
using Graphs
using GraphPlot
using MetaGraphs

D7 = AoCElfTools.Year2018.Day7

g = parseday(Val(7), Val(2018))(open(userpath("pbouffard", 7, 2018)))
D7.process!(g)
#g.indices
#D7.gplot(g)

steps = []

step = D7.step!(g)

g['Z', :name]


# g = D7.cull_graph(g)
# labels = [g.vprops[i][:name] for i in 1:nv(g)]
# D7.next_ready(g)
g = D7.cull_graph!(g)
D7.gplot(g)
D7.next_ready(g)
D7.step!(g)
D7.gplot(g)
D7.process!(g)


gplot(g; nodelabel=labels)
gg = D7.cull_graph!(g)
labels = [gg.vprops[i][:name] for i in 1:nv(gg)]
gplot(gg; nodelabel=labels)
