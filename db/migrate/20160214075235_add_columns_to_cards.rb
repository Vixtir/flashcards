class AddColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :bucket, :integer, default: 1
    add_column :cards, :attempt, :integer, default: 0
  end
end
