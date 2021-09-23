class CreateTestPassages < ActiveRecord::Migration[6.1]
  def change
    create_table :test_passages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.references :current_question, foreign_key: { to_table: :questions }
      t.integer :correct_questions, default: 0
      t.integer :current_question_number, default: 0

      t.timestamps
    end
  end
end
