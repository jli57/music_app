class AddAlbumIdToTrackIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :tracks, [:title, :ord]
    add_index :tracks, [:album_id, :ord], unique: true
  end
end
