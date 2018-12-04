#! /usr/bin/ruby

# Maybe state machine

logs = []
File.open("input.txt", "r") do |f|
    f.each_line do |l| 
        logs << l.chomp!
    end
end

# create a hash of guardId => hash of minute => minutes spent sleeping
sleep_log = Hash.new { |h,k| h[k] = Hash.new(0)}

# Then iterate through the logs.
# If the line includes a shift start, record the guard if
# else if the line includes falling asleep, note the minute
# else if the line includes wake up, iterate from sleep start to current minute
#    setting the bit flags for those minutes in the sleep log
guard_id= nil
starts_sleeping = nil
logs.sort.each do |log|
    last_number = log.scan(/\d+/).last.to_i

    if log.include? "begins shift"
        guard_id = last_number
    elsif log.include? "asleep"
        starts_sleeping = last_number
    elsif log.include? 'wakes'
        woke_up = last_number
        (starts_sleeping..woke_up).each { |min| sleep_log[guard_id][min] += 1}
    end
end

sleep_totals = sleep_log.map do |guard,minutes|
    {guard=>minutes.inject(0) {|m,obj| m + obj.last}}
end
p sleep_totals.flatten

max = -1
guard = 0
sleep_totals.each{ |item| 
    k = item.first.first
    v = item.first.last

    if v > max
        guard = k
        max = v
    end
}
max = -1
minute = 0

sleep_log[guard].each { |k,v| (minute = k;max = v) if v > max}
puts guard * minute

