class ChangeUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.rename :password, :password_digest
      t.rename :login, :email
      t.index :email, unique: true
    end
  end
end
