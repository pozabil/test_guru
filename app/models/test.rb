class Test < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', inverse_of: 'created_tests'
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :timer, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true, uniqueness: { scope: :level }

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :expert, -> { where(level: 5..Float::INFINITY) }
  scope :filter_by_category, ->(category) { joins(:category).where(categories: { title: category }) }

  def self.filtered_array_by_category(category)
    filter_by_category(category).order(title: :desc).distinct.pluck(:title)
  end

  def correct?
    return false if questions.size == 0
    !!questions.reverse_each { |q| return false if q.has_no_correct_answers? }
  end
end
