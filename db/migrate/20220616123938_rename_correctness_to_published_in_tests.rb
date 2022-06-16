class RenameCorrectnessToPublishedInTests < ActiveRecord::Migration[6.1]
  def change
    rename_column :tests, :correctness, :published
  end
end
