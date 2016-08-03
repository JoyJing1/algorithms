require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's Algorithm
def topological_sort(vertices)

  # Declare variables so we do not mutate the original objects
  all_vertices = vertices
  num_in_edges = {}
  zero_in_nodes = []
  removed_nodes = []

  # Add vertices with no incoming edges
  # to zero_in_nodes queue
  all_vertices.each do |vertex|
    num_in_edges[vertex] = vertex.in_edges.length
    if num_in_edges[vertex] == 0
      zero_in_nodes.unshift(vertex)
    end
  end

  # Iterate through zero_in_nodes until empty
  until zero_in_nodes.empty?
    u = zero_in_nodes.pop()
    removed_nodes.push(u)
    all_vertices.delete(u)

    # Remove vertex and corresponding edges
    u.out_edges.each do |edge|
      new_vertex = edge.to_vertex
      num_in_edges[new_vertex] -= 1

      # If removal of vertex leads new_vertex
      # to not have any in_edges, then add
      # new_Vertex to zero_in_nodes
      if num_in_edges[new_vertex] == 0
        zero_in_nodes.unshift(new_vertex)
      end
    end

  end

  # If not all vertices have been reached, we have a cycle
  # so return []
  all_vertices.empty? ? removed_nodes : []
end

# v1 = Vertex.new("Wash Markov")
# v2 = Vertex.new("Feed Markov")
# v3 = Vertex.new("Dry Markov")
# v4 = Vertex.new("Brush Markov")
# vertices = []
#
# vertices.push(v1, v2, v3, v4)
# Edge.new(v1, v2)
# Edge.new(v1, v3)
# Edge.new(v2, v4)
# Edge.new(v3, v4)
#
# solution = topological_sort(vertices.shuffle)
#
# p solution[0].value
# p solution[1].value
# p solution[2].value
# p solution[3].value
