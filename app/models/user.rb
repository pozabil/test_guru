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
  has_many :created_badges, class_name: 'Badge', foreign_key: 'creator_id', inverse_of: 'creator'
  has_many :user_badges
  has_many :badges, through: :user_badges
  has_many :gists

  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :before_save_downcase_email

  def test_list_by_level(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def has_active_test?(test)
    test_passage(test).present? && !test_passage(test).completed?
  end

  def first_try?(test)
    test_passages.where(test_id: test.id).size == 1 ? true : false
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
