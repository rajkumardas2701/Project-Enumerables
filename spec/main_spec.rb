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
end
