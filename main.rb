module Enumerable
  def my_each
    i = 0
    return to_enum :my_each unless block_given?
    
    while i < size     
      yield self[i]
      i += 1
    end
    self
  end


  def my_each_with_index
    i = 0
    return to_enum :my_each unless block_given?

    while i < length
      yield self[i], i
      # puts "#{self[i]} and #{i}"
      i += 1
    end
    return self
  end

  def my_select
    return to_enum :my_each unless block_given?

    my_each {}

  end

end



friends = %w[Sharon Leo Leila Brian Arun]
movies = ["a" => 1, "b" => 2]
puts "printing for my_each =>"
puts "========================="
friends.my_each { |friend| puts friend }
puts "========================="
puts "printing for my_each_with_index =>"
friends.my_each_with_index { |x, y| puts x if y.odd? }