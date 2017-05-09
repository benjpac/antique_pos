class FixTimestamp < ActiveRecord::Migration[5.1]
  def change
    add_column(:items, :created_at, :datetime)
    add_column(:items, :updated_at, :datetime)
    add_column(:purchases, :created_at, :datetime)
    add_column(:purchases, :updated_at, :datetime)
  end
end
