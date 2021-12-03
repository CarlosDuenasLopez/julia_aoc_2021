include("../aoc_helper.jl")

using BenchmarkTools
using .helper


function day01(input::String = readInput("lvl1_in.txt"))
    reports = parse.(Int, split(input))
    sums = [sum(x) for x ∈ zip(reports[1:end-2], reports[2:end-1], reports[3:end])]
    return [count(diff(reports) .> 0), count(diff(sums) .> 0)]
end
