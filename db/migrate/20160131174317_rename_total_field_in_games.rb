class RenameTotalFieldInGames < ActiveRecord::Migration
  def change
    rename_column :games, :total, :score
    change_column :games, :score, :integer, default: false
  end
end
