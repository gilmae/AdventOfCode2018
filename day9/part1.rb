TEST = ARGV.delete("-t")
VERBOSE = ARGV.delete('-v')
EXTRA_VERBOSE = VERBOSE && ARGV.delete('-x')

PLAYERS = (ARGV[0]&.to_i) || 452
LAST_MARBLE = ARGV[1]&.to_i || 71250

puts "#{PLAYERS} playing to Marble # #{LAST_MARBLE}" if VERBOSE
current_marble  = 0
scores = [0] * (PLAYERS + 1)
log = []
marbles = 
marbles = [0]

play = -> (players, last_marbles) {
puts("(0)")  if VERBOSE
(1..last_marbles).step { |i|
    puts i
    player = i%players
    player = players if player == 0
    if i < 2
        log << "Marble #{i} added by player #{player}"
        marbles.push i
        current_marble = i
    elsif i%23 != 0
        log << "Marble #{i} added by player #{player}"
        next_index = marbles.index(current_marble) + 2
        next_index = next_index % marbles.size if next_index > marbles.size

        marbles.insert(next_index, i)
        current_marble = i
    else
        points = i
        
        remove_at_index = marbles.index(current_marble) - 7

        (remove_at_index = marbles.size + remove_at_index) if remove_at_index < 0

        removed_marble = marbles.delete_at(remove_at_index)

        points += removed_marble
        scores[player] += points
        
        log << "MArble #{i} is a multiple of 23, player #{player} captures #{removed_marble} for #{points} points for a total of #{scores[player]}"

        current_marble = marbles[remove_at_index]
    end

    puts "[#{player}]  " + marbles.join("   ").gsub(/\s?#{current_marble}\s?/, "(#{current_marble})") if EXTRA_VERBOSE
}

#puts log.join("\n") if VERBOSE
    scores.minmax
}

min, max = play.call(PLAYERS, LAST_MARBLE)
p max
p min