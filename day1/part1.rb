#! /usr/bin/ruby


frequency = 0

File.open("input.txt", "r") do |f|
    f.each_line{|l| frequency += l.to_i}
    
end

p frequency