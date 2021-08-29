class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :password
      t.string :token
      t.string :address

      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end
