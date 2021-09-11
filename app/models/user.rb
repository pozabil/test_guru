class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'creator_id', inverse_of: 'creator'
  has_and_belongs_to_many :tests

  def test_list_by_level(level)
    self.tests.where(level: level)
  end
end
