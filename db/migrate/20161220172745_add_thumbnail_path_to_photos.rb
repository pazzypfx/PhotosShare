class AddThumbnailPathToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :thumbnail_path, :string, after: :path
  end
end
