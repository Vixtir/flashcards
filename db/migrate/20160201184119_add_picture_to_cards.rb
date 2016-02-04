class AddPictureToCards < ActiveRecord::Migration
  def change
    add_column :cards, :picture, :string
  end
end
