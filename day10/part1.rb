vectors = File.open("test.txt", "r") { |f| 
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

    puts
 
    (ymin..ymax).each { |yy| 
        (xmin..xmax).each { |xx| 
            print points.include?([xx,yy])?'x':' '
        }
        puts
    }
    puts
}


# How to know when to stop?
# If the points are merging together to form a word,
# then the bounding box of the points is shrinking
# Then on the first step afterwards the bounding box of the points
# becomes larger?

positions = [nil] * vectors.size
vectors.each_with_index { |(x,y,dx,dy),i| 
    positions[i] = move.call(x,y,dx,dy,3)
}

print.call(positions)


