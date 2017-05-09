class Item < ActiveRecord::Base
  belongs_to :purchase
  validates :name, :price, :presence => true
end
