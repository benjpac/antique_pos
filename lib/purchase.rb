class Purchase < ActiveRecord::Base
  has_many :items

  scope :created_between, lambda {|start_date, end_date|
    where(:created_at => start_date..end_date)}

  def self.buy(customer, item_ids)
    purchase = Purchase.create({:customer => customer})
    total_price = 0
    item_ids.each() do |item_id|
      item = Item.find(item_id)
      total_price += item.price()
      item.update({:purchase_id => purchase.id()})
    end
    purchase.update({:total_price => total_price})
    return purchase
  end
end
