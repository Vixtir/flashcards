class RemoveAttemptColumnFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :attempt
  end
end
