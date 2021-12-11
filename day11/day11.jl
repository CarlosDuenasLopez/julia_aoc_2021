include("../utilities/aoc_helper.jl")
using .helper

function day11()
    lines = [[parse(Int, x) for x in l] for l in readlines("in_day11.txt")]
    A = transpose(reduce(hcat, lines))
    flashes = 0
    for i in 1:10^6
        A[:, :] .+= 1
        maxxed = 0
        used = []
        while true
            if length(used) == length(findall(x->x>=10, A))
                break
            end
            maxxed = setdiff(Tuple.(findall(x->x>=10, A)), used)
            [push!(used, m) for m in maxxed]
            for m in maxxed
                inc_neighs(m..., A)
            end
        end
        flashes += length(used)
        A[findall(x->x>=10, A)] .= 0
        if length(used) ==  100
            println(i)
            break
        end
        if i==100
            println(flashes)
        end
    end
end

function inc_neighs(y, x, A)
    neighs = neighbors(y, x, A)
    for n in neighs
        A[n...] += 1
    end
end

neighbors(y, x, A) = filter(z->z !== nothing, [x>1 ? (y, x-1) : nothing, x < size(A)[2] ? (y, x+1) : nothing, 
                            y > 1 ? (y-1, x) : nothing, y < size(A)[1] ? (y+1, x) : nothing,
                            y>1 && x>1 ? (y-1, x-1) : nothing, y>1 && x <size(A)[2] ? (y-1, x+1) : nothing,
                            y < size(A)[1] && x > 1 ? (y+1, x-1) : nothing, y < size(A)[1] && x < size(A)[2] ? (y+1, x+1) : nothing])

day11()