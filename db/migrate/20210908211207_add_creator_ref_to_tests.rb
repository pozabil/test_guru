class AddCreatorRefToTests < ActiveRecord::Migration[6.1]
  def change
    add_reference :tests, :creator, null: false, foreign_key: { to_table: :users }
  end
end
