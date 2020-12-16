data = File.open("input.txt", "r") { |f| 
    f.readlines.map { |l|
        l.chomp
    }
}

def print_pots pot_generations

    min = pot_generations.map{|p| p.keys.min}.min
    max = pot_generations.map{|p| p.keys.max}.max
    puts "#{min} to #{max}"
    pot_generations.each_with_index {|pots, generation|
        o = "#{generation.to_s.rjust(3,"0")}: "
        (min..max).each {|pot|
            
            if pots[pot].nil?
                o+= "."
            else
                o += pots[pot]
            end
            
        }
        puts o
    }
end

def get_active_plant_pot_sum pots
    s = 0
    pots.keys.each {|k|
        s += k if pots[k] == "#"
    }
    s
end

def get_pots pots, pot_index
    slice = ""
    (pot_index-2..pot_index+2).each {|p|
        if !pots[p].nil?
            slice += pots[p]
        else
            slice += "."
        end
    }
    slice
end

pots = Hash[data[0].sub("initial state: ", "").chars.map.with_index{|p,i| [i,p]}]
left_most_pot_number = 0
pot_generations = [pots]

memo = {}


rules = {}

rules = Hash[data[2..-1].map {|r|
    parts = r.split(" => ").map(&:strip)
}]

generations = 50000000000
 (1..generations).each {|generation|
    if memo.include?(pots.values.join)
        # ## Have we reached stability? 
        # i.e. are the last two generations the same?
        if pot_generations[-1].values.join("") == pot_generations[-2].values.join("")
            sighting = memo[pots.values.join]
            puts "Reached stability at generation #{generation}"
            
            next_state = {}
        
            next_min = pots.keys.min + (sighting[1] * generations-generation+1)
            sighting[0].chars.each_with_index {|p,i|
                next_state[next_min + i] = p
            }
            pots = next_state
            pot_generations.push next_state
            break
        end
        
        sighting = memo[pots.values.join]
        #puts "Seen this before::#{generation}"
        next_state = {}
        
        next_min = pots.keys.min + sighting[1]
        sighting[0].chars.each_with_index {|p,i|
            next_state[next_min + i] = p
        }
        pots = next_state
        pot_generations.push next_state
        next
    end
    next_state = {}
    min,max = pots.keys.minmax
    left_most_pot_number = pots.keys.min-5
    right_most_pot_number = pots.keys.max+5

    (left_most_pot_number..right_most_pot_number).each { | pot_index |
        pot_pattern = get_pots pots, pot_index
        
        new_pot = rules[pot_pattern]

        new_pot = "." if new_pot.nil?
        next_state[pot_index] = new_pot
    }
    
    
    while next_state[left_most_pot_number] == "."
        next_state.delete(left_most_pot_number)
        left_most_pot_number+=1
    end
    while next_state[right_most_pot_number] == "."
        next_state.delete(right_most_pot_number)
        right_most_pot_number-=1
    end
    
    newmin,newmax = next_state.keys.minmax
    
    memo[pots.values.join("")] = [next_state.values.join(""), newmin-min]
    
    pots = next_state
    
    pot_generations.push pots
 }
 
 puts get_active_plant_pot_sum pot_generations.last

