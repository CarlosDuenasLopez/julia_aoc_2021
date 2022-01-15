using DataStructures: DefaultDict
include("../utilities/aoc_helper.jl")
using .helper
using BenchmarkTools

struct Cave
    big::Bool
    name::String
    cons::Array{Cave}
end

function day12()
    lines = readlines("in_day12.txt")
    cave_map = DefaultDict{String, Array}(Vector)
    for l in lines
        splitted = split(l, "-")
        push!(cave_map[splitted[1]], splitted[2])
        push!(cave_map[splitted[2]], splitted[1])
    end
    println(part2_recu("start", cave_map, ["start"], []))
end

function recu(node, cave_map, seen, been_to)
    route_count = 0
    possibles = sort(setdiff(cave_map[node], seen))
    
    if node=="end"
        return 1
    end
    if length(possibles) == 0
        return 0
    end
    for p in possibles
        route_count += recu(p, cave_map, all(c->islowercase(c), node) ? vcat(seen, [node]) : seen, vcat(been_to, node))
    end
    return route_count
end

function part2_recu(node, cave_map, seen, been_to)
    route_count = 0
    # possibles = sort(setdiff(cave_map[node], seen))
    cons = cave_map[node]
    possibles = []
    lowers = []
    for b in been_to
        if all(c->islowercase(c), b)
            push!(lowers, b)
        end
    end
    for c in cons
        if c != "start"
            if all(x->isuppercase(x), c)
                push!(possibles, c)
            elseif c ∉ been_to
                push!(possibles, c)
            elseif multi(been_to)
                push!(possibles, c)
            else
                # println(been_to, " ", c, " ", node)
            end
        end
    end
    # if any(length(findall()))
    sort!(possibles)
    if node=="end"
        if fuck_this(been_to)
            # println(been_to)
            return 1
        else
            return 0
        end
    end
    if length(possibles) == 0
        return 0
    end
    for p in possibles
        route_count += part2_recu(p, cave_map, all(c->islowercase(c), node) ? vcat(seen, [node]) : seen, vcat(been_to, node))
    end
    return route_count
end

function multi(l)
    lowers = [x for x in l if all(all(c->islowercase(c), x))]
    r = all(z->length(findall(y->y==z, lowers)) < 2, lowers)
    return r
end

function fuck_this(l)
    lowers = [x for x in l if all(all(c->islowercase(c), x))]
    r = [length(findall(y->y==z, lowers)) for z in lowers]
    return sum(r) <= length(r)+2
end


# println(fuck_this(["start", "HN", "dc", "HN", "kj", "HN", "dc", "kj", "HN"]))
# println(multi(["start", "HN", "dc", "HN", "kj", "HN", "dc", "kj", "HN"]))
@btime day12()