const m = [0 1 0 0 0 0 0 0 0;
           0 0 1 0 0 0 0 0 0;
           0 0 0 1 0 0 0 0 0;
           0 0 0 0 1 0 0 0 0;
           0 0 0 0 0 1 0 0 0;
           0 0 0 0 0 0 1 0 0;
           1 0 0 0 0 0 0 1 0;
           0 0 0 0 0 0 0 0 1;
           1 0 0 0 0 0 0 0 0]

function simulate_fish(fish, days)
	fish_counts = zeros(Int,9)
	for f=fish
		fish_counts[f+1] += 1
	end
	sum((m ^ days) * fish_counts)
end

s =read(open("day6_in.txt", "r"), String)
r = parse.(Int, split(s, ","))
println(simulate_fish(r, 80))