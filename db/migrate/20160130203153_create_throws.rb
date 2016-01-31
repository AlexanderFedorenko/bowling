class CreateThrows < ActiveRecord::Migration
  def change
    create_table :throws do |t|
      t.integer :pins
      t.boolean :strike, default: false
      t.boolean :spare, default: false

      t.references :frame, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
