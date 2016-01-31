class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :score, default: 0
      t.boolean :closed, default: false

      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
