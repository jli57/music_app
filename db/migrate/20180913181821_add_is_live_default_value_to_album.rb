class AddIsLiveDefaultValueToAlbum < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :is_live, :boolean, default: false
  end
end
