function day9()
    lines = (split.(readlines("in_day9.txt"), ""))
    num_lines = [[parse(Int, x) for x in l] for l in lines]
    A = transpose(reduce(hcat, num_lines))
    r1 = sum([lower(j, i, A)[1] for i in 1:length(eachcol(A)), j = 1:length(eachrow(A))])
    og_lows = [lower(j, i, A)[2] for i in 1:length(eachcol(A)), j = 1:length(eachrow(A))]
    r1
end

function lower(y, x, A)
    ps = [x>1 ? A[y, x-1] : 9, x < size(A)[2] ? A[y, x+1] : 9, y > 1 ? A[y-1, x] : 9, y < size(A)[1] ? A[y+1, x] : 9]
    (abs(all(f->f>A[y, x], ps)) * A[y, x] + all(f->f>A[y, x], ps), all(f->f>A[y, x], ps) ?(y, x) )
end

println(day9())