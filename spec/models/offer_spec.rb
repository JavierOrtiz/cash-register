require 'rspec'
require './db/seed'
require './models/offer'

describe Offer do
  describe '#initialize' do
    let(:name) { 'Test Offer' }
    let(:slug) { 'test_offer' }
    let(:logic) { 'test logic' }

    subject(:offer) { Offer.new(name, slug, logic) }

    it 'assigns the name correctly' do
      expect(offer.name).to eq(name)
    end

    it 'assigns the slug correctly' do
      expect(offer.slug).to eq(slug)
    end

    it 'assigns the logic correctly' do
      expect(offer.logic).to eq(logic)
    end
  end

  describe '.all' do
    it 'returns Offer instances' do
      expect(Offer.all).to all(be_an Offer)
    end
  end
end