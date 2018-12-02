#! /usr/bin/ruby

ids = []
File.open("input.txt", "r") do |f|
    f.each_line do |l| 
        ids << l
    end
end

def count_each_char s
    char_array = s.split("")
    char_counts = {}
    char_counts.default = 0
    char_array.each do |c|
        char_counts[c] += 1
    end

    char_counts
end

def has_a_dupe? a
    return !(a.reject {|k,v| v != 2}).empty?
end

def has_a_trip? a
    return !(a.reject {|k,v| v != 3}).empty?
end

ids_as_char_counts = ids.map{|id| count_each_char id}


num_dupes = ids_as_char_counts.reduce(0) { |total, cc| total + (has_a_dupe?(cc)?1:0)}
num_trips = ids_as_char_counts.reduce(0) { |total, cc| total + (has_a_trip?(cc)?1:0)}

p num_dupes * num_trips