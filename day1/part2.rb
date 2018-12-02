#! /usr/bin/ruby

frequency = 0
changes = []
frequencies = {}
File.open("input.txt", "r") do |f|
    f.each_line do |l| 
        changes << l.to_i
    end
end

while 1==1 do
    changes.each do |c|
        frequencies[frequency] = 1
        frequency += c
        if frequencies.key?(frequency)
            p frequency
            exit
        end
    end
end
