require './lib/main'

describe Enumerable do
    describe 'my_each' do
      it 'should display all the numbers in an array' do
        a = ['sharon', 'leo', 'anthony']
        expect(a.my_each {|x| x} ).to eq(['sharon', 'leo', 'anthony'])
      end

      it 'should return an enum if no block is given' do
        a = ['sharon', 'leo', 'anthony']
        expect(a.my_each.class).to eq(Enumerator)
      end
    end
end