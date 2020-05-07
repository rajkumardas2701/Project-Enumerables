module Enumerable
  def my_each
    i = 0
    return to_enum :my_each unless block_given?

    while i < length
      yield self[i]
      # puts "inside while loop #{self[i]}"
      i += 1
    end
    self
  end
end

friends = %w[Sharon Leo Leila Brian Arun]
movies = [a: 1, b: 2]

puts friends.my_each { |friend| friend }
puts movies.my_each { |_x, y| y }
