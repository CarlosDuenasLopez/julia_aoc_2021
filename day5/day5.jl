include("../utilities/aoc_helper.jl")
using .helper


struct Point
    x::Int
    y::Int
end

function day05(input::String = readInput("day5_in.txt"))
    lines = split(input, "\n")
    connections = []
    diagonals = []
    max_x = max_y = 0

    # Iterate through all lines in input
    for l in lines
        # extract 2 Point instances
        sp = split(l, "->")
        p1 = Point(parse(Int, split(sp[1], ",")[1])+1, parse(Int, split(sp[1], ",")[2])+1)
        p2 = Point(parse(Int, split(sp[2], ",")[1])+1, parse(Int, split(sp[2], ",")[2])+1)

        # keep track of dimensions, so matrix can be created appropriatly later
        big_x = max(p1.x, p2.x)
        big_y = max(p1.y, p2.y)
        if big_x> max_x
            max_x = big_x
        end
        if big_y> max_y
            max_y = big_y
        end

        # store points in connections or diagonals for straight and diagonal lines respectively
        if p1.x == p2.x || p1.y == p2.y
            push!(connections, (p1, p2))
        else
            push!(diagonals, (p1, p2))
        end
    end

    # create matrix, thanks @rmsrosa :)
    A = (reduce(hcat, repeat([zeros(max_x)], max_y)))

    # iterate over straight lines
    for c in connections
        p1 = c[1]
        p2 = c[2]

        # get lines from points
        xs = max(p1.x:p2.x, p1.x:-1:p2.x)
        ys = max(p1.y:p2.y, p1.y:-1:p2.y)
        A[ys, xs] .+= 1
    end
    println(length(filter(x->x>=2, collect(A))))    # part 1 result

    # iterate over diagonals
    for c in diagonals
        p1 = c[1]
        p2 = c[2]

        # get all points that lie on the diagonal
        xs = max(collect(p1.x:p2.x), collect(p1.x:-1:p2.x))
        ys = max(collect(p1.y:p2.y), collect(p1.y:-1:p2.y))
        for i in 1:length(xs)
            A[ys[i], xs[i]] += 1
        end
    end
    println(length(filter(x->x>=2, collect(A))))    # part 2 result

end

day05()