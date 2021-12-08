include("../utilities/aoc_helper.jl")
using .helper

function day08(input::String = readInput("in_day8.txt"))
    seg_dict = Dict([(0, 6), (1, 2), (2, 5), (3, 5), (4, 4), (5, 5), (6, 6), (7, 3), (8, 7), (9, 6)])
    input = strip.(split(replace(input, "|"=>"|\n"), "\n"))
    lprint(input)
    nums = input[2:2:end]
    # lprint(nums)
    s = 0
    for num_line in nums
        s+=(length([true for n in split(num_line, " ") if length(n) in [2, 4, 3, 7]]))
    end
    println(s)
end


function day08_02(input::String = readInput("in_day8.txt"))
    input = strip.(split(replace(input, "|"=>"|\n"), "\n"))
    wires = input[1:2:end]
    outs = input[2:2:end]
    sum = 0
    for (i, wire_line) in enumerate(wires)
        letter_dict = Dict()
        single_dict = Dict()
        s_line = split(wire_line, " ")
        for wire in s_line  # save obvious numbers
            # println(wire)
            if length(wire) == 2
                letter_dict[1] = Set(wire)
            elseif length(wire) == 4
                letter_dict[4] = Set(wire)
            elseif length(wire) == 3
                letter_dict[7] = Set(wire)
            elseif length(wire) == 7
                letter_dict[8] = Set(wire)
            end
        end
        single_dict["A"] = [x for x in letter_dict[7] if x ∉ letter_dict[1]][1]
        for wire in s_line # find 9 and D segment
            if length(wire) == 6 && length(non_match(Set(wire), union(letter_dict[4], letter_dict[7]))) == 1
                letter_dict[9] = Set(wire)
                single_dict["D"] = non_match(Set(wire), union(letter_dict[4], letter_dict[7]))[1]
            end
        end
        single_dict["E"] = [x for x in letter_dict[8] if x ∉ letter_dict[9]][1]
        for wire in s_line  # find 6
            if length(wire) == 6
                s = Set(wire)
                if length(non_match(letter_dict[1], s)) == 1
                    letter_dict[6] = s
                end
            end
        end

        for wire in s_line  # find 0
            if length(wire) == 6 && Set(wire) ∉ values(letter_dict)
                letter_dict[0] = Set(wire)
                n = non_match(letter_dict[8], Set(wire))[1]
                single_dict["G"] = n
            end
        end
        single_dict["B"] = [x for x in letter_dict[8] if x ∉ letter_dict[6]][1]
        for wire in s_line  # find 3
            if length(wire) == 5 && length(non_match(letter_dict[1], Set(wire))) == 0
                letter_dict[3] = Set(wire)
                n_E = union(letter_dict[3], single_dict["E"])
                single_dict["F"] = [x for x in letter_dict[8] if x ∉ n_E][1]
            end
        end

        for wire in s_line  # find 5 and 2
            if length(wire) == 5
                if single_dict["F"] in Set(wire)
                    letter_dict[5] = Set(wire)
                elseif Set(wire) != letter_dict[3]
                    letter_dict[2] =  Set(wire)
                end
            end
        end

        # aplly to outputs
        kes = collect(keys(letter_dict))
        vals = collect(values(letter_dict))
        dig = ""
        for out in split(outs[i], " ")
            o = Set(out)
            if findfirst(x->x==o, vals) !== nothing
                dig *= string(kes[findfirst(x->x==o, vals)])
            end
        end
        sum += parse(Int, dig)
    end
    sum
end

function non_match(s1, s2)
    r = []
    for entry in s1
        if entry ∉ s2
            push!(r, entry)
        end
    end
    r
end

day08_02()