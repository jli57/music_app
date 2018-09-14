class AddOptionalToLyricsInTracks < ActiveRecord::Migration[5.2]
  def change
    change_column :tracks, :lyrics, :text, null: true
  end
end
