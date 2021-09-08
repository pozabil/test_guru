class AddCreatorIdToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :creator_id, :integer, null: false
  end
end
