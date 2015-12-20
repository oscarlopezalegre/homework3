class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :total_price
      t.integer :quantity
      t.integer :event_id
      t.integer :ticket_type_id
      t.timestamps null: false
    end
  end
end
