class AddAgeToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :age, :integer
  end
end
