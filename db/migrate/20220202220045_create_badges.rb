class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false, index: { unique: true }
      t.string :image_path
      t.string :description
      t.string :rule
      t.string :rule_condition

      t.timestamps
    end
  end
end
