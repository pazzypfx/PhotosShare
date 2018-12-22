class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :path
      t.references :user, foreign_key: true
      t.references :variety, foreign_key: true
      t.references :place, foreign_key: true
      t.datetime :date
      t.boolean :published

      t.timestamps
    end
    # add_index :photos, :path, unique: true
  end
end
