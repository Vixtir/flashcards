class AddBucketColumnToCards < ActiveRecord::Migration
  def change
    add_column :cards, :bucket, :integer, default: 1
  end
end
