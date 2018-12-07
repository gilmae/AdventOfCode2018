points = File.open("input.txt", "r") {|f| 
    f.readlines
}.map {|l|
    l.split(",").map{|i| 
        i.to_i
    }
}

# The effective bounding box. 
ymin, ymax = points.map(&:first).minmax
xmin, xmax = points.map(&:last).minmax

yrange = ymin..ymax
xrange = xmin..xmax

points_that_have_infinite_areas = Array.new(points.size, false)
areas_of_points = Array.new(points.size, 0)

locations_within_10K_steps_of_all_points = 0

yrange.each do |y|
    on_y_edge = y == ymin || y == ymax

    y_distance_from_each_point = points.map { |(_,yy)| (y-yy).abs}

    xrange.each do |x|
        on_x_edge = x == xmin || x == xmax

        best_distance = 1.0/0.0
        point_with_best_distance = nil
        total_dist_to_all_points = 0
        points.each_with_index { |(xx,_), i|
            dist =  (x-xx).abs + y_distance_from_each_point[i]
            
            total_dist_to_all_points +=dist
            
            if (dist < best_distance)
                best_distance = dist
                point_with_best_distance = i
            elsif dist == best_distance
                point_with_best_distance = nil
            end
        }

        (locations_within_10K_steps_of_all_points += 1) if (total_dist_to_all_points < 10000)
        
        next unless point_with_best_distance

        if on_x_edge || on_y_edge
            points_that_have_infinite_areas[point_with_best_distance] = true
        else
            areas_of_points[point_with_best_distance] +=1
        end



        
    end
end

areas_of_points.each_with_index do |_,i|
    areas_of_points[i] = 0 if points_that_have_infinite_areas[i]
end

puts areas_of_points.max
puts locations_within_10K_steps_of_all_points
