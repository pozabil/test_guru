class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'creator_id', inverse_of: 'creator'
  has_and_belongs_to_many :tests

  validates :name, presence: true
  validates :login, presence: true
  validates :password, presence: true

  def test_list_by_level(level)
    tests.where(level: level)
  end
end
