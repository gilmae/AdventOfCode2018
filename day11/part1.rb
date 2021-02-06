GRID_SERIAL_NO = 8444

def power_level x, y
    rack_id = x+10
    init_power_level = (rack_id * y) + GRID_SERIAL_NO
    racked_power_level = init_power_level * rack_id
    hundredth_digit = (racked_power_level / 100) % 10

    hundredth_digit - 5
end


def eval_square(cells, square_size, squares, max, highest)
    ret = max
        (1..301-square_size).each{ |x|
            p squares.length 
            ret, highest = eval_square_inner(x,ret,cells,square_size, squares,max,highest)
        }
    return ret, highest
end

def eval_square_inner(x, ret, cells, square_size, squares, max, highest)
    (1..301-square_size).each { |y|
        cached = squares[[x,y,square_size-1]]
        total = cached
        if total.nil?
            p "cache miss"
            total = 0
        end

        (0..square_size-1).each { |offsetX|
            total+=cells[[x+offsetX, y+square_size-1]]
        }

        (0..square_size-1).each { |offsetY| 
            total += cells[[x+square_size-1, y+offsetY]]
        }

        total -= cells[[x+square_size-1,y+square_size-1]]

        squares[[x,y,square_size]] = total

        if total > ret
           ret = total
           highest = [x,y,square_size]
           #p highest
        end
    }

    return ret,highest
end

cells = {}
(1..300).each {|x|
    (1..300).each {|y|
        cells[[x,y]] = power_level x,y
    }
}

squares = {}

ret, highest = eval_square(cells,1,squares,-1000,highest)
ret, highest = eval_square(cells,2,squares,-1000,highest)
ret, highest = eval_square(cells,3,squares,-1000,highest)

p highest
max = -1000
(4..300).each { |size|
    p size
    ret, highest = eval_square(cells,size,squares,max,highest)
    ret = max if ret > max
}

p ret
