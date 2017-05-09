class CreateItemsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.column :name, :string
      t.column :price, :decimal, :precision => 8, :scale => 2
      t.column :purchase_id, :integer

      t.timestamp
    end
  end
end
