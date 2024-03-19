require './db/memory'
require 'rspec'

RSpec.describe Memory do

  before do
    Memory.clear
  end

  describe '.add' do
    it 'adds a pair to the memory' do
      Memory.add(:key, 'value')
      expect(Memory.get(:key)).to eq('value')
    end
  end

  describe '.get' do
    it 'retrieves a value from the memory' do
      Memory.add(:key, 'value')
      expect(Memory.get(:key)).to eq('value')
    end
  end

  describe '.all' do
    it 'returns all values in the memory' do
      Memory.add(:key1, 'test')
      Memory.add(:key2, 'test2')
      expect(Memory.all).to contain_exactly('test', 'test2')
    end
  end

  describe '.delete' do
    it 'deletes a pair from the memory' do
      Memory.add(:key, 'value')
      Memory.delete(:key)
      expect(Memory.get(:key)).to be_nil
    end
  end

  describe '.clear' do
    it 'clears all key-value pairs from the memory' do
      Memory.add(:key1, 'value1')
      Memory.add(:key2, 'value2')
      Memory.clear
      expect(Memory.all).to be_empty
    end
  end
end