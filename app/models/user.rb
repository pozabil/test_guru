class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'creator_id', inverse_of: 'creator'
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :name, presence: true
  validates :login, presence: true
  validates :password, presence: true

  def test_list_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
