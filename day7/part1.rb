#! /usr/bin/ruby
instructions = []
instructions = File.open("input.txt", "r") { |f| f.readlines}.map { |l| l.scan(/\s([A-Z])\s/).flatten}

keys = instructions.flatten.uniq

prerequisites = {}

prerequisites = keys.map { |k| 
    [k, []]
}.to_h

have_prequisites = {}

instructions.each { |(p,s) |
    prerequisites[s] << p
    have_prequisites[s] = true
}

# find free keys, those that have pre-requisites
def find_freed keys, prerequisites
    keys.map { |k| 
        k if prerequisites[k].empty?
    }.compact
end

def assign_work workers, free, keys, prequisites
    freed = free.shift

    path += freed
    keys.delete(freed)

    keys.each { |k| 
        prerequisites[k].delete(freed)
    }

    free += find_freed(keys, prerequisites)

    free = free.uniq.sort
end

free = find_freed(keys, prerequisites).uniq.sort

path = ""

while !free.empty?
    
    
end

puts path
