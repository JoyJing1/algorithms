require_relative 'graph'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Tarian's Algorithm
def topological_sort(vertices)
  order = []
  explored = Set.new

  vertices.each do |vertex|
    dfs(vertex, explored, order) unless explored.include?(vertex)
  end

  order
end

# Depth First Search - helper function
def dfs(vertex, explored, order)
  explored.add(vertex)

  vertex.out_edges.each do |edge|
    new_vertex = edge.to_vertex
    dfs(new_vertex, explored, order) unless explored.include?(new_vertex)
  end

  order.unshift(vertex)
end
