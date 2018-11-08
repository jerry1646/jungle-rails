class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :email, limit: 60
      t.string :password_digest, limit: 256

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
