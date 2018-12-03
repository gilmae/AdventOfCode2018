#! /usr/bin/ruby

claims = []
File.open("input.txt", "r") do |f|
    f.each_line do |l| 
        claims << l.scan(/(\d+)/).flatten.map { |v| v.to_i}
    end
end


fabric = Array.new(1000) { Array.new(1000) { [] } }

claims.each do |id,x,y,w,h|
    fabric[y,h].each { |col|
        col[x,w].each{ |ids| 
            ids << id
        }
    }
end

good_ids = Array.new(claims.size) {true}

fabric.each do |col|
    col.each do |ids|
        ids.each { |id| good_ids[id] = false} if ids.size>1
    end

end

# part 1
puts fabric.map { |row| row.count { |x| x.size > 1 } }.inject(0) { |memo, v| memo + v}

#part 2
(1..good_ids.size).each { |i| puts i if good_ids[i]}
