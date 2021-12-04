include("../utilities/aoc_helper.jl")
using .helper

function my_filter(lines, op)
    for i in 1:length(lines[1])
        c = [parse(Bool, l[i]) for l in lines]
        ok = op(count(c), length(c)/2) ? '1' : '0'
        lines = [l for l in lines if l[i]==ok]
        if length(lines) == 1
            return lines[1]
        end
    end
end
function day03(input::String = readInput("day3_in.txt"))
    lines = split(input)
    cols = []
    γ = ϵ = ""
    for i in 1:length(lines[1])
        push!(cols, [parse(Bool, l[i]) for l in lines])
    end
    for c in cols
        if count(c) > length(cols[1])/2
            γ *= "1"
            ϵ *= "0"
        else
            γ *= "0"
            ϵ *= "1"
        end
    end
    #part2
    m_lines = copy(lines)
    l_lines = copy(lines)
    oxy = my_filter(m_lines, >=)
    co = my_filter(l_lines, <)
    (parse(Int, γ, base=2) * parse(Int, ϵ, base=2), parse(Int, co, base=2) * parse(Int, oxy, base=2))
end

println(day03())