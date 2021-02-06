vectors = File.open("input.txt", "r") { |f| 
    f.readlines.map { |l|
        l.scan(/-?\d+/).map{ |p| 
            p.to_i
        }
    }
}

move = -> (x,y,dx,dy,s) {
    [x+dx*s, y+dy*s]
}

print = -> (points) {
    ymin, ymax = points.map{ |i| i.last}.minmax
    xmin, xmax = points.map{ |i| i.first}.minmax

    (ymin..ymax).each { |yy| 
        (xmin..xmax).each { |xx| 
            print points.include?([xx,yy])?'x':' '
        }
        puts
    }
    puts
}

get_area = -> (points){
    ymin, ymax = points.map{ |i| i.last}.minmax
    xmin, xmax = points.map{ |i| i.first}.minmax

    (ymax-ymin).abs * (xmax-xmin).abs
}


# How to know when to stop?
# If the points are merging together to form a word,
# then the bounding box of the points is shrinking
# Then on the first step afterwards the bounding box of the points
# becomes larger?

last_area = (2**(0.size * 8 -2) -1)
area = last_area - 1
ticks = []
while area <= last_area

    last_area = area
    positions = [nil] * vectors.size
    vectors.each_with_index { |(x,y,dx,dy),i| 
        positions[i] = move.call(x,y,dx,dy,ticks.length)
    }

    ticks.append(positions)
    ymin, ymax = positions.map{ |i| i.last}.minmax
    xmin, xmax = positions.map{ |i| i.first}.minmax

    xa = (xmax-xmin).abs
    ya = (ymax-ymin).abs
    area = xa*ya
end
puts ticks.length-2
print.call(ticks[-2])




