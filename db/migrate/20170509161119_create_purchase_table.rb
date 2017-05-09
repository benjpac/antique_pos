class CreatePurchaseTable < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.column :customer, :string
      t.column :total_price, :decimal, :precision => 8, :scale => 2

      t.timestamp
    end
  end
end
