class Seed
  def self.offers
    [
      { name: '2x1', slug: 'two_plus_one', logic: '((quantity / 2) + (quantity % 2)) * unit_price' },
      { name: 'Bulk purchase', slug: 'custom_bulk_purchase', logic: 'quantity >= min_quantity ? quantity * new_unit_price : quantity * unit_price' }
    ]
  end
end