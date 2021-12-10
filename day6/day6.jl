include("../utilities/aoc_helper.jl")
using .helper

function day05(input::String = readInput("day6_in.txt"))
    numbers = parse.(Int, split(input, ","))
    for iter in 1:80
        # if (iter-1) % 6 == 0
            # println(iter)
            # println(numbers)
        # end
        for (i, e) in enumerate(numbers)
            if e == 0
                numbers[i] = 6
                push!(numbers, 9)
            else
                numbers[i] -= 1 
            end
        end
        # println(numbers)
    end
    println(length(numbers))
end

function day05_02(input::String = readInput("day6_in.txt"))
    numbers = parse.(Int, split(input, ","))
    sum = 0
    d = Dict()
    for n in numbers
        println(n)
        l = [n]
        if n in keys(d)
            sum += d[n]
        else
            for iter in 1:256
                for (i, num) in enumerate(l)
                    if num == 0
                        l[i] = 6
                        push!(l, 9)
                    else
                        l[i] -= 1 
                    end
                end
            end
            d[n] = length(l)
            sum += (length(l))
        end
    end
    println(sum)
end

day05_02()