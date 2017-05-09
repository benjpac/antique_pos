require 'spec_helper'

describe Purchase do
  describe '#items' do
    it 'tells you which items it has' do
      purchase = Purchase.create({:customer => 'Ben'})
      item = Item.create({:name => 'item', :price => 9.99, :purchase_id => purchase.id()})
      item1 = Item.create({:name => 'item', :price => 9.99, :purchase_id => purchase.id()})
      item2 = Item.create({:name => 'item', :price => 9.99, :purchase_id => 0})
      expect(purchase.items()).to eq([item, item1])
    end
  end
end
