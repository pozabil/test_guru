class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'creator_id', inverse_of: 'creator'
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  before_save :before_save_downcase_email

  def test_list_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  private

  def before_save_downcase_email
    email.downcase!
  end
end
