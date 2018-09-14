class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false
      t.string :title, null: false
      t.integer :ord, null: false
      t.text :lyrics, null: false
      t.boolean :is_bonus, null: false, default: false

      t.timestamps
    end
    add_index :tracks, :album_id
    add_index :tracks, [:title, :ord], unique: true
    add_index :tracks, :ord
    add_index :albums, :title
  end
end
