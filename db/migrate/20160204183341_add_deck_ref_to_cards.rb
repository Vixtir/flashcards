class AddDeckRefToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :deck, index: true, foreign_key: true
  end
end
