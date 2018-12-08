#! /usr/bin/ruby
# PART 1
#STEPDELAY = 0
#WORKERS = 1

# Part 2
STEPDELAY = 60
WORKERS = 5 

instructions = []
instructions = File.open("input.txt", "r") { |f| f.readlines}.map { |l| l.scan(/\s([A-Z])\s/).flatten}


prerequisites = instructions.flatten.uniq
goal_size = prerequisites.size
path = ""

# find free keys, those that have no pre-requisites
find_freed = -> {
    prerequisites.select { |pre| instructions.none? { |_, dependant| pre == dependant } }.min
}


def time_to_do work
    STEPDELAY + 1 + work.ord - "A".ord
end

workers = Array.new(WORKERS, nil)

0.step do |second|
    workers.each_with_index{ |(work,complete_at),i| 
        if complete_at == second
            path += work
            workers[i] = nil
            instructions.reject! { |x, _| x == work }
        end
    }

    # Get out if done
    if path.size == goal_size
        puts second
        puts path
        break
    end
    
    workers.each_index{ |i| 
        # If worker is working, sip
        next if workers[i]

        task = find_freed.call
        
        next unless task

        task_time = second + time_to_do(task)

        workers[i] = [task, task_time]
        prerequisites.delete task
    }
end