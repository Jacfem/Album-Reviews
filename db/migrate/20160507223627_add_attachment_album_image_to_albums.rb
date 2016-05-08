class AddAttachmentAlbumImageToAlbums < ActiveRecord::Migration
  def self.up
    change_table :albums do |t|
      t.attachment :album_image
    end
  end

  def self.down
    remove_attachment :albums, :album_image
  end
end
