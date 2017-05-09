class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    remove_column :purchases, :total_price
    remove_column :items, :price
    add_column :purchases, :total_price, :integer
    add_column :items, :price, :integer
  end
end
