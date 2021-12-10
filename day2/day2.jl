function day2_branchless(input::String = readInput("lvl2_in.txt"))
    lines = split(input)
    
    instructions = lines[1:2:end]
    amounts = parse.(Int, lines[2:2:end])
    func_dict = Dict([("forward", forward), ("up", up), ("down", down)])
    my_tuple = (0, 0, 0, 0)
    for (i, v) in enumerate(instructions)
        my_tuple = func_dict[v](my_tuple, amounts[i])
    end
    (my_tuple[1]*my_tuple[2], my_tuple[3]*my_tuple[4])
end

function forward(stats, amount)
    return (stats[1] + amount, stats[2], stats[3] + amount*stats[2], stats[4] + amount)
end

function down(stats, amount)
    return(stats[1], stats[2]+amount, stats[3], stats[4])
end

function up(stats, amount)
    return(stats[1], stats[2]-amount, stats[3], stats[4])
end

println(day2_branchless())