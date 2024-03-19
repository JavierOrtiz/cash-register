require './db/seed'

class Offer
  attr_accessor :name, :slug, :logic

  def initialize(name, slug, logic)
    @name = name
    @slug = slug
    @logic = logic
  end

  def self.all
    @all ||= Seed.offers.map do |offer_hash|
      Offer.new(offer_hash[:name], offer_hash[:slug], offer_hash[:logic])
    end
  end
end