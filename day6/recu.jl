using Memoize
println("imported")

function count_fish(days)
    if days <= 0
        return 1
    end
    return count_fish(days - 7) + count_fish(days - 9)
end
s =read(open("day6_in.txt", "r"), String)
r = parse.(Int, split(s, ","))
println(sum(count_fish(80 - f) for f in r))
println(sum(count_fish(256 - f) for f in r))


