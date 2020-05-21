require './lib/main'

describe Enumerable do
  describe 'my_each' do
    it 'should display all the numbers in an array' do
      a = %w[sharon leo anthony]
      expect(a.my_each { |x| x }).to eq(%w[sharon leo anthony])
    end

    it 'should return an enum if no block is given' do
      a = %w[sharon leo anthony]
      expect(a.my_each.class).to eq(Enumerator)
    end

    it 'should return an enum if no block is given' do
      a = %w[sharon leo anthony]
      expect(a.my_each.to_enum).to be_a(Enumerator)
    end

    it 'should return Class when no Enumerator and block given' do
      a = %w[sharon leo anthony]
      expect(a.my_each.to_enum).not_to eq(Class)
    end
  end

  describe 'my_each_with_index' do
    it 'should return elements and index in an array' do
      arr = []
      %w[sharon leo anthony].my_each_with_index { |name, index| arr << name if index.even? }
      expect(arr).to eql(%w[sharon anthony])
    end

    it 'should return enumrator if block is not given' do
      expect(%w[sharon leo anthony].my_each_with_index.class).to eql(Enumerator)
    end

    it 'should return Class when no bock and Enumerator is given' do
      expect(%w[sharon leo anthony].my_each_with_index.class).not_to eql(Class)
    end
  end

  describe 'my_select' do
    it 'should return array elements meeting specific condition' do
      arr = []
      [1, 2, 3, 4, 5].my_select { |x| arr.push(x) if x.even? }
      expect(arr).to eq([2, 4])
    end

    it 'should return enumrator if block is not given' do
      expect([1, 2, 3, 4, 5].my_select.class).to eq(Enumerator)
    end

    it 'should return Class when no bock and Enumerator is given' do
      expect([1, 2, 3, 4, 5].my_select.class).not_to eq(Class)
    end
  end

  describe 'my_all' do
    it 'should return true if a block is given and all elements meet the specified condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should return false if a block is given and all elements do not meet the specified condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'should return false if all elements do not belong to a specified class' do
      expect([1, 'String', 3.14].my_all?(Numeric)).to eql(false)
    end

    it 'should return true if all elements match a regular expression' do
      expect(%w[ant bat cat].my_all?(/t/)).to eql(true)
    end

    it 'should return false if all elements do not belong to a specified class' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'should return true if all elements are equal to an argument' do
      expect([1, 1, 1].my_all?(1)).to eql(true)
    end

    it 'should return false if all elements are not equal to an argument' do
      expect([1, 11, 111].my_all?(1)).to eql(false)
    end

    it 'should return true if no block is given but the array has no falsey value' do
      expect(%w[ant bear cat].my_all?).to eql(true)
    end

    it 'should return false if no block is given but the array has a falsey value' do
      expect([1, nil, 3].my_all?).to eql(false)
    end
  end

  describe 'my_any' do
    it 'should return true if a block is given and any element meets the specified condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length > 3 }).to eql(true)
    end

    it 'should return false if a block is given and no element meets the specified condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length == 1 }).to eql(false)
    end

    it 'should return false if no element belongs to a specified class' do
      expect(%w[ant bear cat].my_any?(Numeric)).to eql(false)
    end

    it 'should return true if any element matches a regular expression' do
      expect(%w[ant bear barn].my_any?(/t/)).to eql(true)
    end

    it 'should return false if no element matches a regular expression' do
      expect(%w[song bro from].my_any?(/t/)).to eql(false)
    end

    it 'should return true if any element is equal to specified argument' do
      expect([1, 2, 3].my_any?(1)).to eql(true)
    end

    it 'should return false if no element is equal to specified argument' do
      expect([11, 11, 111].my_any?(1)).to eql(false)
    end

    it 'should return true if at least one element in the array is truthy' do
      expect([1, nil, nil].my_any?).to eql(true)
    end

    it 'should return false if all elements evaluate to falsey' do
      expect([nil, nil, nil].my_any?).to eql(false)
    end
  end

  describe 'my_none?' do
    it 'When no block and no argument are given, returns `false` when one of the elementes is truthy != (nil, false)' do
      expect([nil, true, 88].my_none?).to eq(false)
    end

    it 'When an array is empty and no block is given, will return `true`' do
      expect([].my_none?).to eq(true)
    end

    it 'should return false if all elements match a regular expression' do
      expect(%w[ant bat cat].my_none?(/t/)).to eql(false)
    end

    it 'When block is given, it evaluates the elements and returns `false` when one of them meets the condition' do
      expect(%w[ant bat cat].my_none? { |word| word.length >= 3 }).to eq(false)
    end

    it 'When an argument and a block are given, it ignores the block and returns `false`
    if one of the elements meets the
    condition in the argument' do
      expect(%w[ant bat cat].my_none?(Numeric) { |word| word.length >= 3 }).to eq(false)
    end

    it 'raises an ArgumentError when more than one arguments are given' do
      expect { %w[ant bat cat].my_none?(String, 1) }.to raise_error(ArgumentError)
    end
  end

  describe 'my_count' do
    it 'When no block and no argument are give returns the number of elements' do
      expect([1, 2, 3, 4].my_count).to eq(4)
    end

    it 'When an array is empty and no block is given, will return 0' do
      expect([].my_count).to eq(0)
    end

    it 'raises an ArgumentError when more than one arguments are given' do
      expect { [1, 2, 3, 4].my_count(String, 1) }.to raise_error(ArgumentError)
    end

    it 'When block is given, it evaluates the elements and returns the elements when them meets the condition' do
      expect([1, 2, 3, 4].my_count { |x| (x % 2).zero? }).to eq(2)
    end

    it 'When an argument (not a Class or RegEx) is passed, it evaluates the elements and returns the
    elements that meets the conditions' do
      expect([1, 2, 3, 4].my_count(2)).to eq(1)
    end
  end

  describe 'my_map' do
    it 'When block is given, it passes each element as an argument of the
    method in the block and returns a new array' do
      expect([18, 22, 5, 6].my_map { |num| num < 10 }).to eq([false, false, true, true])
    end

    it 'When proc is given, it will priortize proc and return result accordingly' do
      my_proc = proc { |num| num > 10 }
      expect([18, 22, 5, 6].my_map(my_proc) { |num| num < 10 }).to eq([true, true, false, false])
    end
  end

  describe 'my_inject' do
    it 'When block is given, it passes each element as an argument of the method in the block and stores
    it in the memo variable, returns the result of memo at the end' do
      expect([1, 2, 3, 2].my_inject { |memo, element| memo / element }).to eq(0)
    end

    it 'When block and an argument are given, it passes each element and the argument as an argument
     of the method in the block and stores it in the memo variable, returns the result of memo at the end' do
      expect([1, 2, 3, 2].my_inject { |memo, element| memo * element }).to eq(12)
    end

    it 'When block and two argument are given, it ignores the block and it passes each element and the argument
    as an argument of the method provided in the second argument and returns the result ' do
      expect([1, 2, 3, 2].my_inject(2, :+) { |memo, element| memo / element }).to eq(10)
    end

    it 'When an array is empty and no block is given, will return nil' do
      expect([].my_inject).to eq(nil)
    end
  end
end
