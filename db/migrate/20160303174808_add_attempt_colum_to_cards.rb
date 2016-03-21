class AddAttemptColumToCards < ActiveRecord::Migration
  def change
    add_column :cards, :attempt, :integer, default: 1
  end
end
