include("../utilities/aoc_helper.jl")
using .helper
using BenchmarkTools

function p2()
    lines = readlines("in_day13.txt")
    dots = lines[1:findfirst(x-> x=="", lines)-1]
    A = create_matrix(dots)
    instructions = lines[findfirst(x-> x=="", lines)+1:end]
    for (idx, i) in enumerate(instructions)
        ins = split(i, " ")[end]
        cord, line = split(ins, "=")
        if cord == "y"
            A = fold_up(A, parse(Int, line))
        else
            A = fold_left(A, parse(Int, line))
        end
        idx==1 && println(length(findall(x->x!=0, A)))
    end
    A
    # idcs = findall(x->x>0, A)
    # A[idcs] .= 1
    # display(A[:, 1:20])
    # println("\n")
    # display(A[:, 20:end])
end


function create_matrix(dots)
    max_x = max_y = 0
    cords = []
    for d in dots
        s = split(d, ",")
        x, y = parse.(Int, s)
        push!(cords, (x, y))
        max_x = max(max_x, x)
        max_y = max(max_y, y)
    end
    A = zeros(Int64, max_y+1, max_x+1)
    for c in cords
        A[c[2]+1, c[1]+1] = 1
    end
    A
end

function fold_up(A, line)
    upper, lower = A[1:line, :], A[end:-1:line+2, :]
    upper+lower
end

function fold_left(A, line)
    left, right = A[:, 1:line], A[:, end:-1:line+2]
    left+right
end
