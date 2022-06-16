class AddCorrectnessToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :correctness, :boolean, null: false, default: false
  end
end
