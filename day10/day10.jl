using DataStructures: Stack
include("../utilities/aoc_helper.jl")
using .helper

function day10()
    input = readlines("in_day10.txt")
    openers = ['(', '[', '{', '<']
    pair_dict = Dict([('(', ')'), ('[', ']'), ('{', '}'), ('<', '>')])
    val_dict = Dict([(')', 3), (']', 57), ('}', 1197), ('>', 25137)])
    part2_vals = Dict([('(', 1), ('[', 2), ('{', 3), ('<', 4)])
    part2_lines = []
    sum = 0
    score_2 = []
    for line in input
        s = Stack{Char}()
        check = true
        for char in line
            if char in openers
                push!(s, char)
            else
                x = pop!(s)
                if pair_dict[x] !== char
                    sum += val_dict[char]
                    check = false
                    break
                end
            end
        end
        if check
            push!(part2_lines, line)
        end
    end
    for line in part2_lines
        s = Stack{Char}()
        z_score = 0
        for char in line
            if char in openers
                push!(s, char)
            else
                pop!(s)
            end
        end
        for char in reverse(collect(s))
            z_score = z_score * 5 + part2_vals[pop!(s)]
        end
        push!(score_2, z_score)
    end
    sum, sort(score_2)[Int(round(length(score_2)/2))]
end

println(day10())