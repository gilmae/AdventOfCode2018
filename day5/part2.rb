stream = File.open("input.txt", "r") {|f| f.readlines}.join("").chomp


def react stream
    while true
        break if (?a..?z).all? { |ch| 
            [
                stream.gsub!("#{ch}#{ch.upcase}", ""),
                stream.gsub!("#{ch.upcase}#{ch}", "")
            ].none?
        }   
    end
    stream
end

reactions_after_removing_elements = (?a..?z).map do |ch|
    puts "Testing with no #{ch}"
    react(stream.gsub(Regexp.new("[#{ch}#{ch.upcase}]"), "")).size
end

puts reactions_after_removing_elements.sort.first

