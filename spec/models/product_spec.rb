require 'rspec'
require './db/seed'
require './models/product' # Assuming this is the file path

describe Product do
  describe '#initialize' do
    let(:code) { '001' }
    let(:name) { 'Test Product' }
    let(:price_in_cents) { 999 }

    subject { Product.new(code, name, price_in_cents) }

    it 'assigns the code correctly' do
      expect(subject.code).to eq(code)
    end

    it 'assigns the name correctly' do
      expect(subject.name).to eq(name)
    end

    it 'assigns the price correctly' do
      expect(subject.price_in_cents).to eq(price_in_cents)
    end
  end

  describe '.all' do
    it 'returns instances of Product' do
      expect(Product.all).to all(be_an Product)
    end
  end
end