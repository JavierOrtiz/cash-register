require 'rspec'
require './db/seed'
require './models/product_offer' # Assuming this is the file path

describe ProductOffer do
  describe '#initialize' do
    let(:offer_slug) { 'offer_test' }
    let(:product_code) { '001' }
    let(:min_quantity) { 2 }
    let(:new_unit_price) { 999 }

    subject { ProductOffer.new(offer_slug, product_code, min_quantity, new_unit_price) }

    it 'assigns the offer slug correctly' do
      expect(subject.offer_slug).to eq(offer_slug)
    end

    it 'assigns the product code correctly' do
      expect(subject.product_code).to eq(product_code)
    end

    it 'assigns the minimum quantity correctly' do
      expect(subject.min_quantity).to eq(min_quantity)
    end

    it 'assigns new unit price correctly' do
      expect(subject.new_unit_price).to eq(new_unit_price)
    end
  end

  describe '.all' do
    it 'returns instances of ProductOffer' do
      expect(ProductOffer.all).to all(be_an ProductOffer)
    end
  end
end