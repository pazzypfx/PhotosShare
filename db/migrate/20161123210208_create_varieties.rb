class CreateVarieties < ActiveRecord::Migration[5.0]
  def change
    create_table :varieties do |t|
      t.string :name
      t.string :variety_code
      t.references :product

      t.timestamps
    end
  end
end
