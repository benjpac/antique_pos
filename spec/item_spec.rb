require 'spec_helper'

describe Item do
  describe '#purchase' do
    it 'tells which purchase it belongs to' do
      purchase = Purchase.create({:customer => 'Ben'})
      item = Item.create({:name => 'item', :price => 9.99, :purchase_id => purchase.id()})
      expect(item.purchase()).to eq(purchase)
    end
  end
end
