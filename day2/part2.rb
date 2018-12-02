#! /usr/bin/ruby

# Maybe regexs?

ids = []
File.open("input.txt", "r") do |f|
    f.each_line do |l| 
        ids << l.chomp!
    end
end

ids.each_index do |i|
    id_as_array = ids[i].split("")

    id_as_array.each_index do |j|
        tester = id_as_array.clone
        tester[j] = "."

        test_regex = Regexp.new(tester.join(""))

        k = ids.length-1
        while k > i 
            result = test_regex =~ ids[k]
            
            if !(test_regex =~ ids[k]).nil?
                p tester.reject { |ch|  ch=="."}.join("")
                exit
            end
            k = k-1
        end
    end

end


