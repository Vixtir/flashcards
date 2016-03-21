class AddEfColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :ef, :float, default: 2.5
  end
end
