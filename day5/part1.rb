stream = File.open("input.txt", "r") {|f| f.readlines}.join("").chomp

reacting = true
while reacting
    reacted_stream = []
    i = 0
    reacting = false
    while i < stream.size
        if i+1 >= stream.size 
            reacted_stream << stream[i]
            i+=1
        elsif (stream[i].bytes[0] - stream[i+1].bytes[0]).abs == 32
            i+=2
            reacting = true
        else
            reacted_stream << stream[i]
            i+=1
        end
    end

    stream = reacted_stream.join("")
end


puts reacted_stream.join("").size
