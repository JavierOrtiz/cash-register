require 'rspec'
require './services/calculator_service'
require './models/product_offer'
require './models/offer'
require './models/product'

describe CalculatorService do
  let!(:products_attrs) do
    [
      { code: 'GR1', name: 'Green Tea', price_in_cents: 1500 },
      { code: 'GR1', name: 'Green Tea', price_in_cents: 1500 },
      { code: 'GR1', name: 'Green Tea', price_in_cents: 1500 },
      { code: 'SR1', name: 'Strawberries', price_in_cents: 2500 },
      { code: 'SR1', name: 'Strawberries', price_in_cents: 2500 },
      { code: 'SR1', name: 'Strawberries', price_in_cents: 2500 }
    ]
  end

  let!(:products) { products_attrs.map { |attrs| Product.new(attrs[:code], attrs[:name], attrs[:price_in_cents]) } }
  subject { described_class.new(products) }

  describe '#calculate' do
    context 'with_discount flag is false' do
      it 'returns total amount without discount' do
        expect(subject.calculate(with_discount: false)).to eq(120.0)
      end
    end

    context 'with_discount flag is true' do
      it 'returns total amount with discount' do
        expect(subject.calculate(with_discount: true)).to eq(19.72)
      end
    end
  end

  describe '#calculate_total_with_discount' do
    it 'calculates the total with discounts' do
      result = subject.send(:calculate_total_with_discount)
      expect(result).to eq(19.72)
    end
  end

  describe '#total_amount' do
    it 'calculates the total without discounts' do
      result = subject.send(:total_amount)
      expect(result).to eq(120.0)
    end
  end

  # you can add additional tests for other private methods as necessary

end