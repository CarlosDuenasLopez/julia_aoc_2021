function part1()
    in_file = open("inputlvl1.txt", "r")
    lines = readlines(in_file)
    int_lines=[parse(Int, x) for x in lines]
    r = 0
    last = int_lines[1]
    for i in int_lines[2:length(int_lines)]
        global r
        global last
        if i > last
            r+=1
        end
        last = i
    end
end


### part2
lines = readlines(open("inputlvl1.txt", "r"))
int_lines=[parse(Int, x) for x in lines]
sums = []
for num in 1:length(int_lines)-2
    global sums
    push!(sums, sum(int_lines[num:num+2]))
end

last = sums[1]
r = 0
for i in sums[2:length(sums)]
    global r
    global last
    if i > last
        r += 1
    last = i
    end
end

println(r)