class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :password_digest
      t.boolean :active

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
