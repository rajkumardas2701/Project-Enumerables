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

  def my_all?(arg = nil, &block)
    if block_given?
      my_each { |x| return false if block.call(x) == false }
    elsif arg.is_a?(Regexp)
      my_each { |x| return false if arg.match?(x.to_s) == false }
    elsif arg.is_a?(Class)
      my_each { |x| return false if x.is_a?(arg) == false }
    elsif arg.nil? == false
      my_each { |x| return false if arg != x }
    else
      my_each { |x| return false unless x }
    end
    true
  end

  def my_any?(arg = nil, &block)
    if block_given?
      my_each { |x| return true if block.call(x) }
    elsif arg.is_a?(Regexp)
      my_each { |x| return true if arg.match?(x.to_s) == true }
    elsif arg.is_a?(Class)
      my_each { |x| return true if x.is_a?(arg) }
    elsif arg.nil? == false
      my_each { |x| return true if arg == x }
    else
      my_each { |x| return true if x }
    end
    false
  end

  def my_none?(arg = nil, &block)
    if block_given?
      my_each { |x| return false if block.call(x) }
    elsif arg.is_a?(Regexp)
      my_each { |x| return false if arg.match?(x.to_s) == true }
    elsif arg.is_a?(Class)
      my_each { |x| return false if x.is_a?(arg) }
    elsif arg.nil? == false
      my_each { |x| return false if x == arg }
    else
      my_each { |x| return false if x }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |x| count += 1 if yield(x) }
    elsif arg.nil? == false
      my_each { |x| count += 1 if x == arg }
    elsif arg.nil? and block_given? == false
      my_each { |x| count += 1 unless x.nil? }
    end
    count
  end

  def my_map(*prc)
    return to_enum :my_each unless block_given?

    array = []
    if prc[0]
      my_each { |x| array << prc[0].call(x) }
    else
      my_each { |x| array << yield(x) }
    end
    array
  end

  def my_inject(*args)
    arr = is_a?(Range) ? to_a : self
    int_val = args[0] if args[0].is_a?(Integer)
    op = args[0].is_a?(Symbol) ? args[0] : args[1]
    if op
      arr.my_each { |x| int_val = int_val ? int_val.send(op, x) : x }
      return int_val
    end
    arr.my_each { |x| int_val = int_val ? yield(int_val, x) : x }
    int_val
  end
end

# End of Enumerable

def multiply_els(array)
  array.my_inject { |product, n| product * n }
end
