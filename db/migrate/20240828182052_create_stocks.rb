class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.references :product, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true
      t.string :warehouse_name
      t.integer :quantity
      t.datetime :datetime

      t.timestamps
    end
  end
end
