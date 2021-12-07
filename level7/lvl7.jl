include("../utilities/aoc_helper.jl")
using .helper
using Statistics

function day07(input::String = readInput("day7_in.txt"))
    posis = parse.(Int, split(input, ",")) 
    point_part1 = Statistics.median(posis)
    part1 = sum(abs(point_part1-x) for x in posis)
    point_list = zeros(maximum(posis)+1)
    for e in posis, point in 1:length(point_list)
            point_list[point] += sum(1:abs(point-e))
    end
    println(part1, " ", minimum(point_list))
end

day07()