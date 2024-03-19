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
end