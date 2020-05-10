module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    i = 0
    a = is_a?(Range) ? to_a : self
    while i < a.length
      yield self[i]
      i += 1
    end
    self
  end

  # def my_each
  #   return to_enum :my_each unless block_given?

  #   # self.x = x
  #   # self.y = y
  #   i = 0
  #   j = 0
  #   # a = is_a?(Range) ? to_a : self
  #   b = is_a?(Hash) ? to_hash : self
  #   # puts a
  #   # puts b
  #   while i < b.length
  #     yield b
  #     # puts self[i], self[j]
  #     i += 1
  #     j += 1
  #   end
  #   # a, b
  # end

  def my_each_with_index
    i = 0
    return to_enum :my_each unless block_given?

    a = is_a?(Range) ? to_a : self
    while i < a.length
      yield(a[i], i)
      i += 1
    end
    a
  end

  def my_select
    return to_enum :my_each unless block_given?
    arr = []
    my_each { |x| arr.push(x) if yield(x) }
    arr
  end

  def my_all?(arg = nil, &prc)
    return to_enum :my_each unless block_given?
    if block_given? 
    my_each { |x| return false if prc.call(x) == false } 
    elsif arg.nil? == false
      my_each { |x| return false if arg != x}
    elsif arg.is_a?(Regex)
        my_each { |x| return false if arg.match?(x.to_s) == false}
    elsif arg.is_a?(Class)
      my_each {|x| return false if x.is_a?(arg) == false}
    else
      my_each {|x| return false unless x}
    end
    true
  end
end

friends = %w[Sharon Leo Leila Brian Arun]
# movies = { 'a' => 1, 'b' => 2 }
# puts "printing for my_each =>"
# puts "========================="
# friends.my_each { |friend| puts friend }
# movies.each { |key, value| puts "#{key}, #{value}" }
# puts "========================="
# puts "printing for my_each_with_index =>"
# friends.my_each_with_index { |x, y| puts x if y.odd? }

# puts '========================='
# puts 'printing for my_select =>'
# friends.my_select { |x| puts x if x != 'Leo' }
puts '========================='
puts 'printing for my_all? =>'
puts friends.my_all? { |word| word.length >= 3 }
