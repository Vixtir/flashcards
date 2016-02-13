class AddAttemptColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :attempt, :integer, default: 0
  end
end
