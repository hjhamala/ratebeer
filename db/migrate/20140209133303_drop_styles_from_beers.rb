class DropStylesFromBeers < ActiveRecord::Migration
  def change
    change_table :beers do |t|
      t.remove :style
      t.integer :style_id
    end
  end
end
