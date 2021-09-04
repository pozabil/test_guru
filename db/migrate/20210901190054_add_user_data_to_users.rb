class AddUserDataToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :login, :string, null: false
    add_column :users, :password, :string, null: false
  end
end
