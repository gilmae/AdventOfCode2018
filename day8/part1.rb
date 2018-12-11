#! /usr/bin/ruby
data = File.open("input.txt", "r") { |f| f.readlines}.map { |l| l.scan(/\d+/)}.flatten.map{ |i| i.to_i}

nodes = []
read_nodes = -> (data) {
    #puts "Reading node #{id.chr}"
    node = [[],[], 0]

    children = data.shift
    metadata = data.shift
    children.times { |i| 
        #puts "Read child #{i}"
        node[0].push read_nodes.call(data)
    }

    metadata.times { |i|
        #puts "Read metadata #{i}"
        node[1].push data.shift
    }

    node
}

def sum_metadata node
    sum = node[1].inject(0) {|m,o| m+o}
    sum = node[0].inject(sum) {|m,o| m + sum_metadata(o)}
    sum
end

# Tricksy - the children are zero-indexed but the metadata is 1-indexed
def sum_metadata_the_weird_way node
    if node[0].size > 0
        node[2] = node[1].inject(0) {|m,o| 
            if o == 0
                m + 0
            elsif o <= node[0].size
                m + (sum_metadata_the_weird_way(node[0][o-1]) || 0)
            else
                m + 0
            end
        }
    else
        node[2] = sum_metadata node
    end
    node[2]
end

node = read_nodes.call(data)

p sum_metadata(node)

p sum_metadata_the_weird_way(node)



