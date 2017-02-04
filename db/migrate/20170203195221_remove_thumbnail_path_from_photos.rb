class RemoveThumbnailPathFromPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :thumbnail_path, :string
  end
end
