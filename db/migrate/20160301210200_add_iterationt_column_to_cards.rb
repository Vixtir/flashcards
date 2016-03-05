class AddIterationtColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :i, :integer, default: 1
  end
end
