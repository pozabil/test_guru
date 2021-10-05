class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :trackable

  has_many :created_tests, class_name: 'Test', foreign_key: 'creator_id', inverse_of: 'creator'
  has_many :test_passages
  has_many :tests, through: :test_passages

  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :before_save_downcase_email

  def test_list_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def before_save_downcase_email
    email.downcase!
  end
end
