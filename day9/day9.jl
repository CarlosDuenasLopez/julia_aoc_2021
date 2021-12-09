function day9()
    lines = (split.(readlines("in_day9.txt"), ""))
    num_lines = [[parse(Int, x) for x in l] for l in lines]
    A = transpose(reduce(hcat, num_lines))
    r1 = sum([lower(j, i, A)[1] for i in 1:length(eachcol(A)), j = 1:length(eachrow(A))])
    og_lows = [lower(j, i, A)[2] for i in 1:length(eachcol(A)), j = 1:length(eachrow(A))]
    og_lows = filter(x->x != false, og_lows)
    basin_sizes = []
    for low in og_lows[1:end]
        push!(basin_sizes, basin(Set([(low[1], low[2])]), A))
    end
    r1, (*(sort(basin_sizes)[end-2:end]...))
    
end

function lower(y, x, A)
    ps = neighbor_vals(y, x, A)
    r = all(f->f>A[y, x], ps)
    (r * A[y, x] + r, r ? (y, x) : false)
end


function basin(fields, A)
    start_len = length(fields)
    for (i, f) in enumerate(fields)
        neighs = neighbors(f..., A)
        for n in neighs
            if n ∉ fields
                neighbors_neighbors = neighbors(n..., A)
                neighbors_neighbors = [nn for nn in neighbors_neighbors if nn ∉ fields]
                if all_greater(n, neighbors_neighbors, A)
                    if A[n...] != 9
                        push!(fields, n)
                    end
                end
            end
        end
    end
    if length(fields) == start_len
        return start_len
    else
        return basin(fields, A)
    end
end

function all_greater(og, neighbors, A)
    for n in neighbors
        if A[n...] < A[og...]
            return false
        end
    end
    return true
end

neighbor_vals(y, x, A) = [x>1 ? A[y, x-1] : 9, x < size(A)[2] ? A[y, x+1] : 9, y > 1 ? A[y-1, x] : 9, y < size(A)[1] ? A[y+1, x] : 9]
neighbors(y, x ,A) = filter(z->z !== nothing, [x>1 ? (y, x-1) : nothing, x < size(A)[2] ? (y, x+1) : nothing, 
                            y > 1 ? (y-1, x) : nothing, y < size(A)[1] ? (y+1, x) : nothing])

println(day9())