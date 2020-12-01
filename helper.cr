def manhattan_distance(x1 : Int32, y1 : Int32, x2 : Int32, y2 : Int32)
  (x1 - x2).abs + (y1 - y2).abs
end

def breadth_first_search(
  grid : Array(Array(String)),
  start : NamedTuple(x: Int32, y: Int32),
  goal : NamedTuple(x: Int32, y: Int32),
  can_visit = ->(symbol : String) { true }
)
  width = grid.first.size
  height = grid.size

  dx = [0, 1, 0, -1]
  dy = [1, 0, -1, 0]

  seen = Set(NamedTuple(x: Int32, y: Int32)).new
  queue = Array(NamedTuple(x: Int32, y: Int32, steps: Int32)).new

  queue << {x: start[:x], y: start[:y], steps: 0}

  while queue.size > 0
    # Get next item from queue
    current = queue.shift

    x = current[:x]
    y = current[:y]
    steps = current[:steps]

    return current if x == goal[:x] && y == goal[:y]

    # Skip seen
    wo_steps = {x: x, y: y}
    next if seen.includes? wo_steps
    seen << wo_steps

    # Check direction vectors
    4.times do |di|
      xx = x + dx[di]
      yy = y + dy[di]

      next if xx < 0
      next if yy < 0
      next if xx >= width
      next if yy >= height
      symbol = grid[yy][xx]
      next if !can_visit.call(symbol)

      queue << {x: xx, y: yy, steps: steps + 1}
    end
  end
end

def depth_first_search(
  grid : Array(Array(String)),
  start : NamedTuple(x: Int32, y: Int32),
  goal : NamedTuple(x: Int32, y: Int32),
  can_visit = ->(symbol : String) { true }
)
  width = grid.first.size
  height = grid.size

  dx = [0, 1, 0, -1]
  dy = [1, 0, -1, 0]

  seen = Set(NamedTuple(x: Int32, y: Int32)).new
  queue = Array(NamedTuple(x: Int32, y: Int32, steps: Int32)).new

  queue << {x: start[:x], y: start[:y], steps: 0}

  while queue.size > 0
    # Get next item from queue
    current = queue.max_by { |item| item[:steps] }
    queue.delete(current)

    x = current[:x]
    y = current[:y]
    steps = current[:steps]

    return current if x == goal[:x] && y == goal[:y]

    # Skip seen
    wo_steps = {x: x, y: y}
    next if seen.includes? wo_steps
    seen << wo_steps

    # Check direction vectors
    4.times do |di|
      xx = x + dx[di]
      yy = y + dy[di]

      next if xx < 0
      next if yy < 0
      next if xx >= width
      next if yy >= height
      symbol = grid[yy][xx]
      next if !can_visit.call(symbol)

      queue << {x: xx, y: yy, steps: steps + 1}
    end
  end
end

def find_symbol(grid : Array(Array(String | Int32)), symbol : String | Int32)
  y_index = grid.index(&.includes?(symbol))
  return {x: -1, y: -1} if !y_index
  x_index = grid.select(&.includes?(symbol)).first.index(symbol)
  return {x: -1, y: -1} if !x_index
  return {x: x_index, y: y_index}
end

lab = "
###########
#         #
# # ### # #
#S# # # #T#
##    #   #
###########"
  .strip
  .split("\n")
  .map(&.split(""))

start = find_symbol(lab, "S")
goal = find_symbol(lab, "T")

puts start
puts goal

not_wall = ->(symbol : String) { symbol != "#" }

puts depth_first_search(lab, start, goal, not_wall)
puts breadth_first_search(lab, start, goal, not_wall)
