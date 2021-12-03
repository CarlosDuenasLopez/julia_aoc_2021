include("../aoc_helper.jl")
using .helper

function my_filter(m_lines, op)
    for i in 1:length(m_lines[1])
        c = [parse(Bool, l[i]) for l in m_lines]
        ok = op(count(c), length(c)/2) ? '1' : '0'
        m_lines = [l for l in m_lines if l[i]==ok]
        if length(m_lines) == 1
            return m_lines[1]
        end
    end
end


function day02(input::String = readInput("day3_in.txt"))
    lines = split(input)
    cols = []
    gamma = eps = ""
    for i in 1:length(lines[1])
        push!(cols, [parse(Bool, l[i]) for l in lines])
    end
    for c in cols
        if count(c) > length(cols[1])/2
            gamma *= "1"
            eps *= "0"
        else
            gamma *= "0"
            eps *= "1"
        end
    end

    #part2
    m_lines = copy(lines)
    l_lines = copy(lines)
    oxy = my_filter(m_lines, >=)
    co = my_filter(l_lines, <)
    (parse(Int, gamma, base=2) * parse(Int, eps, base=2), parse(Int, co, base=2) * parse(Int, oxy, base=2))
end

println(day02())