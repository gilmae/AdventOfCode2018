TEST = ARGV.delete("-t")
VERBOSE = ARGV.delete('-v')
EXTRA_VERBOSE = VERBOSE && ARGV.delete('-x')

PLAYERS = (ARGV[0]&.to_i) || 452
LAST_MARBLE = ARGV[1]&.to_i || 7125000

puts "#{PLAYERS} playing to Marble # #{LAST_MARBLE}" if VERBOSE

log = []


puts "[1]  " + marbles.join("   ").gsub(/\s?#{current_marble}\s?/, "(#{current_marble})") if EXTRA_VERBOSE

play = -> (players, last_marbles) {
    scores = [0] * (PLAYERS + 1)
    marbles = [nil] * (LAST_MARBLE)
    marbles[0] = 0
    current_marble  = 0
    
    (1..last_marbles).step { |i|
        player = i%players
        player = players if player == 0
        
        if i%23 != 0
            log << "Marble #{i} added by player #{player}"

            current_right = marbles[current_marble]
            
                        
            marbles[i] = marbles[current_right]
            marbles[current_right] = i
            current_marble = i
        else
            points = i
            removed_marble = marbles[i-5]
            
            points += removed_marble 
            scores[player] += points
        
            log << "MArble #{i} is a multiple of 23, player #{player} captures #{removed_marble} for #{points} points for a total of #{scores[player]}"

            current_marble = marbles[i-5] = marbles[removed_marble]
        end

        

        puts "[#{player}]  " + marbles.join("   ").gsub(/\s?#{current_marble}\s?/, "(#{current_marble})") if EXTRA_VERBOSE
    }

    
    scores.minmax
}

min, max = play.call(PLAYERS, LAST_MARBLE)
p max
p min