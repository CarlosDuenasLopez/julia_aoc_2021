include("../utilities/aoc_helper.jl")
using .helper

function day04(input::String = readInput("day4_in.txt"))
    list = split(input, "\n")
    numbers = parse.(Int, split(list[1], ','))
    num_boards = div(length(list) - 1, 6)
    boards = [Matrix{Int}(undef, 5, 5) for _ in 1:num_boards]
    for k = 1:num_boards, i= 1:5
        boards[k][i, :] .= parse.(Int, split(list[2 + 6 * (k - 1) + i]))        
    end
    for num = numbers, board = boards
        board[findall(x->x==num, board)] .= -1
        if repeat([-1], 5) in union(eachcol(board), eachrow(board))
            println(sum(filter(x->x!=-1, board[:, :]))*num)
            boards = filter(x->x!=board, boards)
        end
    end
end

day04()
