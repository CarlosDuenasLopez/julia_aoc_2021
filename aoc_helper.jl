module helper

function readInput(path::String)
    s = open(path, "r") do file
        read(file, String)
    end
    return s
end
export readInput

end