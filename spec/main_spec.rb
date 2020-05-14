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
end
