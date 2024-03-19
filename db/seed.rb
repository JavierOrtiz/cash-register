class Seed
  def self.products
    [
      { code: 'GR1', name: 'Green Tea', price_in_cents: 311 },
      { code: 'SR1', name: 'Strawberries', price_in_cents: 500 },
      { code: 'CF1', name: 'Coffee', price_in_cents: 1123 }
    ]
  end

  def self.offers
    [
      { name: '2x1', slug: 'two_plus_one', logic: '((quantity / 2) + (quantity % 2)) * unit_price' },
      { name: 'Bulk purchase', slug: 'custom_bulk_purchase', logic: 'quantity >= min_quantity ? quantity * new_unit_price : quantity * unit_price' }
    ]
  end

  def self.product_offers
    [
      { offer_slug: 'two_plus_one', product_code: 'GR1', min_quantity: nil, new_unit_price: nil },
      { offer_slug: 'custom_bulk_purchase', product_code: 'SR1', min_quantity: 3, new_unit_price: 450 },
      { offer_slug: 'custom_bulk_purchase', product_code: 'CF1', min_quantity: 3, new_unit_price: 'price * (2.0 / 3.0)' }
    ]
  end
end