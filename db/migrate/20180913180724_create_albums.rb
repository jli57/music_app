class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false, index: true
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :is_live, null: false

      t.timestamps
    end
  end
end
